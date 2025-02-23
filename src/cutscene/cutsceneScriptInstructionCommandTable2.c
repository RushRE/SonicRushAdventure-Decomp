#include <cutscene/cutsceneScript.h>

// --------------------
// VARIABLES
// --------------------

// this is put in a separate file for now to get the compilation order to match
CutsceneScriptControlCommand scriptBitwiseInstructions[] =
{
	NULL,
    CutsceneScript__BitwiseCommand_BitwiseAND,
	CutsceneScript__BitwiseCommand_LogicalAND,
    CutsceneScript__BitwiseCommand_BitwiseOR,
	CutsceneScript__BitwiseCommand_LogicalOR,
    CutsceneScript__BitwiseCommand_XOR,
	CutsceneScript__BitwiseCommand_BitwiseNot,
    CutsceneScript__BitwiseCommand_LogicalNot,
	CutsceneScript__BitwiseCommand_ShiftL,
    CutsceneScript__BitwiseCommand_ShiftR,
	CutsceneScript__BitwiseCommand_RotateL,
    CutsceneScript__BitwiseCommand_RotateR,
};