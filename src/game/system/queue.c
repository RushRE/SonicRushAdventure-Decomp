#include <game/system/queue.h>
#include <game/system/allocator.h>

// --------------------
// VARIABLES
// --------------------

static u16 sQueueItemCount;
static QueueEntry *sActiveQueueList[QUEUE_MAX_ACTIVE_SIZE];
static QueueEntry sReserveQueueList[QUEUE_MAX_ACTIVE_SIZE];

// --------------------
// FUNCTIONS
// --------------------

void InitQueueSystem(void)
{
    sQueueItemCount = 0;

    MI_CpuClear32(sReserveQueueList, sizeof(sReserveQueueList));

    for (s32 i = 0; i < QUEUE_MAX_ACTIVE_SIZE; i++)
    {
        sActiveQueueList[i] = &sReserveQueueList[i];
    }
}

QueueEntry *AllocQueueEntry(void)
{
    if (sQueueItemCount >= QUEUE_MAX_ACTIVE_SIZE)
        return HeapNull;

    QueueEntry *entry = sActiveQueueList[sQueueItemCount];
    sQueueItemCount++;

    return entry;
}

void FreeQueueEntry(QueueEntry *entry)
{
    if (HeapNull != entry)
    {
        sQueueItemCount--;
        sActiveQueueList[sQueueItemCount] = entry;
    }
}