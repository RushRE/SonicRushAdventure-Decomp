#include <nitro.h>

// --------------------
// FUNCTIONS
// --------------------

void OS_GetMacAddress(u8 *macAddress)
{
    u8 *src;

    src = (u8 *)((u32)(OS_GetSystemWork()->nvramUserInfo) + ((sizeof(NVRAMConfig) + 3) & ~0x00000003));
    MI_CpuCopy8(src, macAddress, 6);
}

void OS_GetOwnerInfo(OSOwnerInfo *info)
{
    NVRAMConfig *src;

    src                  = (NVRAMConfig *)(OS_GetSystemWork()->nvramUserInfo);
    info->language       = (u8)(src->ncd.option.language);
    info->favoriteColor  = (u8)(src->ncd.owner.favoriteColor);
    info->birthday.month = (u8)(src->ncd.owner.birthday.month);
    info->birthday.day   = (u8)(src->ncd.owner.birthday.day);
    info->nickNameLength = (u16)(src->ncd.owner.nickname.length);
    info->commentLength  = (u16)(src->ncd.owner.comment.length);
    MI_CpuCopy16(src->ncd.owner.nickname.str, info->nickName, OS_OWNERINFO_NICKNAME_MAX * sizeof(u16));
    MI_CpuCopy16(src->ncd.owner.comment.str, info->comment, OS_OWNERINFO_COMMENT_MAX * sizeof(u16));
}