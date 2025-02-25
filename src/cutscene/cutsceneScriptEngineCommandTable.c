#include <cutscene/cutsceneScript.h>

// --------------------
// VARIABLES
// --------------------

static const CutsceneScriptEngineCommand scriptUnknownCommands[] = { NULL };

static const CutsceneScriptEngineCommand scriptTextCommands[] = { CutsceneScript_TextCommand_Execute };

static const CutsceneScriptEngineCommand scriptBackgroundCommands[] = {
    CutsceneScript_BackgroundCommand_LoadBackgroundHandle,        CutsceneScript_BackgroundCommand_ReleaseBackgroundHandle,
    CutsceneScript_BackgroundCommand_ReleaseAllBackgroundHandles, CutsceneScript_BackgroundCommand_SetBackgroundPosition,
    CutsceneScript_BackgroundCommand_SetBackgroundHandleFlag,     CutsceneScript_BackgroundCommand_SetBackgroundFlag,
};

static const CutsceneScriptEngineCommand scriptSystemCommands[] = {
    NULL,
    CutsceneScript_SystemCommand_GetPadInputMask,
    CutsceneScript_SystemCommand_GetTouchPos,
    CutsceneScript_SystemCommand_GetGameLanguage,
    CutsceneScript_SystemCommand_GetVCount,
    CutsceneScript_SystemCommand_GetBrightness,
};

static const CutsceneScriptEngineCommand scriptFileSystemCommands[] = {
    CutsceneScript_FileSystemCommand_AllocFileHandle,          CutsceneScript_FileSystemCommand_ReleaseFileHandle,
    CutsceneScript_FileSystemCommand_ReleaseAllFileHandles,    CutsceneScript_FileSystemCommand_MountArchive,
    CutsceneScript_FileSystemCommand_UnmountArchive,           CutsceneScript_FileSystemCommand_SetNextFileCompressedFlag,
    CutsceneScript_FileSystemCommand_SetNextFileASyncLoadFlag,
};

static const CutsceneScriptEngineCommand scriptModelCommands[] = {
    CutsceneScript_ModelCommand_AllocModelHandle,       CutsceneScript_ModelCommand_ReleaseModelHandle,    CutsceneScript_ModelCommand_ReleaseModelHandles,
    CutsceneScript_ModelCommand_LoadModelResource,      CutsceneScript_ModelCommand_LoadModelAnimResource, CutsceneScript_ModelCommand_SetModelScale,
    CutsceneScript_ModelCommand_SetModelRotation,       CutsceneScript_ModelCommand_SetModelPosition,      CutsceneScript_ModelCommand_SetModelPosition2,
    CutsceneScript_ModelCommand_SetModelVisible,        CutsceneScript_ModelCommand_SetModelLoopFlag,      CutsceneScript_ModelCommand_SetModelCanLoopFlag,
    CutsceneScript_ModelCommand_SetModelRenderCallback, CutsceneScript_ModelCommand_LoadDrawState,         CutsceneScript_ModelCommand_CheckModelAnimFinished,
};

static const CutsceneScriptEngineCommand scriptSoundCommands[] = {
    CutsceneScript_SoundCommand_LoadSndArc,      CutsceneScript_SoundCommand_SetVolume,         CutsceneScript_SoundCommand_MoveVolume,
    CutsceneScript_SoundCommand_LoadSndArcGroup, CutsceneScript_SoundCommand_LoadSndArcSeq,     CutsceneScript_SoundCommand_LoadSndArcSeqArc,
    CutsceneScript_SoundCommand_LoadSndArcBank,  CutsceneScript_SoundCommand_PlayTrack,         CutsceneScript_SoundCommand_PlayTrackEx,
    CutsceneScript_SoundCommand_PlaySequence,    CutsceneScript_SoundCommand_PlaySequenceEx,    CutsceneScript_SoundCommand_PlayVoiceClip,
    CutsceneScript_SoundCommand_PlayVoiceClipEx, CutsceneScript_SoundCommand_FadeSeq,           CutsceneScript_SoundCommand_FadeAllSeq,
    CutsceneScript_SoundCommand_SetTrackPan,     CutsceneScript_SoundCommand_SetPlayerPriority,
};

static const CutsceneScriptEngineCommand scriptSpriteCommands[] = {
    CutsceneScript_SpriteCommand_AllocSpriteHandle,
    CutsceneScript_SpriteCommand_ReleaseSpriteHandle,
    CutsceneScript_SpriteCommand_ReleaseAllSpriteHandles,
    CutsceneScript_SpriteCommand_LoadSpriteResource,
    CutsceneScript_SpriteCommand_SetAnimation,
    CutsceneScript_SpriteCommand_SetSpritePosition,
    CutsceneScript_SpriteCommand_SetSpriteVisible,
    CutsceneScript_SpriteCommand_SetSpriteLoopFlag,
    CutsceneScript_SpriteCommand_SetSpriteFlip,
    CutsceneScript_SpriteCommand_SetSpritePriority,
    CutsceneScript_SpriteCommand_SetSpriteType,
    CutsceneScript_SpriteCommand_SetSpriteFlag,
    CutsceneScript_SpriteCommand_GetSpritePosition,
    CutsceneScript_SpriteCommand_GetSpritePalette,
    CutsceneScript_SpriteCommand_AddTouchArea,
    CutsceneScript_SpriteCommand_RemoveTouchArea,
    CutsceneScript_SpriteCommand_GetTouchAreaResponseFlags,
};

static const CutsceneScriptEngineCommand scriptScreenCommands[] = {
    CutsceneScript_ScreenCommand_InitVRAMSystem,
    CutsceneScript_ScreenCommand_SetupBGBank,
    CutsceneScript_ScreenCommand_SetupOBJBank,
    CutsceneScript_ScreenCommand_SetupBGExtPalBank,
    CutsceneScript_ScreenCommand_SetupOBJExtPalBank,
    CutsceneScript_ScreenCommand_SetupTextureBank,
    CutsceneScript_ScreenCommand_SetupTexturePalBank,
    CutsceneScript_ScreenCommand_SetGraphicsMode,
    CutsceneScript_ScreenCommand_SetBackgroundControlText,
    CutsceneScript_ScreenCommand_SetBackgroundControlAffine,
    CutsceneScript_ScreenCommand_SetCurrentDisplay,
    CutsceneScript_ScreenCommand_ProcessFadeTask,
    CutsceneScript_ScreenCommand_CreateFadeTask,
    CutsceneScript_ScreenCommand_SetVisiblePlane,
    CutsceneScript_ScreenCommand_SetBackgroundPriority,
    CutsceneScript_ScreenCommand_SetBlendPlane,
    CutsceneScript_ScreenCommand_SetBlendEffect,
    CutsceneScript_ScreenCommand_SetBlendAlpha,
    CutsceneScript_ScreenCommand_SetBlendCoefficient,
    CutsceneScript_ScreenCommand_SetWindowVisible,
    CutsceneScript_ScreenCommand_SetWindowPlane,
    CutsceneScript_ScreenCommand_SetWindowPosition,
    CutsceneScript_ScreenCommand_Unknown,
    CutsceneScript_ScreenCommand_SetCapture,
    CutsceneScript_ScreenCommand_ShakeScreen1,
    CutsceneScript_ScreenCommand_ShakeScreen2,
};

CutsceneScriptEngineCommand *CutsceneScript_EngineCommandTable[] = {
    (CutsceneScriptEngineCommand *)scriptSystemCommands, (CutsceneScriptEngineCommand *)scriptScreenCommands,     (CutsceneScriptEngineCommand *)scriptFileSystemCommands,
    (CutsceneScriptEngineCommand *)scriptSpriteCommands, (CutsceneScriptEngineCommand *)scriptBackgroundCommands, (CutsceneScriptEngineCommand *)scriptModelCommands,
    (CutsceneScriptEngineCommand *)scriptSoundCommands,  (CutsceneScriptEngineCommand *)scriptTextCommands,       (CutsceneScriptEngineCommand *)scriptUnknownCommands,
};