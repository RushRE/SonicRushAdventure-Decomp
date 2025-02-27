#ifndef RUSH_SPRITEUNKNOWN_H
#define RUSH_SPRITEUNKNOWN_H

#include <game/system/task.h>

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED u32 SpriteUnknown__GetSpriteSizeFromAnim(void *file, BOOL useEngineB, u16 anim);
NOT_DECOMPILED u32 SpriteUnknown__GetSpriteSize(void *file, BOOL useEngineB);
NOT_DECOMPILED u32 SpriteUnknown__GetSpriteSize1FromAnimRange(void *file, u32 firstAnim, u32 lastAnim);
NOT_DECOMPILED u32 SpriteUnknown__GetSpriteSize1FromAnimList(void *file, u32 *animList);
NOT_DECOMPILED u32 SpriteUnknown__GetSpriteSize2FromAnimRange(void *file, u32 firstAnim, u32 lastAnim);
NOT_DECOMPILED u32 SpriteUnknown__GetSpriteSize2FromAnimList(void *file, u32 *animList);
NOT_DECOMPILED u32 SpriteUnknown__GetSpriteSize3FromAnimRange(void *file, u32 firstAnim, u32 lastAnim);
NOT_DECOMPILED u32 SpriteUnknown__GetSpriteSize3FromAnimList(void *file, u32 *animList);
NOT_DECOMPILED u32 SpriteUnknown__GetSpriteSize4FromAnimRange(void *file, u32 firstAnim, u32 lastAnim);
NOT_DECOMPILED u32 SpriteUnknown__GetSpriteSize4FromAnimList(void *file, u32 *animList);
NOT_DECOMPILED u32 SpriteUnknown__GetSpriteSizeFromAnimRange(void *file, BOOL useEngineB, u32 firstAnim, u32 lastAnim);
NOT_DECOMPILED u32 SpriteUnknown__GetSpriteSizeFromAnimList(void *file, BOOL useEngineB, u32 *animList);
NOT_DECOMPILED void SpriteUnknown__InitAnimator(AnimatorSprite *animator, void *fileData, u16 animID, AnimatorFlags flags, BOOL useEngineB, u32 spriteSize, u8 paletteRow,
                                                u8 oamPriority, u8 oamOrder);

#endif // RUSH_SPRITEUNKNOWN_H