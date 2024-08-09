#ifndef RUSH_STAGEASSETS_H
#define RUSH_STAGEASSETS_H

#include <global.h>

// --------------------
// TYPES
// --------------------

typedef struct GMS_GAMEDAT_LOAD_CONTEXT_ GMS_GAMEDAT_LOAD_CONTEXT;

// --------------------
// ENUMS
// --------------------

enum GameDataFileReqStatus_
{
    GAMEDATA_FILEREQ_STATUS_ACTIVE,
    GAMEDATA_FILEREQ_STATUS_COMPLETE,
    GAMEDATA_FILEREQ_STATUS_ERROR,
};
typedef u32 GameDataFileReqStatus;

enum GameDataFileReqMode_
{
    GAMEDATA_FILEREQ_MODE_0,
    GAMEDATA_FILEREQ_MODE_1,
    GAMEDATA_FILEREQ_MODE_2,
};
typedef u32 GameDataFileReqMode;

// --------------------
// STRUCTS
// --------------------

typedef struct GMS_GAMEDAT_LOAD_DATA_
{
    const char *path;
    void *(*alloc)(const char *path);
    void (*proc_pre)(GMS_GAMEDAT_LOAD_CONTEXT *context);
    void (*proc_post)(AsyncFileWork *file, const char *path);
} GMS_GAMEDAT_LOAD_DATA;

typedef struct GMS_GAMEDAT_LOAD_INFO_
{
    const GMS_GAMEDAT_LOAD_DATA *dataTable;
    u32 count;
} GMS_GAMEDAT_LOAD_INFO;

struct GMS_GAMEDAT_LOAD_CONTEXT_
{
    GameDataFileReqStatus status;
    GameDataFileReqMode mode;
    char path[0x40];
    u32 characterID;
    u16 stageID;
    u16 fileID;
    u8 field_50;
    u8 field_51;
    u8 field_52;
    u8 field_53;
    u8 field_54;
    u8 field_55;
    u16 connectBitmap;
    u16 progress;
    AsyncFileWork *file;
};

// --------------------
// VARIABLES
// --------------------

extern void *gameArchiveSound;
extern void *gameArchiveCommon;
extern void *gameArchiveStage;

// --------------------
// FUNCTIONS
// --------------------

void InitGameDataLoadContext(GameDataFileReqMode mode);
GameDataFileReqStatus LoadStageCommonAssets(void);
GameDataFileReqStatus LoadStageAssets(void);
void ReleaseStageCommonArchives(void);
void FlushStageArea(void);
void BuildStageCommonAssets(void);
void BuildStageArea(void);
void ReleaseStageCommonAssets(void);
void ReleaseStageArea(void);
void ReleaseStageAudioWork(void);
void *GetStageDrawState(void);
void InitStageLightConfig(void);
void InitStageEdgeConfig(void);

#endif // RUSH_STAGEASSETS_H