#ifndef RUSH_SPRITEUNKNOWN_H
#define RUSH_SPRITEUNKNOWN_H

#include <game/graphics/sprite.h>

// --------------------
// FUNCTIONS
// --------------------

u32 SpriteUnknown__GetSpriteSizeFromAnim(void *file, BOOL useEngineB, u16 anim);
u32 SpriteUnknown__GetSpriteSize(void *file, BOOL useEngineB);
u32 SpriteUnknown__GetSpriteSize1FromAnimRange(void *file, u16 firstAnim, u16 lastAnim);
u32 SpriteUnknown__GetSpriteSize1FromAnimList(void *file, u32 *animList);
u32 SpriteUnknown__GetSpriteSize2FromAnimRange(void *file, u16 firstAnim, u16 lastAnim);
u32 SpriteUnknown__GetSpriteSize2FromAnimList(void *file, u32 *animList);
u32 SpriteUnknown__GetSpriteSize3FromAnimRange(void *file, u16 firstAnim, u16 lastAnim);
u32 SpriteUnknown__GetSpriteSize3FromAnimList(void *file, u32 *animList);
u32 SpriteUnknown__GetSpriteSize4FromAnimRange(void *file, u16 firstAnim, u16 lastAnim);
u32 SpriteUnknown__GetSpriteSize4FromAnimList(void *file, u32 *animList);
u32 SpriteUnknown__GetSpriteSizeFromAnimRange(void *file, BOOL useEngineB, u16 firstAnim, u16 lastAnim);
u32 SpriteUnknown__GetSpriteSizeFromAnimList(void *file, BOOL useEngineB, u32 *animList);
void SpriteUnknown__InitAnimator(AnimatorSprite *animator, void *fileData, u16 animID, AnimatorFlags flags, BOOL useEngineB, u32 spriteSize, u8 paletteRow, u8 oamPriority,
                                 u8 oamOrder);

#endif // RUSH_SPRITEUNKNOWN_H