#include <cutscene/cutsceneScript.h>

// --------------------
// VARIABLES
// --------------------

// this is put in a separate file for now to get the compilation order to match
CutsceneScriptControlCommand scriptBitwiseInstructions[] =
{
	NULL,
    CutsceneScript_BitwiseCommand_BitwiseAND,
	CutsceneScript_BitwiseCommand_LogicalAND,
    CutsceneScript_BitwiseCommand_BitwiseOR,
	CutsceneScript_BitwiseCommand_LogicalOR,
    CutsceneScript_BitwiseCommand_XOR,
	CutsceneScript_BitwiseCommand_BitwiseNot,
    CutsceneScript_BitwiseCommand_LogicalNot,
	CutsceneScript_BitwiseCommand_ShiftL,
    CutsceneScript_BitwiseCommand_ShiftR,
	CutsceneScript_BitwiseCommand_RotateL,
    CutsceneScript_BitwiseCommand_RotateR,
};