#include <nitro.h>

// --------------------
// CONSTANTS
// --------------------

#ifdef SDK_ARM7

#define SND_THREAD_STACK_SIZE      1024
#define SND_THREAD_MESSAGE_BUFSIZE 8

#define SND_ALARM_COUNT_P1 0x10000

#endif

// --------------------
// VARIABLES
// --------------------

#ifdef SDK_ARM9

static OSMutex sSndMutex;

#else

static OSThread sndThread;
static u64 sndStack[SND_THREAD_STACK_SIZE / sizeof(u64)];
static OSAlarm sndAlarm;
static OSMessageQueue sndMesgQueue;
static OSMessage sndMesgBuffer[SND_THREAD_MESSAGE_BUFSIZE];

#endif

// --------------------
// FUNCTIONS
// --------------------

#ifdef SDK_ARM9
void SND_Init(void)
#else
void SND_Init(u32 threadPrio)
#endif
{
    {
        static BOOL initialized = FALSE;
        if (initialized)
            return;
        initialized = TRUE;
    }

#ifdef SDK_ARM9
    OS_InitMutex(&sSndMutex);
    SND_CommandInit();
    SND_AlarmInit();
#else
    // TODO: this
#endif
}

void SNDi_LockMutex(void)
{
#ifdef SDK_ARM9
    OS_LockMutex(&sSndMutex);
#endif
}

void SNDi_UnlockMutex(void)
{
#ifdef SDK_ARM9
    OS_UnlockMutex(&sSndMutex);
#endif
}