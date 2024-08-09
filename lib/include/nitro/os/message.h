#ifndef NITRO_OS_MESSAGE_H
#define NITRO_OS_MESSAGE_H

#include <nitro/os/thread.h>
#include <nitro/os/context.h>
#include <nitro/types.h>
#include <nitro/os/common/message_shared.h>

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// FUNCTIONS
// --------------------

void OS_InitMessageQueue(OSMessageQueue *mq, OSMessage *msgArray, s32 msgCount);
BOOL OS_SendMessage(OSMessageQueue *mq, OSMessage msg, s32 flags);
BOOL OS_ReceiveMessage(OSMessageQueue *mq, OSMessage *msg, s32 flags);
BOOL OS_JamMessage(OSMessageQueue *mq, OSMessage msg, s32 flags);
BOOL OS_ReadMessage(OSMessageQueue *mq, OSMessage *msg, s32 flags);

#ifdef __cplusplus
}
#endif

#endif // NITRO_OS_MESSAGE_H
