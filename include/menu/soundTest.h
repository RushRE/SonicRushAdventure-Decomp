#ifndef RUSH_SOUNDTEST_H
#define RUSH_SOUNDTEST_H

#include <game/system/task.h>
#include <game/graphics/sprite.h>
#include <game/graphics/background.h>
#include <game/graphics/paletteAnimation.h>
#include <game/graphics/swapBuffer3D.h>
#include <game/graphics/unknown2056570.h>
#include <game/input/touchField.h>
#include <game/text/fontFile.h>

// --------------------
// ENUMS
// --------------------

enum SoundTestSongType_
{
    SOUNDTESTSONG_TYPE_BGM,
    SOUNDTESTSONG_TYPE_SFX,
    SOUNDTESTSONG_TYPE_VOICE_CLIP,
    SOUNDTESTSONG_TYPE_STREAM,
};
typedef u8 SoundTestSongType;

// --------------------
// STRUCTS
// --------------------

typedef struct SoundTestSound_
{
    u8 unlockFlags;
    u8 sndArcID;
    u8 isStageArc;
    SoundTestSongType type;
    u16 groupID;
    u16 seqArcNo;
    u16 seqID;
    u16 length;
    u32 titleOffset;
} SoundTestSound;

typedef struct SoundTestHeader_
{
    u16 songCount;
    u32 unknown1; // unused?
    u32 unknown2; // unused?
    u32 unknown3; // unused?
    SoundTestSound sounds[1];
} SoundTestHeader;

typedef struct SoundTestAssets_
{
    // allow each array index to be named
    union
    {
        struct
        {
            void *sprUI;
            void *sprUILoc;
        };

        void *uiSprites[2];
    };

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
    BOOL *isSongUnlocked;
    FontFile fontFile;
    u16 curSongID;
    u16 curSndArcID;
    u16 curSndGroupID;
    BOOL isPlayingTrack;
    void *sndArcAsset;
    NNSSndStrmHandle strmHandle;
    s32 audioUnknown1;
    void *sndCaptureBuffer;
    s32 audioUnknown2;
    s32 targetPendulumAngle;
    s32 pendulumAngle;
    s32 volumeTracker[4];
    AnimatorMDL aniKoala;
    AnimatorMDL aniLog;
    AnimatorMDL aniSea;
    u32 timer;
    Unknown2056570 activeTrackTextRenderer;
    void *activeTrackTextRenderer_data;
    u16 koalaAnim;
    void (*stateDraw3D)(struct SoundTest_ *work);

    // allow each array index to be named
    union
    {
        struct
        {
            AnimatorSprite aniTrackNumDisplay;
            AnimatorSprite aniPlayButton;
            AnimatorSprite aniStopButton;
            AnimatorSprite aniRightButton;
            AnimatorSprite aniLeftButton;
            AnimatorSprite aniTitleEdgeL;
            AnimatorSprite aniTitleEdgeR;
            AnimatorSprite aniPendulumBG;
            AnimatorSprite aniPendulumFG;
            AnimatorSprite aniPendulum;
            AnimatorSprite aniControlsLabel;
            AnimatorSprite aniBackButton;
        };

        AnimatorSprite animators[12];
    };

    PaletteAnimator aniPalette;
    TouchField touchField;

    // allow each array index to be named
    union
    {
        struct
        {
            TouchArea touchAreaPlayButton;
            TouchArea touchAreaStopButton;
            TouchArea touchAreaRightButton;
            TouchArea touchAreaLeftButton;
            TouchArea touchAreaBackButton;
        };

        TouchArea touchAreas[5];
    };

    Unknown2056570 selectedTrackTextRenderer;
    void *selectedTrackTextRenderer_data;
    u16 btnRightRepeatTimer;
    u16 btnLeftRepeatTimer;
    s32 targetPendulumDrawAngle;
    void *drumPixels[3];
    BOOL queueDrumPixels;
    void *unknownPixels;
    u16 trackNumTarget[3];
    s32 trackNumPos[3];
    void (*state)(struct SoundTest_ *work);
    MIProcessor miProcessor;
} SoundTest;

// --------------------
// FUNCTIONS
// --------------------

void CreateSoundTest(void);

#endif // RUSH_SOUNDTEST_H