#include <game/system/queue.h>
#include <game/system/allocator.h>

// --------------------
// VARIABLES
// --------------------

u16 queueItemCount;
QueueEntry *activeQueueList[QUEUE_MAX_ACTIVE_SIZE];
QueueEntry reserveQueueList[QUEUE_MAX_ACTIVE_SIZE];

// --------------------
// FUNCTIONS
// --------------------

void InitQueueSystem(void)
{
    queueItemCount = 0;

    MI_CpuClear32(reserveQueueList, sizeof(reserveQueueList));

    for (s32 i = 0; i < QUEUE_MAX_ACTIVE_SIZE; i++)
    {
        activeQueueList[i] = &reserveQueueList[i];
    }
}

QueueEntry *AllocQueueEntry(void)
{
    if (queueItemCount >= QUEUE_MAX_ACTIVE_SIZE)
        return HeapNull;

    QueueEntry *entry = activeQueueList[queueItemCount];
    queueItemCount++;

    return entry;
}

void FreeQueueEntry(QueueEntry *entry)
{
    if (HeapNull != entry)
    {
        queueItemCount--;
        activeQueueList[queueItemCount] = entry;
    }
}