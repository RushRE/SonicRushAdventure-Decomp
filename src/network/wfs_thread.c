#include <game/network/wfs.h>
#include <nitro/wbt.h>

// --------------------
// STRUCTS
// --------------------

typedef struct WFSiTask_
{
    u8 stack[0x400];
    OSThread thread[1];
    OSThreadQueue threadQueue[1];
} WFSiTask;

// --------------------
// VARIABLES
// --------------------

extern WFSWork *gWFSWorker;

static WFSiTask sThreadTask;

// --------------------
// FUNCTION DECLS
// --------------------

extern void WFSi_SendOpenAck(WFSParentContext *parentContext, WFSiFileList *target, BOOL ret);
extern void WFSi_FromBusyToFree(WFSParentContext *parentContext, WFSiFileList *target);

void WFSi_NotifyBusy(void);
static void WFSi_TaskThread(void *arg);
void WFSi_CreateTaskThread(void);
void WFSi_EndTaskThread(void);

// --------------------
// FUNCTIONS
// --------------------

void WFSi_NotifyBusy(void)
{
    OS_WakeupThreadDirect(sThreadTask.thread);
}

void WFSi_TaskThread(void *arg)
{
    WFSiTask *const task           = (WFSiTask *)arg;
    WFSParentContext *const parent = gWFSWorker->context.parent;

    int i;

    while (TRUE)
    {
        WFSiFileList *fileList = NULL;

        OSIntrMode bak_cpsr = OS_DisableInterrupts();
        while ((fileList = parent->busy_list) == NULL)
        {
            if (gWFSWorker->state == WFS_STATE_STOP)
            {
                OS_RestoreInterrupts(bak_cpsr);
                return;
            }

            OS_SleepThread(NULL);
        }

        OS_RestoreInterrupts(bak_cpsr);

        if (fileList->stat == WFS_FILE_STAT_OPENING)
        {
            FS_CreateFileFromRom(&fileList->file, fileList->rom_src, fileList->rom_len);
            for (i = 0; i < WFS_FILE_CACHE_LINE; ++i)
            {
                fileList->page[i] = WFS_FILE_CACHE_SIZE * i;
                FS_ReadFile(&fileList->file, fileList->cache[i], WFS_FILE_CACHE_SIZE);
            }
            fileList->ack_seq   = 0;
            fileList->last_page = WFS_FILE_CACHE_LINE - 1;
            fileList->busy_page = WFS_FILE_CACHE_LINE;

            OSIntrMode bak_cpsr = OS_DisableInterrupts();
            WFSi_SendOpenAck(parent, fileList, TRUE);
            OS_RestoreInterrupts(bak_cpsr);
        }
        else
        {
            FS_CloseFile(&fileList->file);

            OSIntrMode bak_cpsr = OS_DisableInterrupts();
            WFSi_FromBusyToFree(parent, fileList);
            OS_RestoreInterrupts(bak_cpsr);
        }
    }
}

void WFSi_CreateTaskThread(void)
{
    WFSiTask *const task = &sThreadTask;

    OS_InitThreadQueue(task->threadQueue);
    OS_CreateThread(task->thread, WFSi_TaskThread, task, task->stack + sizeof(task->stack), sizeof(task->stack), 15);
    OS_WakeupThreadDirect(task->thread);
}

#if defined(__MWERKS__)
#pragma optimize_for_size on
#endif
void WFSi_EndTaskThread(void)
{
    WFSiTask *const task = &sThreadTask;

    while (!OS_IsThreadTerminated(task->thread))
    {
        OS_WakeupThreadDirect(task->thread);
        OS_JoinThread(task->thread);
    }
}
#if defined(__MWERKS__)
#pragma optimize_for_size off
#endif