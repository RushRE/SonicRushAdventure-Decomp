#ifndef RUSH2_SOUNDTEST_H
#define RUSH2_SOUNDTEST_H

#include <game/system/task.h>
#include <game/graphics/sprite.h>
#include <game/graphics/background.h>
#include <game/graphics/paletteAnimation.h>
#include <game/graphics/drawReqTask.h>
#include <game/graphics/unknown2056570.h>
#include <game/input/touchField.h>
#include <game/text/fontFile.h>

// --------------------
// STRUCTS
// --------------------

typedef struct SoundTestSound_
{
    u8 unlockFlags;
    u8 sndArcID;
    u8 isStageArc;
    u8 type;
    u16 groupID;
    u16 seqArcNo;
    u16 seqID;
    u16 length;
    u32 offset;
} SoundTestSound;

typedef struct SoundTestHeader_
{
    u16 songCount;
    u16 field_2;
    u32 field_4;
    u32 field_8;
    u32 field_C;
    SoundTestSound sounds[1];
} SoundTestHeader;

typedef struct SoundTestAssets_
{
    void *sprUI;
    void *sprUILoc;
    void *bgBase;
    void *bgDrumValue;
    void *bgSpeaker;
    void *bgUpWaku;
    void *aniSpeakerPalette;
    void *jntAniKoala;
    void *mdlLog;
    void *drawState;
    void *mdlSea;
    void *jntAniSea;
    void *mdlKoala;
    void *bgSea;
    void *fntIpl;
} SoundTestAssets;

typedef struct SoundTest_
{
    u16 songCount;
    u16 selection;
    void *archive;
    SoundTestAssets assets;
    SoundTestHeader *soundTest;
    u32 *isSongUnlocked;
    FontFile fontFile;
    u16 curSongID;
    u16 curSndArcID;
    u16 curSndGroupID;
    BOOL isPlayingTrack;
    void *sndArcAsset;
    NNSSndStrmHandle strmHandle;
    int field_EC;
    void *sndCaptureBuffer;
    int field_F4;
    int targetPendulumAngle;
    int pendulumAngle;
    int volumeTracker[4];
    AnimatorMDL aniKoala;
    AnimatorMDL aniLog;
    AnimatorMDL aniSea;
    int timer;
    Unknown2056570 unknown2056570;
    s32 unknown2056570_data;
    u16 koalaAnim;
    u16 field_516;
    void (*stateDraw3D)(struct SoundTest_ *work);
    AnimatorSprite animators[12];
    PaletteAnimator aniPalette;
    TouchField touchField;
    TouchArea touchAreas[5];
    Unknown2056570 unknown2056570_2;
    s32 unknown2056570_2_data;
    s16 field_B50;
    s16 field_B52;
    s32 targetPendulumDrawAngle;
    void *field_B58;
    s32 field_B5C;
    s32 field_B60;
    s32 field_B64;
    s32 field_B68;
    u16 trackNumTarget[3];
    u16 field_B72;
    s32 trackNumPos[3];
    void (*state)(struct SoundTest_ *work);
    s32 miProcessor;
} SoundTest;

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED void SoundTest__Create(void);
NOT_DECOMPILED void SoundTest__Init(SoundTest *work);
NOT_DECOMPILED void SoundTest__SetupDisplay(void);
NOT_DECOMPILED void SoundTest__LoadAssets(SoundTest *work);
NOT_DECOMPILED void SoundTest__SetupAssets(SoundTest *work);
NOT_DECOMPILED void SoundTest__SetupBackgrounds(SoundTest *work);
NOT_DECOMPILED void SoundTest__Release(SoundTest *work);
NOT_DECOMPILED void SoundTest__ReleaseUnknown(SoundTest *work);
NOT_DECOMPILED void SoundTest__ReleaseAssets(SoundTest *work);
NOT_DECOMPILED void SoundTest__ReleaseModels(SoundTest *work);
NOT_DECOMPILED void SoundTest__ReleaseSprites(SoundTest *work);
NOT_DECOMPILED void SoundTest__Main_Init(void);
NOT_DECOMPILED void SoundTest__Main_Active(void);
NOT_DECOMPILED void SoundTest__Destructor(Task *task);
NOT_DECOMPILED void SoundTest__DisableDraw3D(SoundTest *work);
NOT_DECOMPILED void SoundTest__SetKoalaAnim(SoundTest *work, s32 anim);
NOT_DECOMPILED void SoundTest__StateDraw3D_DrawStage(SoundTest *work);
NOT_DECOMPILED void SoundTest__Func_215D6C4(SoundTest *work);
NOT_DECOMPILED void SoundTest__Func_215D844(SoundTest *work, s32 a2, s16 a3, s16 a4);
NOT_DECOMPILED void SoundTest__SetTrackNumber(SoundTest *work, s32 selection, BOOL instantChange);
NOT_DECOMPILED void SoundTest__AnimateTrackNumber(SoundTest *work);
NOT_DECOMPILED BOOL SoundTest__CheckDigitsIdle(SoundTest *work);
NOT_DECOMPILED void SoundTest__ProcessAnimations(SoundTest *work, BOOL flag);
NOT_DECOMPILED void SoundTest__Draw(SoundTest *work);
NOT_DECOMPILED void SoundTest__SetTrackInfo(SoundTest *work);
NOT_DECOMPILED void SoundTest__InitTouchAreas(SoundTest *work, BOOL setFlag);
NOT_DECOMPILED void SoundTest__ProcessInputLock(SoundTest *work);
NOT_DECOMPILED BOOL SoundTest__CheckRightBtnDown(SoundTest *work);
NOT_DECOMPILED BOOL SoundTest__CheckLeftBtnDown(SoundTest *work);
NOT_DECOMPILED void SoundTest__State_FadeIn(SoundTest *work);
NOT_DECOMPILED void SoundTest__State_FadeOut(SoundTest *work);
NOT_DECOMPILED void SoundTest__State_TrackStopped(SoundTest *work);
NOT_DECOMPILED void SoundTest__State_TrackPlaying(SoundTest *work);
NOT_DECOMPILED void SoundTest__InitAudio(SoundTest *work);
NOT_DECOMPILED void SoundTest__ReleaseAudio(SoundTest *work);
NOT_DECOMPILED void SoundTest__PlaySong(SoundTest *work, s32 trackID);
NOT_DECOMPILED BOOL SoundTest__IsPlayingTrack(SoundTest *work);
NOT_DECOMPILED void SoundTest__ReleaseSoundPlayers(SoundTest *work, BOOL releasePlayers);
NOT_DECOMPILED BOOL SoundTest__CheckTrackStopped(SoundTest *work);
NOT_DECOMPILED void SoundTest__CaptureCallback(u8 *bufferL, u8 *bufferR, u32 len, NNSSndCaptureFormat format, void *arg);
NOT_DECOMPILED void SoundTest__ProcessPendulumAngle(SoundTest *work);
NOT_DECOMPILED fx32 SoundTest__GetPendulumAngle(SoundTest *work);
NOT_DECOMPILED void SoundTest__SetTrackName(SoundTest *work, Unknown2056570 *unknown, const char *name, size_t nameLength, u16 flag);
NOT_DECOMPILED void SoundTest__SetAnimation2D(AnimatorSprite *animator, void *sprFile, u32 anim, u8 oamPriority, u8 oamOrder, u16 paletteRow);
NOT_DECOMPILED void SoundTest__Func_215EB80(SoundTest *work);
NOT_DECOMPILED BOOL SoundTest__CheckTouchAreaPress(TouchArea *area);
NOT_DECOMPILED BOOL SoundTest__CheckTouchAreaHold(TouchArea *area);
NOT_DECOMPILED s32 SoundTest__MoveSelectionRight(SoundTest *work, s32 selection);
NOT_DECOMPILED s32 SoundTest__MoveSelectionLeft(SoundTest *work, s32 selection);
NOT_DECOMPILED void SoundTest__DisableSleepOnFold(void);
NOT_DECOMPILED void SoundTest__EnableSleepOnFold(void);
NOT_DECOMPILED BOOL SoundTest__CheckSongUnlocked(u32 flags);
NOT_DECOMPILED u8 SoundTest__GetSongCount(SoundTestHeader *config, s32 id);
NOT_DECOMPILED u8 SoundTest__GetSongSndArcID(SoundTestHeader *config, s32 id);
NOT_DECOMPILED u8 SoundTest__GetSongIsStageArc(SoundTestHeader *config, s32 id);
NOT_DECOMPILED u8 SoundTest__GetSongType(SoundTestHeader *config, s32 id);
NOT_DECOMPILED u16 SoundTest__GetSongGroupID(SoundTestHeader *config, s32 id);
NOT_DECOMPILED u16 SoundTest__GetSongSeqArcNo(SoundTestHeader *config, s32 id);
NOT_DECOMPILED u16 SoundTest__GetSongSeqID(SoundTestHeader *config, s32 id);
NOT_DECOMPILED u8 SoundTest__GetSongUnlockFlags(SoundTestHeader *config, s32 id);
NOT_DECOMPILED const char* SoundTest__GetSongInfoName(SoundTestHeader *config, s32 id);
NOT_DECOMPILED u16 SoundTest__GetSongInfoLength(SoundTestHeader *config, s32 id);
NOT_DECOMPILED SoundTestSound *SoundTest__GetSongInfo(SoundTestHeader *config, s32 id);

#endif // RUSH2_SOUNDTEST_H