#include <cutscene/cutsceneScript.h>

// --------------------
// VARIABLES
// --------------------

static CutsceneScriptControlCommand scriptEndInstructions[] =
{
    CutsceneScript_EndCommand_StopThreads,
    CutsceneScript_EndCommand_Continue,
    CutsceneScript_EndCommand_Suspend,
};

static CutsceneScriptControlCommand scriptEngineInstructions[] =
{
	NULL,
    CutsceneScript_EngineCommand_Execute,
};

static CutsceneScriptControlCommand scriptSwitchInstructions[] =
{
	NULL,
    CutsceneScript_SwitchCommand_Case,
    CutsceneScript_SwitchCommand_Default,
};

static CutsceneScriptControlCommand scriptStackInstructions[] =
{
    NULL,
    CutsceneScript_StackCommand_Load,
    CutsceneScript_StackCommand_Store,
};

static CutsceneScriptControlCommand scriptFunctionInstructions[] =
{
    NULL,
    CutsceneScript_FunctionCommand_CallFunction,
    CutsceneScript_FunctionCommand_EndFunction,
    CutsceneScript_FunctionCommand_CallFunctionASync,
    CutsceneScript_FunctionCommand_End,
};

static CutsceneScriptControlCommand scriptBranchInstructions[] =
{
    CutsceneScript_BranchCommand_BranchAlways,
    CutsceneScript_BranchCommand_BranchEqual,
    CutsceneScript_BranchCommand_BranchNotEqual,
    CutsceneScript_BranchCommand_BranchGreaterEqual,
    CutsceneScript_BranchCommand_BranchGreater,
    CutsceneScript_BranchCommand_BranchLessEqual,
    CutsceneScript_BranchCommand_BranchLess,
};

static CutsceneScriptControlCommand scriptComparisonInstructions[] =
{
    NULL,
    CutsceneScript_ComparisonCommand_Equal,
    CutsceneScript_ComparisonCommand_NotEqual,
    CutsceneScript_ComparisonCommand_Less,
    CutsceneScript_ComparisonCommand_LessEqual,
    CutsceneScript_ComparisonCommand_Greater,
    CutsceneScript_ComparisonCommand_GreaterEqual,
};

static CutsceneScriptControlCommand scriptArithmeticInstructions[] =
{
    CutsceneScript_ArithmeticCommand_Assign,
    CutsceneScript_ArithmeticCommand_Add,
    CutsceneScript_ArithmeticCommand_Subtract,
    CutsceneScript_ArithmeticCommand_Multiply,
    CutsceneScript_ArithmeticCommand_Divide,
    CutsceneScript_ArithmeticCommand_Negate,
    CutsceneScript_ArithmeticCommand_Increment,
    CutsceneScript_ArithmeticCommand_Decrement,
    CutsceneScript_ArithmeticCommand_ShiftR,
};

// this is put in a separate file for now to get the compilation order to match
extern CutsceneScriptControlCommand scriptBitwiseInstructions[];

CutsceneScriptControlCommand *cutsceneScriptInstructionTable[] =
{
    scriptEndInstructions,
    scriptArithmeticInstructions,
    scriptBitwiseInstructions,
    scriptComparisonInstructions,
    scriptSwitchInstructions,
    scriptBranchInstructions,
    scriptFunctionInstructions,
    scriptEngineInstructions,
    scriptStackInstructions,
};