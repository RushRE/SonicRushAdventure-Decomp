#include <sail/sailSea.h>
#include <sail/sailManager.h>
#include <game/object/obj.h>
#include <game/math/unknown2066510.h>

// --------------------
// ENUMS
// --------------------

enum SailSeaColor_
{
    SAILSEA_COLOR_SEA,
    SAILSEA_COLOR_SKY,
    SAILSEA_COLOR_FOG,
};
typedef s32 SailSeaColor;

enum SailSeaDrawMode_
{
    SAILSEA_DRAWMODE_SEA_BASE,
    SAILSEA_DRAWMODE_SEA_OVERLAY,
    SAILSEA_DRAWMODE_HORIZON_SEA,
};
typedef u8 SailSeaDrawMode;

// --------------------
// VARIABLES
// --------------------

static const u8 startVertexForShipType[SHIP_COUNT] = { 5, 4, 5, 4 };

// --------------------
// FUNCTION DECLS
// --------------------

static void SailSea_Destructor(Task *task);
static void SailSea_Main(void);

static void SailSea_LoadSprites(SailSea *work);
static void SailSea_ReleaseSprites(SailSea *work);

static void SailSea_InitVertices(SailSea *work);
static void SailSea_ProcessVertices(SailSea *work);

static void SailSea_Draw(SailSea *work);
static void SailSea_DrawSeaSegment(SailSea *work, SailSeaVertex *vertices, SailSeaDrawMode mode);
static void SailSea_DrawHorizon(SailSea *work);

static BOOL SailSea_Func_21603E8(VecFx32 *a1, VecFx32 *a2, VecFx32 *a3, VecFx32 *a4);
static GXRgb GetSailSeaColor(SailSeaColor type);

// --------------------
// FUNCTIONS
// --------------------

#include <nitro/code16.h>

SailSea *CreateSailSea(void)
{
    Task *task = TaskCreate(SailSea_Main, SailSea_Destructor, TASK_FLAG_NONE, TASK_PAUSELEVEL_0, TASK_PRIORITY_UPDATE_LIST_START + 0x800, TASK_GROUP(3), SailSea);

    SailSea *work = TaskGetWork(task, SailSea);
    TaskInitWork16(work);

    work->scrollAngleSize       = FLOAT_DEG_TO_IDX(4.21875);
    work->distanceAngleSize     = FLOAT_DEG_TO_IDX(22.5);
    work->seaOscillateAmplitude = 64;
    work->seaBaseOffsetY        = 48;
    work->seaHorizonOffsetY     = 72;

    switch (SailManager__GetShipType())
    {
        case SHIP_JET:
        case SHIP_HOVER:
            work->seaOscillateAmplitude >>= 2;
            break;

        case SHIP_BOAT:
        case SHIP_SUBMARINE:
            work->seaBaseOffsetY <<= 3;
            work->seaHorizonOffsetY = 0;
            break;
    }

    SailSea_LoadSprites(work);
    SailSea_InitVertices(work);

    return work;
}

void MoveSailSea(fx32 speed)
{
    SailSea *sea = SailManager__GetWork()->sea;

    VecFx32 move;
    move.x = FLOAT_TO_FX32(0.0);
    move.y = MultiplyFX(speed, FLOAT_TO_FX32(64.0));
    move.z = FLOAT_TO_FX32(0.0);

    FXMatrix43 matrix;
    MTX_RotZ43(matrix.nnMtx, SinFX(sea->voyageAngle), CosFX(sea->voyageAngle));
    MTX_MultVec43(&move, matrix.nnMtx, &move);

    VEC_Add(&sea->translation, &move, &sea->translation);
    sea->translation.x &= ~0xFF000000;
    sea->translation.y &= ~0xFF000000;
    sea->translation.z &= ~0xFF000000;
}

void SetSailSeaVoyageAngle(u16 angle)
{
    SailSea *sea = SailManager__GetWork()->sea;

    sea->voyageAngle = angle;
    sea->voyageAngle = (u16)sea->voyageAngle;
}

void SailSea_Destructor(Task *task)
{
    SailSea *work = TaskGetWork(task, SailSea);

    SailSea_ReleaseSprites(work);
}

void SailSea_Main(void)
{
    SailSea *work = TaskGetWorkCurrent(SailSea);

    // no need to process any vertices when in the submarine
    // this is due to the "sea" being the sea floor instead of the sea surface!
    if (SailManager__GetShipType() != SHIP_SUBMARINE)
    {
        SailSea_ProcessVertices(work);
    }

    SailSea_Draw(work);

    work->scrollTimer++;
}

void SailSea_LoadSprites(SailSea *work)
{
    AnimatorSprite3D *aniSeaTex1 = &work->aniSeaOverlayTex;

    void *sprSeaTexture = ObjDataLoad(NULL, "sb_sea_tex.bac", SailManager__GetArchive());

    // submarine doesn't have an overlay, so don't bother allocating it
    if (SailManager__GetShipType() != SHIP_SUBMARINE)
    {
        VRAMPixelKey vramPixels    = VRAMSystem__AllocTexture((u16)Sprite__GetTextureSize(sprSeaTexture), FALSE);
        VRAMPaletteKey vramPalette = VRAMSystem__AllocPalette(Sprite__GetPaletteSize(sprSeaTexture), FALSE);

        AnimatorSprite3D__Init(aniSeaTex1, ANIMATOR_FLAG_NONE, sprSeaTexture, 0, ANIMATOR_FLAG_NONE, vramPixels, vramPalette);
        AnimatorSprite3D__ProcessAnimationFast(aniSeaTex1);
    }

    AnimatorSprite3D *aniSeaTex = &work->aniSeaTex;
    VRAMPixelKey vramPalette    = VRAMSystem__AllocPalette(Sprite__GetPaletteSize(sprSeaTexture), FALSE);
    VRAMPaletteKey vramPixels   = VRAMSystem__AllocTexture((u16)Sprite__GetTextureSize(sprSeaTexture), FALSE);
    AnimatorSprite3D__Init(aniSeaTex, ANIMATOR_FLAG_NONE, sprSeaTexture, 0, ANIMATOR_FLAG_NONE, vramPixels, vramPalette);
    if (SailManager__GetShipType() != SHIP_SUBMARINE)
    {
        Animator2D__SetAnimation(&aniSeaTex->animatorSprite, 1);
    }
    AnimatorSprite3D__ProcessAnimationFast(aniSeaTex);
}

void SailSea_ReleaseSprites(SailSea *work)
{
    AnimatorSprite3D__Release(&work->aniSeaTex);
    AnimatorSprite3D__Release(&work->aniSeaOverlayTex);
}

void SailSea_InitVertices(SailSea *work)
{
    u16 x;
    u16 z;
    u16 vertex  = 0;
    u8 shipType = SailManager__GetShipType();

    // Init sea
    for (z = 0; z < 8; z++)
    {
        for (x = 0; x < 7; x++)
        {
            work->seaOverlayVertices[vertex].position.x = FX32_FROM_WHOLE(x - 3);
            work->seaOverlayVertices[vertex].position.y = 1 << 6;
            work->seaOverlayVertices[vertex].position.z = FX32_FROM_WHOLE(z - 6);
            work->seaOverlayVertices[vertex].texCoord.x = (x << 6) - (3 << 6);
            work->seaOverlayVertices[vertex].texCoord.y = (MATH_ABS(z - 8) - 2) << 6;

            work->seaBaseVertices[vertex].position = work->seaOverlayVertices[vertex].position;
            work->seaBaseVertices[vertex].texCoord = work->seaOverlayVertices[vertex].texCoord;
            work->seaBaseVertices[vertex].position.y -= work->seaBaseOffsetY;

            work->seaHorizonVertices[vertex].position = work->seaOverlayVertices[vertex].position;
            work->seaHorizonVertices[vertex].texCoord = work->seaOverlayVertices[vertex].texCoord;
            work->seaHorizonVertices[vertex].position.y += work->seaHorizonOffsetY;

            VEC_Set(&work->verticesUnknown[vertex], work->seaOverlayVertices[vertex].position.x, work->seaOverlayVertices[vertex].position.y,
                    work->seaOverlayVertices[vertex].position.z);

            vertex++;
        }
    }

    // Init horizon (sea)
    s16 posZ = FX_DivS32((s16)FX32_FROM_WHOLE((s32)(startVertexForShipType[shipType] + 1) - 6) + FLOAT_TO_FX32(6.0), 8);
    vertex   = 0;
    for (z = 0; z < 8; z++)
    {
        for (x = 0; x < 7; x++)
        {
            work->seaHorizonVertices[vertex].position.z = posZ * z - FLOAT_TO_FX32(6.0);

            vertex++;
        }
    }

    // Init horizon (sky)
    work->skyHorizon.vertices[0].position.x = -FLOAT_TO_FX32(4.0);
    work->skyHorizon.vertices[0].position.y = -FLOAT_TO_FX32(0.0390625);
    work->skyHorizon.vertices[0].position.z = work->seaOverlayVertices[0].position.z;

    work->skyHorizon.vertices[1].position.x = FLOAT_TO_FX32(4.0);
    work->skyHorizon.vertices[1].position.y = -FLOAT_TO_FX32(0.0390625);
    work->skyHorizon.vertices[1].position.z = work->seaOverlayVertices[0].position.z;

    work->skyHorizon.vertices[2].position.x = -FLOAT_TO_FX32(4.0);
    work->skyHorizon.vertices[2].position.y = FLOAT_TO_FX32(2.125);
    work->skyHorizon.vertices[2].position.z = work->seaOverlayVertices[0].position.z;

    work->skyHorizon.vertices[3].position.x = FLOAT_TO_FX32(4.0);
    work->skyHorizon.vertices[3].position.y = FLOAT_TO_FX32(2.125);
    work->skyHorizon.vertices[3].position.z = work->seaOverlayVertices[0].position.z;
}

void SailSea_ProcessVertices(SailSea *work)
{
    u16 x;
    u16 z;

    fx32 sin;
    fx32 seaPosZ;

    for (x = 0; x < 7; x++)
    {
        sin     = SinFX((s32)(u16)((work->scrollTimer * work->scrollAngleSize) + (x * work->distanceAngleSize)));
        seaPosZ = MultiplyFX(8, sin);

        for (z = 0; z < 8; z++)
        {
            if (z >= 3)
            {
                work->seaOverlayVertices[x + 7 * z].position.y = work->seaOscillateAmplitude + MultiplyFX(work->seaOscillateAmplitude, sin);
            }

            work->seaOverlayVertices[x + 7 * z].position.x += MultiplyFX(0x800 >> ((z >> 1) + 6), sin);
            work->seaOverlayVertices[x + 7 * z].position.z += seaPosZ;

            if (z >= 2)
            {
                work->seaBaseVertices[x + 7 * z].position.y = work->seaOscillateAmplitude + MultiplyFX(work->seaOscillateAmplitude, sin) - work->seaBaseOffsetY;
            }

            work->seaBaseVertices[x + 7 * z].position.x -= MultiplyFX(0x800 >> ((z >> 1) + 6), sin);
            work->seaBaseVertices[x + 7 * z].position.z -= seaPosZ;

            work->seaHorizonVertices[x + 7 * z].position.y = work->seaOverlayVertices[x + 7 * z].position.y;
            work->seaHorizonVertices[x + 7 * z].position.y += work->seaHorizonOffsetY;
        }
    }
}

void SailSea_Draw(SailSea *work)
{
    VecFx32 translation = { FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0) };
    VecFx32 scale       = { FLOAT_TO_FX32(16.0), FLOAT_TO_FX32(16.0), FLOAT_TO_FX32(16.0) };

    FXMatrix33 rotation;
    MTX_Identity33(rotation.nnMtx);

    NNS_G3dGlbSetBaseScale(&scale);
    MTX_RotY33(rotation.nnMtx, SinFX((s32)(u16)(work->voyageAngle + work->playerAngle)), CosFX((s32)(u16)(work->voyageAngle + work->playerAngle)));
    NNS_G3dGlbSetBaseRot(rotation.nnMtx);
    NNS_G3dGlbSetBaseTrans(&translation);

    FXMatrix43 mtxTexture;
    FXMatrix43 mtxTexTranslate;
    NNS_G3dGeMtxMode(GX_MTXMODE_TEXTURE);
    MTX_Identity43(mtxTexture.nnMtx);
    MTX_Identity43(mtxTexTranslate.nnMtx);
    MTX_RotZ43(mtxTexture.nnMtx, SinFX((s32)(u16)(work->voyageAngle + work->playerAngle)), CosFX((s32)(u16)(work->voyageAngle + work->playerAngle)));
    MTX_TransApply43(mtxTexTranslate.nnMtx, mtxTexTranslate.nnMtx, work->translation.x, work->translation.y, work->translation.z);
    MTX_Concat43(mtxTexture.nnMtx, mtxTexTranslate.nnMtx, mtxTexture.nnMtx);
    NNS_G3dGeLoadMtx43(mtxTexture.nnMtx);

    NNS_G3dGeMtxMode(GX_MTXMODE_POSITION);
    NNS_G3dGlbFlushVP();

    // draw horizon (sea)
    NNS_G3dGeTexImageParam(GX_TEXFMT_NONE, GX_TEXGEN_NONE, GX_TEXSIZE_S8, GX_TEXSIZE_T8, GX_TEXREPEAT_NONE, GX_TEXFLIP_NONE, GX_TEXPLTTCOLOR0_TRNS, 0x0000);
    SailSea_DrawSeaSegment(work, work->seaHorizonVertices, SAILSEA_DRAWMODE_HORIZON_SEA);

    // draw sea (overlay)
    if (SailManager__GetShipType() != SHIP_SUBMARINE)
    {
        NNS_G3dGePolygonAttr(GX_LIGHTMASK_NONE, GX_POLYGONMODE_MODULATE, GX_CULL_BACK, 31, GX_COLOR_FROM_888(0x60),
                             GX_POLYGON_ATTR_MISC_XLU_DEPTH_UPDATE | GX_POLYGON_ATTR_MISC_FOG);
        NNS_G3dGeTexPlttBase(VRAMKEY_TO_KEY(work->aniSeaOverlayTex.animatorSprite.vramPalette) & 0x1FFFF, GX_TEXFMT_PLTT16);
        NNS_G3dGeTexImageParam(GX_TEXFMT_PLTT16, GX_TEXGEN_TEXCOORD, GX_TEXSIZE_S64, GX_TEXSIZE_T64, GX_TEXREPEAT_ST, GX_TEXFLIP_NONE, GX_TEXPLTTCOLOR0_USE,
                               VRAMKEY_TO_KEY(work->aniSeaOverlayTex.animatorSprite.vramPixels) & 0x7FFFF);
        SailSea_DrawSeaSegment(work, work->seaOverlayVertices, SAILSEA_DRAWMODE_SEA_OVERLAY);
    }

    // draw sea (base)
    NNS_G3dGePolygonAttr(GX_LIGHTMASK_NONE, GX_POLYGONMODE_MODULATE, GX_CULL_BACK, 31, GX_COLOR_FROM_888(0xFF), GX_POLYGON_ATTR_MISC_FOG);
    NNS_G3dGeTexPlttBase(VRAMKEY_TO_KEY(work->aniSeaTex.animatorSprite.vramPalette) & 0x1FFFF, GX_TEXFMT_PLTT16);
    NNS_G3dGeTexImageParam(GX_TEXFMT_PLTT16, GX_TEXGEN_TEXCOORD, GX_TEXSIZE_S64, GX_TEXSIZE_T64, GX_TEXREPEAT_ST, GX_TEXFLIP_NONE, GX_TEXPLTTCOLOR0_USE,
                           VRAMKEY_TO_KEY(work->aniSeaTex.animatorSprite.vramPixels) & 0x7FFFF);
    SailSea_DrawSeaSegment(work, work->seaBaseVertices, SAILSEA_DRAWMODE_SEA_BASE);

    // draw horizon (sky)
    NNS_G3dGePolygonAttr(GX_LIGHTMASK_NONE, GX_POLYGONMODE_MODULATE, GX_CULL_BACK, 31, GX_COLOR_FROM_888(0xFF), GX_POLYGON_ATTR_MISC_NONE);
    NNS_G3dGeTexImageParam(GX_TEXFMT_NONE, GX_TEXGEN_NONE, GX_TEXSIZE_S8, GX_TEXSIZE_T8, GX_TEXREPEAT_NONE, GX_TEXFLIP_NONE, GX_TEXPLTTCOLOR0_TRNS, 0x0000);
    SailSea_DrawHorizon(work);

    // configure clear color
    NNS_G3dGePolygonAttr(GX_LIGHTMASK_01, GX_POLYGONMODE_MODULATE, GX_CULL_BACK, 0, GX_COLOR_FROM_888(0xFF), GX_POLYGON_ATTR_MISC_NONE);
    G3X_SetClearColor(GetSailSeaColor(SAILSEA_COLOR_SKY), GX_COLOR_FROM_888(0xFF), 0x7FFF, 0, TRUE);
}

void SailSea_DrawSeaSegment(SailSea *work, SailSeaVertex *vertices, SailSeaDrawMode mode)
{
    // not sure what they did here, but both of these are required to match
    s32 v     = 0;
    u16 v_u16 = 0;

    u8 vertexCountTableForShip[SHIP_COUNT][7] = {
        [SHIP_JET]       = { 7, 7, 5, 5, 5, 3, 3 },
        [SHIP_BOAT]      = { 7, 7, 7, 7, 5, 5, 5 },
        [SHIP_HOVER]     = { 7, 7, 5, 5, 5, 3, 3 },
        [SHIP_SUBMARINE] = { 7, 7, 7, 7, 5, 5, 5 },
    };

    u8 shipType = SailManager__GetShipType();

    switch (mode)
    {
        case SAILSEA_DRAWMODE_HORIZON_SEA:
            NNS_G3dGeColor(GetSailSeaColor(SAILSEA_COLOR_FOG));
            break;

        default:
            NNS_G3dGeColor(GetSailSeaColor(SAILSEA_COLOR_SEA));
            break;
    }

    if (mode == SAILSEA_DRAWMODE_SEA_OVERLAY)
    {
        v     = startVertexForShipType[shipType];
        v_u16 = startVertexForShipType[shipType];
    }

    while (v < 7)
    {
        u8 *vertexCountTable = vertexCountTableForShip[shipType];

        u16 firstVertex;
        u16 lastVertex;
        if (mode == SAILSEA_DRAWMODE_HORIZON_SEA)
        {
            s32 alpha = GX_COLOR_FROM_888(0xFF) - 4 * v;

            if (alpha <= GX_COLOR_FROM_888(0x00))
                return;

            NNS_G3dGePolygonAttr(GX_LIGHTMASK_NONE, GX_POLYGONMODE_MODULATE, GX_CULL_BACK, 32, alpha, GX_POLYGON_ATTR_MISC_NONE);

            firstVertex = 0;
            lastVertex  = 7;
        }
        else
        {
            firstVertex = (7 - vertexCountTable[v]) >> 1;
            lastVertex  = firstVertex + vertexCountTable[v];
        }

        if ((lastVertex - firstVertex) <= 1)
            break;

        u32 drawList[7 * 7];
        u16 op = 0;
        for (; firstVertex < lastVertex; firstVertex++)
        {
            u32 vertex = firstVertex + 7 * v;

            drawList[op] = GX_PACK_OP(G3OP_TEXCOORD, G3OP_VTX_16, G3OP_TEXCOORD, G3OP_VTX_16);
            op++;

            drawList[op] = GX_PACK_TEXCOORD_PARAM(FX32_FROM_WHOLE(vertices[vertex].texCoord.x), FX32_FROM_WHOLE(vertices[vertex].texCoord.y)); // G3OP_TEXCOORD
            op++;

            drawList[op] = GX_PACK_VTXXY_PARAM(vertices[vertex].position.x, vertices[vertex].position.y); // G3OP_VTX_16 (part 1)
            op++;

            drawList[op] = GX_FX16PAIR(vertices[vertex].position.z, 0); // G3OP_VTX_16 (part 2)
            op++;

            drawList[op] = GX_PACK_TEXCOORD_PARAM(FX32_FROM_WHOLE(vertices[vertex + 7].texCoord.x), FX32_FROM_WHOLE(vertices[vertex + 7].texCoord.y)); // G3OP_TEXCOORD
            op++;

            drawList[op] = GX_PACK_VTXXY_PARAM(vertices[vertex + 7].position.x, vertices[vertex + 7].position.y); // G3OP_VTX_16 (part 1)
            op++;

            drawList[op] = GX_FX16PAIR(vertices[vertex + 7].position.z, 0); // G3OP_VTX_16 (part 2)
            op++;
        }

        NNS_G3dGeBegin(GX_BEGIN_QUAD_STRIP);
        NNS_G3dGeSendDL(drawList, 4 * op);
        NNS_G3dGeEnd();

        v_u16++;
        v = v_u16;
    }
}

void SailSea_DrawHorizon(SailSea *work)
{
    SailSeaHorizonSky *skyHorizon = &work->skyHorizon;

    u16 op = 0;
    u32 drawList[10];

    // draw gradient starting with the fog color at the horizon line and fading into the sky color

    drawList[op] = GX_PACK_OP(G3OP_BEGIN, G3OP_COLOR, G3OP_VTX_10, G3OP_VTX_10);
    op++;
    drawList[op] = GX_PACK_BEGIN_PARAM(GX_BEGIN_QUAD_STRIP); // G3OP_BEGIN
    op++;
    drawList[op] = GX_PACK_COLOR_PARAM(GetSailSeaColor(SAILSEA_COLOR_FOG)); // G3OP_COLOR
    op++;
    drawList[op] = GX_PACK_VTX10_PARAM(skyHorizon->vertices[0].position.x, skyHorizon->vertices[0].position.y, skyHorizon->vertices[0].position.z); // G3OP_VTX_10
    op++;
    drawList[op] = GX_PACK_VTX10_PARAM(skyHorizon->vertices[1].position.x, skyHorizon->vertices[1].position.y, skyHorizon->vertices[1].position.z); // G3OP_VTX_10
    op++;

    drawList[op] = GX_PACK_OP(G3OP_COLOR, G3OP_VTX_10, G3OP_VTX_10, G3OP_END);
    op++;
    drawList[op] = GX_PACK_COLOR_PARAM(GetSailSeaColor(SAILSEA_COLOR_SKY)); // G3OP_COLOR
    op++;
    drawList[op] = GX_PACK_VTX10_PARAM(skyHorizon->vertices[2].position.x, skyHorizon->vertices[2].position.y, skyHorizon->vertices[2].position.z); // G3OP_VTX_10
    op++;
    drawList[op] = GX_PACK_VTX10_PARAM(skyHorizon->vertices[3].position.x, skyHorizon->vertices[3].position.y, skyHorizon->vertices[3].position.z); // G3OP_VTX_10
    op++;
    drawList[op] = G3OP_NOP; // G3OP_END
    op++;

    NNS_G3dGeSendDL(drawList, op * sizeof(u32));
}

NONMATCH_FUNC BOOL SailSea_Func_21603E8(VecFx32 *position, VecFx32 *a2, VecFx32 *a3, VecFx32 *a4)
{
    // https://decomp.me/scratch/Cv2Jw -> 97.44%
    // minor register issues
#ifdef NON_MATCHING
    SailSea *sea;
    s32 x;
    s32 z;

    SailManager *manager = SailManager__GetWork();
    sea                  = manager->sea;

    x = position->x;
    z = position->z;

    x = FX32_TO_WHOLE(FX_Div(x + FLOAT_TO_FX32(48.0), FLOAT_TO_FX32(16.0)));
    z = FX32_TO_WHOLE(FX_Div(z + FLOAT_TO_FX32(96.0), FLOAT_TO_FX32(16.0)));

    if (x < 0)
        x = 0;
    if (z < 0)
        z = 0;

    if (x >= 6)
        x = 5;
    if (z >= 7)
        z = 6;

    u32 vertex = x + 7 * z;
    VEC_Set(a2, sea->verticesUnknown[vertex].x << 4, sea->seaBaseVertices[vertex].position.y << 4, sea->verticesUnknown[vertex].z << 4);

    vertex = x + 7 * (z + 1);
    VEC_Set(a3, sea->verticesUnknown[vertex].x << 4, sea->seaBaseVertices[vertex].position.y << 4, sea->verticesUnknown[vertex].z << 4);

    vertex = (x + 1) + 7 * z;
    VEC_Set(a4, sea->verticesUnknown[vertex].x << 4, sea->seaBaseVertices[vertex].position.y << 4, sea->verticesUnknown[vertex].z << 4);

    return TRUE;
#else
    // clang-format off
	push {r4, r5, r6, r7, lr}
	sub sp, #0x14
	mov r5, r0
	mov r6, r1
	str r2, [sp, #0x10]
	str r3, [sp]
	bl SailManager__GetWork
	add r0, #0x94
	ldr r4, [r0, #0]
	ldr r0, [r5, #8]
	ldr r1, [r5, #0]
	str r0, [sp, #4]
	mov r0, #3
	lsl r0, r0, #0x10
	add r0, r1, r0
	mov r1, #1
	lsl r1, r1, #0x10
	bl FX_Div
	asr r5, r0, #0xc
	mov r1, #6
	ldr r0, [sp, #4]
	lsl r1, r1, #0x10
	add r0, r0, r1
	mov r1, #1
	lsl r1, r1, #0x10
	bl FX_Div
	asr r3, r0, #0xc
	cmp r5, #0
	bge _0216042A
	mov r5, #0
_0216042A:
	cmp r3, #0
	bge _02160430
	mov r3, #0
_02160430:
	cmp r5, #6
	blt _02160436
	mov r5, #5
_02160436:
	cmp r3, #7
	blt _0216043C
	mov r3, #6
_0216043C:
	mov r0, #7
	mul r0, r3
	str r0, [sp, #8]
	add r2, r5, r0
	mov r0, #0xc
	mul r0, r2
	ldr r1, =0x000006E8
	add r0, r4, r0
	mov ip, r0
	ldr r0, [r0, r1]
	mov r7, r1
	lsl r0, r0, #4
	str r0, [sp, #0xc]
	mov r0, #0xa
	mul r0, r2
	add r2, r4, r0
	ldr r0, =0x0000025A
	sub r7, #8
	ldrsh r0, [r2, r0]
	mov r2, ip
	ldr r2, [r2, r7]
	lsl r0, r0, #4
	lsl r2, r2, #4
	str r2, [r6]
	str r0, [r6, #4]
	ldr r0, [sp, #0xc]
	add r2, r3, #1
	str r0, [r6, #8]
	mov r0, #7
	mul r0, r2
	add r0, r5, r0
	mov r2, #0xc
	mov r6, #0xa
	mul r2, r0
	mul r6, r0
	add r2, r4, r2
	ldr r3, [r2, r1]
	ldr r0, =0x0000025A
	add r6, r4, r6
	ldrsh r0, [r6, r0]
	mov r6, r1
	sub r6, #8
	ldr r2, [r2, r6]
	lsl r0, r0, #4
	lsl r6, r2, #4
	ldr r2, [sp, #0x10]
	lsl r3, r3, #4
	str r6, [r2]
	str r0, [r2, #4]
	mov r0, r2
	str r3, [r0, #8]
	add r2, r5, #1
	ldr r0, [sp, #8]
	mov r5, #0xa
	add r0, r2, r0
	mov r2, #0xc
	mul r2, r0
	add r2, r4, r2
	ldr r3, [r2, r1]
	mul r5, r0
	sub r1, #8
	ldr r1, [r2, r1]
	ldr r0, =0x0000025A
	add r4, r4, r5
	ldrsh r0, [r4, r0]
	lsl r2, r1, #4
	ldr r1, [sp]
	lsl r0, r0, #4
	str r2, [r1]
	str r0, [r1, #4]
	lsl r3, r3, #4
	mov r0, r1
	str r3, [r0, #8]
	mov r0, #1
	add sp, #0x14
	pop {r4, r5, r6, r7, pc}

// clang-format on
#endif
}

fx32 GetSailSeaSurfacePosition(VecFx32 *position)
{
    Unknown206703C unknown1;
    Unknown2066510 unknown2;
    VecFx32 a2;
    VecFx32 a3;
    VecFx32 a4;
    VecFx32 surfacePosition;

    if (SailSea_Func_21603E8(position, &a2, &a3, &a4))
    {
        surfacePosition = *position;
        surfacePosition.y += FLOAT_TO_FX32(1.0);

        Unknown2066510__Func_2066F88(position, &surfacePosition, &unknown2);
        Unknown2066510__Func_2066FD0(&unknown1, &a2, &a3, &a4);
        Unknown2066510__Func_20670F8(&unknown1, &unknown2, &surfacePosition);

        return surfacePosition.y;
    }

    return 0;
}

GXRgb GetSailSeaColor(SailSeaColor type)
{
    fx32 dayR;
    fx32 dayG;
    fx32 dayB;

    fx32 r;
    fx32 g;
    fx32 b;

    fx32 nightR;
    fx32 nightG;
    fx32 nightB;

    SailManager *manager;
    SailVoyageManager *voyageManager;

    manager       = SailManager__GetWork();
    voyageManager = SailManager__GetWork()->voyageManager;

    switch (type)
    {
        case SAILSEA_COLOR_SEA:
        default:
            if (SailManager__GetShipType() != SHIP_SUBMARINE)
            {
                dayR = FLOAT_TO_FX32(GX_COLOR_FROM_888(0x28));
                dayG = FLOAT_TO_FX32(GX_COLOR_FROM_888(0xC0));
                dayB = FLOAT_TO_FX32(GX_COLOR_FROM_888(0xFF));

                nightR = FLOAT_TO_FX32(GX_COLOR_FROM_888(0x80));
                nightG = FLOAT_TO_FX32(GX_COLOR_FROM_888(0x90));
                nightB = FLOAT_TO_FX32(GX_COLOR_FROM_888(0xE8));

                r = FLOAT_TO_FX32(GX_COLOR_FROM_888(0x18));
                g = FLOAT_TO_FX32(GX_COLOR_FROM_888(0x70));
                b = FLOAT_TO_FX32(GX_COLOR_FROM_888(0xA0));
            }
            else
            {
                dayR = FLOAT_TO_FX32(GX_COLOR_FROM_888(0xFF));
                dayG = FLOAT_TO_FX32(GX_COLOR_FROM_888(0xFF));
                dayB = FLOAT_TO_FX32(GX_COLOR_FROM_888(0xFF));

                nightR = FLOAT_TO_FX32(GX_COLOR_FROM_888(0xE0));
                nightG = FLOAT_TO_FX32(GX_COLOR_FROM_888(0xE0));
                nightB = FLOAT_TO_FX32(GX_COLOR_FROM_888(0xE0));

                r = FLOAT_TO_FX32(GX_COLOR_FROM_888(0xC0));
                g = FLOAT_TO_FX32(GX_COLOR_FROM_888(0xC0));
                b = FLOAT_TO_FX32(GX_COLOR_FROM_888(0xC0));
            }

            if (voyageManager != NULL)
            {
                if (voyageManager->field_BC != 0)
                {
                    nightG += voyageManager->field_BC;
                    dayG += voyageManager->field_BC;
                    g += voyageManager->field_BC;

                    dayR += voyageManager->field_BC;
                    nightR += voyageManager->field_BC;
                    r += voyageManager->field_BC;

                    if (dayG > FLOAT_TO_FX32(GX_COLOR_FROM_888(0xFF)))
                        dayG = FLOAT_TO_FX32(GX_COLOR_FROM_888(0xFF));

                    if (nightG > FLOAT_TO_FX32(GX_COLOR_FROM_888(0xFF)))
                        nightG = FLOAT_TO_FX32(GX_COLOR_FROM_888(0xFF));

                    if (g > FLOAT_TO_FX32(GX_COLOR_FROM_888(0xFF)))
                        g = FLOAT_TO_FX32(GX_COLOR_FROM_888(0xFF));

                    if (dayR > FLOAT_TO_FX32(GX_COLOR_FROM_888(0xFF)))
                        dayR = FLOAT_TO_FX32(GX_COLOR_FROM_888(0xFF));

                    if (nightR > FLOAT_TO_FX32(GX_COLOR_FROM_888(0xFF)))
                        nightR = FLOAT_TO_FX32(GX_COLOR_FROM_888(0xFF));

                    if (r > FLOAT_TO_FX32(GX_COLOR_FROM_888(0xFF)))
                        r = FLOAT_TO_FX32(GX_COLOR_FROM_888(0xFF));
                }
            }
            break;

        case SAILSEA_COLOR_SKY:
            if (SailManager__GetShipType() != SHIP_SUBMARINE)
            {
                dayR = FLOAT_TO_FX32(GX_COLOR_FROM_888(0x40));
                dayG = FLOAT_TO_FX32(GX_COLOR_FROM_888(0x40));
                dayB = FLOAT_TO_FX32(GX_COLOR_FROM_888(0xFF));

                nightR = FLOAT_TO_FX32(GX_COLOR_FROM_888(0x80));
                nightG = FLOAT_TO_FX32(GX_COLOR_FROM_888(0xD8));
                nightB = FLOAT_TO_FX32(GX_COLOR_FROM_888(0xFF));

                r = FLOAT_TO_FX32(GX_COLOR_FROM_888(0x20));
                g = FLOAT_TO_FX32(GX_COLOR_FROM_888(0x40));
                b = FLOAT_TO_FX32(GX_COLOR_FROM_888(0x60));
            }
            else
            {
                dayR = FLOAT_TO_FX32(GX_COLOR_FROM_888(0x40));
                dayG = FLOAT_TO_FX32(GX_COLOR_FROM_888(0x80));
                dayB = FLOAT_TO_FX32(GX_COLOR_FROM_888(0xC0));

                nightR = FLOAT_TO_FX32(GX_COLOR_FROM_888(0x80));
                nightG = FLOAT_TO_FX32(GX_COLOR_FROM_888(0x60));
                nightB = FLOAT_TO_FX32(GX_COLOR_FROM_888(0x90));

                r = FLOAT_TO_FX32(GX_COLOR_FROM_888(0x30));
                g = FLOAT_TO_FX32(GX_COLOR_FROM_888(0x50));
                b = FLOAT_TO_FX32(GX_COLOR_FROM_888(0x90));
            }
            break;

        case SAILSEA_COLOR_FOG:
            if (SailManager__GetShipType() != SHIP_SUBMARINE)
            {
                dayR = FLOAT_TO_FX32(GX_COLOR_FROM_888(0xFF));
                dayG = FLOAT_TO_FX32(GX_COLOR_FROM_888(0xFF));
                dayB = FLOAT_TO_FX32(GX_COLOR_FROM_888(0xFF));

                nightR = FLOAT_TO_FX32(GX_COLOR_FROM_888(0xFF));
                nightG = FLOAT_TO_FX32(GX_COLOR_FROM_888(0x90));
                nightB = FLOAT_TO_FX32(GX_COLOR_FROM_888(0x20));

                r = FLOAT_TO_FX32(GX_COLOR_FROM_888(0x60));
                g = FLOAT_TO_FX32(GX_COLOR_FROM_888(0x70));
                b = FLOAT_TO_FX32(GX_COLOR_FROM_888(0x80));
            }
            else
            {
                dayR = FLOAT_TO_FX32(GX_COLOR_FROM_888(0x30));
                dayG = FLOAT_TO_FX32(GX_COLOR_FROM_888(0x30));
                dayB = FLOAT_TO_FX32(GX_COLOR_FROM_888(0x30));

                nightR = FLOAT_TO_FX32(GX_COLOR_FROM_888(0x20));
                nightG = FLOAT_TO_FX32(GX_COLOR_FROM_888(0x20));
                nightB = FLOAT_TO_FX32(GX_COLOR_FROM_888(0x20));

                r = FLOAT_TO_FX32(GX_COLOR_FROM_888(0x20));
                g = FLOAT_TO_FX32(GX_COLOR_FROM_888(0x20));
                b = FLOAT_TO_FX32(GX_COLOR_FROM_888(0x20));
            }
            break;
    }

    if (manager->daytimeTimer > SECONDS_TO_FRAMES(12.5))
    {
        if (manager->daytimeTimer > SECONDS_TO_FRAMES(12.5) && manager->daytimeTimer <= SECONDS_TO_FRAMES(17.5))
        {
            u16 percent = 13 * (manager->daytimeTimer - SECONDS_TO_FRAMES(12.5));

            r = ObjAlphaSet(dayR, r, percent);
            g = ObjAlphaSet(dayG, g, percent);
            b = ObjAlphaSet(dayB, b, percent);
        }
        else if (manager->daytimeTimer <= SECONDS_TO_FRAMES(42.5))
        {
            r = dayR;
            g = dayG;
            b = dayB;
        }
        else if (manager->daytimeTimer > SECONDS_TO_FRAMES(42.5) && manager->daytimeTimer <= SECONDS_TO_FRAMES(45.0))
        {
            u16 percent = 27 * (manager->daytimeTimer - SECONDS_TO_FRAMES(42.5));

            r = ObjAlphaSet(nightR, dayR, percent);
            g = ObjAlphaSet(nightG, dayG, percent);
            b = ObjAlphaSet(nightB, dayB, percent);
        }
        else if (manager->daytimeTimer <= SECONDS_TO_FRAMES(45.0))
        {
            r = nightR;
            g = nightG;
            b = nightB;
        }
        else if (manager->daytimeTimer > SECONDS_TO_FRAMES(45.0) && manager->daytimeTimer <= SECONDS_TO_FRAMES(50.0))
        {
            u16 percent = 13 * (manager->daytimeTimer - SECONDS_TO_FRAMES(45.0));

            r = ObjAlphaSet(r, nightR, percent);
            g = ObjAlphaSet(g, nightG, percent);
            b = ObjAlphaSet(b, nightB, percent);
        }
    }

    if (manager->cloudyness != 0)
    {
        u16 cloudyness = (manager->cloudyness << 7);
        if (cloudyness > FLOAT_TO_FX32(1.0))
            cloudyness = FLOAT_TO_FX32(1.0);

        s32 change = ObjAlphaSet(FLOAT_TO_FX32(4.0), FLOAT_TO_FX32(0.0), cloudyness);

        r -= change;
        g -= change;
        b -= change;

        if (r < FLOAT_TO_FX32(4.0))
            r = FLOAT_TO_FX32(4.0);

        if (g < FLOAT_TO_FX32(4.0))
            g = FLOAT_TO_FX32(4.0);

        if (b < FLOAT_TO_FX32(4.0))
            b = FLOAT_TO_FX32(4.0);
    }

    return GX_RGB(FX32_TO_WHOLE(r), FX32_TO_WHOLE(g), FX32_TO_WHOLE(b));
}

#include <nitro/codereset.h>