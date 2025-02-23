#include <cutscene/cutsceneScript.h>

// --------------------
// VARIABLES
// --------------------

static const CutsceneScriptEngineCommand scriptUnknownCommands[] = { NULL };

static const CutsceneScriptEngineCommand scriptTextCommands[] = { CutsceneScript__TextFunc__Execute };

static const CutsceneScriptEngineCommand scriptBackgroundCommands[] = {
    CutsceneScript__BackgroundCommand__LoadBBG,      CutsceneScript__BackgroundCommand__Func_2154494, CutsceneScript__BackgroundCommand__Func_21544BC,
    CutsceneScript__BackgroundCommand__Func_2154504, CutsceneScript__BackgroundCommand__Func_215455C, CutsceneScript__BackgroundCommand__Func_21545B0,
};

static const CutsceneScriptEngineCommand scriptSystemCommands[] = {
    NULL,
    CutsceneScript__SystemCommand__GetPadInputMask,
    CutsceneScript__SystemCommand__GetTouchPos,
    CutsceneScript__SystemCommand__GetGameLanguage,
    CutsceneScript__SystemCommand__GetVCount,
    CutsceneScript__SystemCommand__GetBrightness,
};

static const CutsceneScriptEngineCommand scriptFileSystemCommands[] = {
    CutsceneScript__FileSystemCommand__Func_2153C90, CutsceneScript__FileSystemCommand__Func_2153CE8,   CutsceneScript__FileSystemCommand__Func_2153D10,
    CutsceneScript__FileSystemCommand__MountArchive, CutsceneScript__FileSystemCommand__UnmountArchive, CutsceneScript__FileSystemCommand__Func_2153DAC,
    CutsceneScript__FileSystemCommand__Func_2153DDC,
};

static const CutsceneScriptEngineCommand scriptModelCommands[] = {
    CutsceneScript__ModelCommand__LoadMDL,      CutsceneScript__ModelCommand__Func_2154684,  CutsceneScript__ModelCommand__Func_21546AC, CutsceneScript__ModelCommand__LoadMDL2,
    CutsceneScript__ModelCommand__LoadAniMDL,   CutsceneScript__ModelCommand__Func_215483C,  CutsceneScript__ModelCommand__Func_21548A8, CutsceneScript__ModelCommand__Func_21549E4,
    CutsceneScript__ModelCommand__Func_2154A50, CutsceneScript__ModelCommand__Func_2154ABC,  CutsceneScript__ModelCommand__Func_2154B10, CutsceneScript__ModelCommand__Func_2154B64,
    CutsceneScript__ModelCommand__Func_2154BF8, CutsceneScript__ModelCommand__LoadDrawState, CutsceneScript__ModelCommand__Func_2154CCC,
};

static const CutsceneScriptEngineCommand scriptSoundCommands[] = {
    CutsceneScript__SoundCommand_LoadSndArc,      CutsceneScript__SoundCommand_SetVolume,         CutsceneScript__SoundCommand_MoveVolume,
    CutsceneScript__SoundCommand_LoadSndArcGroup, CutsceneScript__SoundCommand_LoadSndArcSeq,     CutsceneScript__SoundCommand_LoadSndArcSeqArc,
    CutsceneScript__SoundCommand_LoadSndArcBank,  CutsceneScript__SoundCommand_PlayTrack,         CutsceneScript__SoundCommand_PlayTrackEx,
    CutsceneScript__SoundCommand_PlaySequence,    CutsceneScript__SoundCommand_PlaySequenceEx,    CutsceneScript__SoundCommand_PlayVoiceClip,
    CutsceneScript__SoundCommand_PlayVoiceClipEx, CutsceneScript__SoundCommand_FadeSeq,           CutsceneScript__SoundCommand_FadeAllSeq,
    CutsceneScript__SoundCommand_SetTrackPan,     CutsceneScript__SoundCommand_SetPlayerPriority,
};

static const CutsceneScriptEngineCommand scriptSpriteCommands[] = {
    CutsceneScript__SpriteCommand__LoadSprite,        CutsceneScript__SpriteCommand__Func_2153EB4,      CutsceneScript__SpriteCommand__Func_2153EDC,
    CutsceneScript__SpriteCommand__LoadSprite2,       CutsceneScript__SpriteCommand__SetAnimation,      CutsceneScript__SpriteCommand__SetSpritePosition,
    CutsceneScript__SpriteCommand__SetSpriteVisible,  CutsceneScript__SpriteCommand__SetSpriteLoopFlag, CutsceneScript__SpriteCommand__SetSpriteFlip,
    CutsceneScript__SpriteCommand__SetSpritePriority, CutsceneScript__SpriteCommand__SetSpriteType,     CutsceneScript__SpriteCommand__Func_2154240,
    CutsceneScript__SpriteCommand__GetSpritePosition, CutsceneScript__SpriteCommand__GetSpritePalette,  CutsceneScript__SpriteCommand__Func_2154320,
    CutsceneScript__SpriteCommand__Func_2154384,      CutsceneScript__SpriteCommand__Func_21543AC,
};

static const CutsceneScriptEngineCommand scriptScreenCommands[] = {
    CutsceneScript__ScreenCommand__InitVRAMSystem,
    CutsceneScript__ScreenCommand__SetupBGBank,
    CutsceneScript__ScreenCommand__SetupOBJBank,
    CutsceneScript__ScreenCommand__SetupBGExtPalBank,
    CutsceneScript__ScreenCommand__SetupOBJExtPalBank,
    CutsceneScript__ScreenCommand__SetupTextureBank,
    CutsceneScript__ScreenCommand__SetupTexturePalBank,
    CutsceneScript__ScreenCommand__SetGraphicsMode,
    CutsceneScript__ScreenCommand__SetBackgroundControlText,
    CutsceneScript__ScreenCommand__SetBackgroundControlAffine,
    CutsceneScript__ScreenCommand__SetCurrentDisplay,
    CutsceneScript__ScreenCommand__ProcessFadeTask,
    CutsceneScript__ScreenCommand__CreateFadeTask,
    CutsceneScript__ScreenCommand__SetVisiblePlane,
    CutsceneScript__ScreenCommand__SetBackgroundPriority,
    CutsceneScript__ScreenCommand__SetBlendPlane,
    CutsceneScript__ScreenCommand__SetBlendEffect,
    CutsceneScript__ScreenCommand__SetBlendAlpha,
    CutsceneScript__ScreenCommand__SetBlendCoefficient,
    CutsceneScript__ScreenCommand__SetWindowVisible,
    CutsceneScript__ScreenCommand__SetWindowPlane,
    CutsceneScript__ScreenCommand__SetWindowPosition,
    CutsceneScript__ScreenCommand__Unknown,
    CutsceneScript__ScreenCommand__SetCapture,
    CutsceneScript__ScreenCommand__ShakeScreen1,
    CutsceneScript__ScreenCommand__ShakeScreen2,
};

CutsceneScriptEngineCommand *CutsceneScript__EngineCommandTable[] = {
    (CutsceneScriptEngineCommand *)scriptSystemCommands, (CutsceneScriptEngineCommand *)scriptScreenCommands,     (CutsceneScriptEngineCommand *)scriptFileSystemCommands,
    (CutsceneScriptEngineCommand *)scriptSpriteCommands, (CutsceneScriptEngineCommand *)scriptBackgroundCommands, (CutsceneScriptEngineCommand *)scriptModelCommands,
    (CutsceneScriptEngineCommand *)scriptSoundCommands,  (CutsceneScriptEngineCommand *)scriptTextCommands,       (CutsceneScriptEngineCommand *)scriptUnknownCommands,
};