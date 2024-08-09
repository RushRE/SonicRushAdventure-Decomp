#include <nitro.h>

// --------------------
// FUNCTIONS
// --------------------

void OS_InitMessageQueue(OSMessageQueue *mq, OSMessage *msgArray, s32 msgCount)
{
    OS_InitThreadQueue(&mq->queueSend);
    OS_InitThreadQueue(&mq->queueReceive);
    mq->msgArray   = msgArray;
    mq->msgCount   = msgCount;
    mq->firstIndex = 0;
    mq->usedCount  = 0;
}

BOOL OS_SendMessage(OSMessageQueue *mq, OSMessage msg, s32 flags)
{
    OSIntrMode enabled;
    s32 lastIndex;

    enabled = OS_DisableInterrupts();

    while (mq->msgCount <= mq->usedCount)
    {
        if (!(flags & OS_MESSAGE_BLOCK))
        {
            (IGNORE_RETURN) OS_RestoreInterrupts(enabled);
            return FALSE;
        }
        else
        {
            OS_SleepThread(&mq->queueSend);
        }
    }

    lastIndex               = (mq->firstIndex + mq->usedCount) % mq->msgCount;
    mq->msgArray[lastIndex] = msg;
    mq->usedCount++;

    OS_WakeupThread(&mq->queueReceive);

    (IGNORE_RETURN) OS_RestoreInterrupts(enabled);
    return TRUE;
}

BOOL OS_ReceiveMessage(OSMessageQueue *mq, OSMessage *msg, s32 flags)
{
    OSIntrMode enabled;

    enabled = OS_DisableInterrupts();

    while (mq->usedCount == 0)
    {
        if (!(flags & OS_MESSAGE_BLOCK))
        {
            (IGNORE_RETURN) OS_RestoreInterrupts(enabled);
            return FALSE;
        }
        else
        {
            OS_SleepThread(&mq->queueReceive);
        }
    }

    if (msg != NULL)
    {
        *msg = mq->msgArray[mq->firstIndex];
    }

    mq->firstIndex = (mq->firstIndex + 1) % mq->msgCount;
    mq->usedCount--;

    OS_WakeupThread(&mq->queueSend);

    (IGNORE_RETURN) OS_RestoreInterrupts(enabled);
    return TRUE;
}

BOOL OS_JamMessage(OSMessageQueue *mq, OSMessage msg, s32 flags)
{
    OSIntrMode enabled;

    enabled = OS_DisableInterrupts();

    while (mq->msgCount <= mq->usedCount) // check for full queue
    {
        if (!(flags & OS_MESSAGE_BLOCK))
        {
            (void)OS_RestoreInterrupts(enabled);
            return FALSE;
        }
        else
        {
            // Yield
            OS_SleepThread(&mq->queueSend);
        }
    }

    // Store message at the front
    mq->firstIndex               = (mq->firstIndex + mq->msgCount - 1) % mq->msgCount;
    mq->msgArray[mq->firstIndex] = msg;
    mq->usedCount++;

    // Wakeup receiving threads if any
    OS_WakeupThread(&mq->queueReceive);

    (IGNORE_RETURN) OS_RestoreInterrupts(enabled);
    return TRUE;
}

BOOL OS_ReadMessage(OSMessageQueue *mq, OSMessage *msg, s32 flags)
{
    OSIntrMode enabled;

    enabled = OS_DisableInterrupts();

    while (mq->usedCount == 0)
    {
        if (!(flags & OS_MESSAGE_BLOCK))
        {
            (IGNORE_RETURN) OS_RestoreInterrupts(enabled);
            return FALSE;
        }
        else
        {
            OS_SleepThread(&mq->queueReceive);
        }
    }

    if (msg != NULL)
    {
        *msg = mq->msgArray[mq->firstIndex];
    }

    (IGNORE_RETURN) OS_RestoreInterrupts(enabled);
    return TRUE;
}