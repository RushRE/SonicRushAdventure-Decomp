#ifndef NITRO_SND_COMMON_WORK_H
#define NITRO_SND_COMMON_WORK_H

#include <nitro/snd/common/exchannel.h>
#include <nitro/snd/common/seq.h>
#include <nitro/snd/common/capture.h>
#include <nitro/snd/common/alarm.h>

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// CONSTANTS
// --------------------

#define SND_DEFAULT_VARIABLE -1

// --------------------
// STRUCTS
// --------------------

typedef struct SNDWork
{
    SNDExChannel channel[SND_CHANNEL_NUM];
    SNDPlayer player[SND_PLAYER_NUM];
    SNDTrack track[SND_TRACK_NUM];
    SNDAlarm alarm[SND_ALARM_NUM];
} SNDWork;

typedef struct SNDSharedWork
{
    vu32 finishCommandTag;
    vu32 playerStatus;
    vu16 channelStatus;
    vu16 captureStatus;
    vu32 padding[5];
    struct
    {
        vs16 variable[SND_PLAYER_VARIABLE_NUM];
        vu32 tickCounter;
    } player[SND_PLAYER_NUM];
    vs16 globalVariable[SND_GLOBAL_VARIABLE_NUM];
} SNDSharedWork;

typedef struct SNDSpReg
{
    u32 chCtrl[SND_CHANNEL_NUM];
} SNDSpReg;

typedef struct SNDDriverInfo
{
    SNDWork work;
    u32 chCtrl[SND_CHANNEL_NUM];
    SNDWork *workAddress;
    u32 lockedChannels;
    u32 padding[6];
} SNDDriverInfo;

typedef struct SNDChannelInfo
{
    BOOL activeFlag : 1;
    BOOL lockFlag : 1;

    u16 volume;
    u8 pan;
    u8 pad_;

    SNDEnvStatus envStatus;
} SNDChannelInfo;

typedef struct SNDPlayerInfo
{
    BOOL activeFlag : 1;
    BOOL pauseFlag : 1;

    u16 trackBitMask;
    u16 tempo;
    u8 volume;
    u8 pad_;
    u16 pad2_;
} SNDPlayerInfo;

typedef struct SNDTrackInfo
{
    u16 prgNo;
    u8 volume;
    u8 volume2;
    s8 pitchBend;
    u8 bendRange;
    u8 pan;
    s8 transpose;
    u8 pad_;
    u8 chCount;
    u8 channel[SND_CHANNEL_NUM];
} SNDTrackInfo;

// --------------------
// VARIABLES FUNCTIONS
// --------------------

extern SNDSharedWork *SNDi_SharedWork;

#ifdef SDK_ARM7

extern SNDWork SNDi_Work;

#endif // SDK_ARM7

// --------------------
// FUNCTIONS
// --------------------

s16 SND_GetPlayerLocalVariable(int playerNo, int varNo);
s16 SND_GetPlayerGlobalVariable(int varNo);
u32 SND_GetPlayerTickCounter(int playerNo);

u32 SND_GetPlayerStatus(void);
u32 SND_GetChannelStatus(void);
u32 SND_GetCaptureStatus(void);

BOOL SND_ReadChannelInfo(const SNDDriverInfo *driverInfo, int chNo, SNDChannelInfo *chInfo);
BOOL SND_ReadPlayerInfo(const SNDDriverInfo *driverInfo, int playerNo, SNDPlayerInfo *playerInfo);
BOOL SND_ReadTrackInfo(const SNDDriverInfo *driverInfo, int playerNo, int trackNo, SNDTrackInfo *trackInfo);

#ifdef SDK_ARM7

void SND_SetPlayerLocalVariable(int playerNo, int varNo, s16 var);
void SND_SetPlayerGlobalVariable(int varNo, s16 var);
void SND_UpdateSharedWork(void);

#endif // SDK_ARM7

u32 SNDi_GetFinishedCommandTag(void);

#ifdef SDK_ARM9

void SNDi_InitSharedWork(SNDSharedWork *work);

#endif // SDK_ARM9

#ifdef __cplusplus
}
#endif

#endif // NITRO_SND_COMMON_WORK_H
