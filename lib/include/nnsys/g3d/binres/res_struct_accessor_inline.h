#ifndef NNSG3D_BINRES_RES_STRUCT_ACCESSOR_INLINE_H
#define NNSG3D_BINRES_RES_STRUCT_ACCESSOR_INLINE_H

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// FUNCTIONS
// --------------------

// Dictionaries
NNS_G3D_RES_INLINE const NNSG3dResName *NNS_G3dGetResNameByIdx(const NNSG3dResDict *dict, u32 idx)
{
    NNSG3dResDictEntryHeader *hdr;

    if (dict != NULL && idx < dict->numEntry)
    {
        hdr = (NNSG3dResDictEntryHeader *)((u8 *)dict + dict->ofsEntry);
        return (NNSG3dResName *)((u8 *)hdr + hdr->ofsName + sizeof(NNSG3dResName) * idx);
    }
    else
    {
        return NULL;
    }
}

NNS_G3D_RES_INLINE void *NNS_G3dGetResDataByIdx(const NNSG3dResDict *dict, u32 idx)
{
    NNSG3dResDictEntryHeader *hdr;

    if (dict != NULL && idx < dict->numEntry)
    {
        hdr = (NNSG3dResDictEntryHeader *)((u8 *)dict + dict->ofsEntry);
        return (void *)(&hdr->data[0] + hdr->sizeUnit * idx);
    }
    else
    {
        return NULL;
    }
}

NNS_G3D_RES_INLINE void *NNS_G3dGetResDataByIdx_Fast(void *resource, NNSG3dResDict *dict, u32 idx)
{
    NNSG3dResDictEntryHeader *hdr = (NNSG3dResDictEntryHeader*)((u8*)dict + dict->ofsEntry);
    return (void *)((u8 *)resource + *(u32 *)(&hdr->data[0] + hdr->sizeUnit * idx));
}

NNS_G3D_RES_INLINE void *NNS_G3dGetMdlDataByIdx_Fast(NNSG3dResMdlSet *mdlResource, u32 idx)
{
    return NNS_G3dGetResDataByIdx_Fast(mdlResource, &mdlResource->dict, idx);
}

// NNSG3dResTex
NNS_G3D_RES_INLINE const NNSG3dResName *NNS_G3dGetTexNameByIdx(const NNSG3dResTex *tex, u32 idx)
{
    if (tex)
        return NNS_G3dGetResNameByIdx(&tex->dict, idx);
    else
        return NULL;
}

NNS_G3D_RES_INLINE int NNS_G3dGetTexIdxByName(const NNSG3dResTex *tex, const NNSG3dResName *name)
{
    if (tex)
        return NNS_G3dGetResDictIdxByName(&tex->dict, name);
    else
        return -1;
}

NNS_G3D_RES_INLINE const NNSG3dResName *NNS_G3dGetPlttNameByIdx(const NNSG3dResTex *tex, u32 idx)
{
    const NNSG3dResDict *dict;

    if (tex && tex->plttInfo.ofsDict != 0)
    {
        dict = (const NNSG3dResDict *)((u8 *)tex + tex->plttInfo.ofsDict);
        return NNS_G3dGetResNameByIdx(dict, idx);
    }
    else
    {
        return NULL;
    }
}

NNS_G3D_RES_INLINE int NNS_G3dGetPlttIdxByName(const NNSG3dResTex *tex, const NNSG3dResName *name)
{
    const NNSG3dResDict *dict;

    if (tex && tex->plttInfo.ofsDict != 0)
    {
        dict = (const NNSG3dResDict *)((u8 *)tex + tex->plttInfo.ofsDict);
        return NNS_G3dGetResDictIdxByName(dict, name);
    }
    else
    {
        return -1;
    }
}

// NNSG3dResNodeInfo
NNS_G3D_RES_INLINE const NNSG3dResName *NNS_G3dGetNodeNameByIdx(const NNSG3dResNodeInfo *nodeinfo, u32 idx)
{
    if (nodeinfo)
        return NNS_G3dGetResNameByIdx(&nodeinfo->dict, idx);
    else
        return NULL;
}

NNS_G3D_RES_INLINE int NNS_G3dGetNodeIdxByName(const NNSG3dResNodeInfo *nodeinfo, const NNSG3dResName *name)
{
    if (nodeinfo)
        return NNS_G3dGetResDictIdxByName(&nodeinfo->dict, name);
    else
        return -1;
}

//
// Accessors for NNSG3dResMat
//

NNS_G3D_RES_INLINE const NNSG3dResName *NNS_G3dGetMatNameByIdx(const NNSG3dResMat *mat, u32 idx)
{
    if (mat)
        return NNS_G3dGetResNameByIdx(&mat->dict, idx);
    else
        return NULL;
}

NNS_G3D_RES_INLINE int NNS_G3dGetMatIdxByName(const NNSG3dResMat *mat, const NNSG3dResName *name)
{
    if (mat)
        return NNS_G3dGetResDictIdxByName(&mat->dict, name);
    else
        return -1;
}

//
// Accessors for NNSG3dResShp
//

NNS_G3D_RES_INLINE const NNSG3dResName *NNS_G3dGetShpNameByIdx(const NNSG3dResShp *shp, u32 idx)
{
    if (shp)
        return NNS_G3dGetResNameByIdx(&shp->dict, idx);
    else
        return NULL;
}

NNS_G3D_RES_INLINE int NNS_G3dGetShpIdxByName(const NNSG3dResShp *shp, const NNSG3dResName *name)
{
    if (shp)
        return NNS_G3dGetResDictIdxByName(&shp->dict, name);
    else
        return -1;
}

// NNSG3dResMdl
NNS_G3D_RES_INLINE NNSG3dResMdlInfo *NNS_G3dGetMdlInfo(const NNSG3dResMdl *mdl)
{
    if (mdl)
        return (NNSG3dResMdlInfo *)&mdl->info;
    else
        return NULL;
}

NNS_G3D_RES_INLINE NNSG3dResNodeInfo *NNS_G3dGetNodeInfo(const NNSG3dResMdl *mdl)
{
    if (mdl)
        return (NNSG3dResNodeInfo *)&mdl->nodeInfo;
    else
        return NULL;
}

NNS_G3D_RES_INLINE u8 *NNS_G3dGetSbc(const NNSG3dResMdl *mdl)
{
    if (mdl && mdl->ofsSbc != 0)
        return (u8 *)((u8 *)mdl + mdl->ofsSbc);
    else
        return NULL;
}

NNS_G3D_RES_INLINE NNSG3dResMat *NNS_G3dGetMat(const NNSG3dResMdl *mdl)
{
    if (mdl && mdl->ofsMat != 0)
        return (NNSG3dResMat *)((u8 *)mdl + mdl->ofsMat);
    else
        return NULL;
}

NNS_G3D_RES_INLINE NNSG3dResShp *NNS_G3dGetShp(const NNSG3dResMdl *mdl)
{
    if (mdl && mdl->ofsShp != 0)
        return (NNSG3dResShp *)((u8 *)mdl + mdl->ofsShp);
    else
        return NULL;
}

//
// Accessors for NNSG3dResMdlSet
//

NNS_G3D_RES_INLINE NNSG3dResMdl *NNS_G3dGetMdlByIdx(const NNSG3dResMdlSet *mdlSet, u32 idx)
{
    NNSG3dResDictMdlSetData *data;

    if (mdlSet)
    {
        data = (NNSG3dResDictMdlSetData *)NNS_G3dGetResDataByIdx(&mdlSet->dict, idx);
        if (data)
        {
            return (NNSG3dResMdl *)((u8 *)mdlSet + data->offset);
        }
    }
    return NULL;
}

NNS_G3D_RES_INLINE const NNSG3dResName *NNS_G3dGetMdlNameByIdx(const NNSG3dResMdlSet *mdlSet, u32 idx)
{
    if (mdlSet)
        return NNS_G3dGetResNameByIdx(&mdlSet->dict, idx);
    else
        return NULL;
}

NNS_G3D_RES_INLINE NNSG3dResMdl *NNS_G3dGetMdlByName(const NNSG3dResMdlSet *mdlSet, const NNSG3dResName *name)
{
    NNSG3dResDictMdlSetData *data;

    if (mdlSet)
    {
        data = (NNSG3dResDictMdlSetData *)NNS_G3dGetResDataByName(&mdlSet->dict, name);
        if (data)
        {
            return (NNSG3dResMdl *)((u8 *)mdlSet + data->offset);
        }
    }

    return NULL;
}

NNS_G3D_RES_INLINE int NNS_G3dGetMdlIdxByName(const NNSG3dResMdlSet *mdlSet, const NNSG3dResName *name)
{
    if (mdlSet)
        return NNS_G3dGetResDictIdxByName(&mdlSet->dict, name);
    else
        return -1;
}

//
// Accessors for a data block header
//
NNS_G3D_RES_INLINE NNSG3dResMdlSet *NNS_G3dCheckMdlSet(const NNSG3dResDataBlockHeader *dataBlkHeader)
{
    if (dataBlkHeader->kind == NNS_G3D_DATABLK_MDLSET)
    {
        return (NNSG3dResMdlSet *)dataBlkHeader;
    }
    else
    {
        return NULL;
    }
}

NNS_G3D_RES_INLINE NNSG3dResTex *NNS_G3dCheckTex(const NNSG3dResDataBlockHeader *dataBlkHeader)
{
    if (dataBlkHeader->kind == NNS_G3D_DATABLK_TEX)
    {
        return (NNSG3dResTex *)dataBlkHeader;
    }
    else
    {
        return NULL;
    }
}

// Misc
NNS_G3D_RES_INLINE NNSG3dResNodeData *NNS_G3dGetNodeDataByIdx(const NNSG3dResNodeInfo *info, u32 idx)
{
    NNSG3dResDictNodeData *data;

    if (info)
    {
        data = (NNSG3dResDictNodeData *)NNS_G3dGetResDataByIdx(&info->dict, idx);
        if (data)
        {
            return (NNSG3dResNodeData *)((u8 *)info + data->offset);
        }
    }

    return NULL;
}

NNS_G3D_RES_INLINE NNSG3dResMatData *NNS_G3dGetMatDataByIdx(const NNSG3dResMat *mat, u32 idx)
{
    NNSG3dResDictMatData *data;

    if (mat)
    {
        data = (NNSG3dResDictMatData *)NNS_G3dGetResDataByIdx(&mat->dict, idx);
        if (data)
        {
            return (NNSG3dResMatData *)((u8 *)mat + data->offset);
        }
    }

    return NULL;
}

NNS_G3D_RES_INLINE NNSG3dResShpData *NNS_G3dGetShpDataByIdx(const NNSG3dResShp *shp, u32 idx)
{
    NNSG3dResDictShpData *data;

    if (shp)
    {
        data = (NNSG3dResDictShpData *)NNS_G3dGetResDataByIdx(&shp->dict, idx);
        if (data)
        {
            return (NNSG3dResShpData *)((u8 *)shp + data->offset);
        }
    }

    return NULL;
}

NNS_G3D_RES_INLINE NNSG3dResDictTexData *NNS_G3dGetTexDataByName(const NNSG3dResTex *tex, const NNSG3dResName *name)
{
    if (tex)
        return (NNSG3dResDictTexData *)NNS_G3dGetResDataByName(&tex->dict, name);
    else
        return NULL;
}

NNS_G3D_RES_INLINE NNSG3dResDictTexData *NNS_G3dGetTexDataByIdx(const NNSG3dResTex *tex, u32 idx)
{
    if (tex)
        return (NNSG3dResDictTexData *)NNS_G3dGetResDataByIdx(&tex->dict, idx);
    else
        return NULL;
}

NNS_G3D_RES_INLINE NNSG3dResDictPlttData *NNS_G3dGetPlttDataByName(const NNSG3dResTex *tex, const NNSG3dResName *name)
{
    NNSG3dResDict *dict;

    if (tex && tex->plttInfo.ofsDict != 0)
    {
        dict = (NNSG3dResDict *)((u8 *)tex + tex->plttInfo.ofsDict);
        return (NNSG3dResDictPlttData *)NNS_G3dGetResDataByName(dict, name);
    }
    else
    {
        return NULL;
    }
}

NNS_G3D_RES_INLINE NNSG3dResDictPlttData *NNS_G3dGetPlttDataByIdx(const NNSG3dResTex *tex, u32 idx)
{
    NNSG3dResDict *dict;

    if (tex && tex->plttInfo.ofsDict != 0)
    {
        dict = (NNSG3dResDict *)((u8 *)tex + tex->plttInfo.ofsDict);
        return (NNSG3dResDictPlttData *)NNS_G3dGetResDataByIdx(dict, idx);
    }
    else
    {
        return NULL;
    }
}

NNS_G3D_RES_INLINE const void *NNS_G3dGetTexData(const NNSG3dResTex *tex)
{
    return (u8 *)tex + tex->texInfo.ofsTex;
}

NNS_G3D_RES_INLINE const void *NNS_G3dGetTex4x4Data(const NNSG3dResTex *tex)
{
    return (u8 *)tex + tex->tex4x4Info.ofsTex;
}

NNS_G3D_RES_INLINE const void *NNS_G3dGetTex4x4PlttIdxData(const NNSG3dResTex *tex)
{
    return (u8 *)tex + tex->tex4x4Info.ofsTexPlttIdx;
}

NNS_G3D_RES_INLINE const void *NNS_G3dGetPlttData(const NNSG3dResTex *tex)
{
    return (u8 *)tex + tex->plttInfo.ofsPlttData;
}

NNS_G3D_RES_INLINE const void *NNS_G3dGetShpDLPtr(const NNSG3dResShpData *shp)
{
    return (u8 *)shp + shp->ofsDL;
}

NNS_G3D_RES_INLINE u32 NNS_G3dGetShpDLSize(const NNSG3dResShpData *shp)
{
    return shp->sizeDL;
}

// Anim helpers
NNS_G3D_RES_INLINE BOOL NNS_G3dIsMatAnm(const void *pAnm)
{
    const NNSG3dResAnmHeader *hdr = (const NNSG3dResAnmHeader *)pAnm;
    return hdr != NULL && hdr->category0 == 'M';
}

NNS_G3D_RES_INLINE BOOL NNS_G3dIsJntAnm(const void *pAnm)
{
    const NNSG3dResAnmHeader *hdr = (const NNSG3dResAnmHeader *)pAnm;
    return hdr != NULL && hdr->category0 == 'J';
}

NNS_G3D_RES_INLINE BOOL NNS_G3dIsVisAnm(const void *pAnm)
{
    const NNSG3dResAnmHeader *hdr = (const NNSG3dResAnmHeader *)pAnm;
    return hdr != NULL && hdr->category0 == 'V';
}

#ifdef __cplusplus
}
#endif

#endif // NNSG3D_BINRES_RES_STRUCT_ACCESSOR_INLINE_H