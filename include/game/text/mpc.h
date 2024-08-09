
#ifndef RUSH2_MPCFILE_H
#define RUSH2_MPCFILE_H

#include <global.h>

// --------------------
// STRUCTS
// --------------------

typedef struct MPCHeader_
{
    u32 signature;
    u16 specialCharValue;
    u16 unknown;
    u16 charSize;
    u16 sequenceCount;
    u16 dialogCount;
    u16 lineCount;
    u32 sequenceBlockOffset;
    u32 dialogBlockOffset;
    u32 linesBlockOffset;
    u32 textBlockOffset;
} MPCHeader;

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED u32 MPC__GetSequenceCount(MPCHeader *mpc);
NOT_DECOMPILED u32 MPC__GetSequenceDialogCount(MPCHeader *mpc, s32 sequenceID);
NOT_DECOMPILED u32 MPC__GetDisplayLineLength(MPCHeader *mpc, s32 sequenceID, s32 sequenceOffset);
NOT_DECOMPILED u32 MPC__GetDialogLineCount(MPCHeader *mpc, s32 sequenceID, s32 dialogID);
NOT_DECOMPILED u32 MPC__GetLineLength(MPCHeader *mpc, s32 sequenceID, s32 dialogID, s32 lineID);
NOT_DECOMPILED u32 MPC__GetCharacterFromOffset(MPCHeader *mpc, s32 sequenceID, s32 dialogID, s32 lineID, u16 textOffset);
NOT_DECOMPILED u32 MPC__GetText(MPCHeader *mpc, s32 sequenceID, s32 dialogID, s32 lineID, u16 textOffset, s32 length, u16 *text);
NOT_DECOMPILED BOOL MPC__IsSpecialCharacter(MPCHeader *mpc, u16 character);
NOT_DECOMPILED BOOL MPC__ShouldRunCallback(MPCHeader *mpc, u16 character);
NOT_DECOMPILED BOOL MPC__CheckRegularCharacter(MPCHeader *mpc, u16 character);
NOT_DECOMPILED s32 MPC__GetSpecialCharacter(MPCHeader *mpc, u16 character);
NOT_DECOMPILED u16 MPC__GetCharacter(u32 *charData, s32 charID, s32 charSize);
NOT_DECOMPILED void MPC__GetCharacters(u32 *charData, s32 charID, s32 charSize, s32 textLen, u16 *text);

#endif // RUSH2_MPCFILE_H
