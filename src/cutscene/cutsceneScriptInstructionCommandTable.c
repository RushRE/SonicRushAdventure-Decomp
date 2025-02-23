#include <cutscene/cutsceneScript.h>

// --------------------
// VARIABLES
// --------------------

static CutsceneScriptControlCommand scriptEndInstructions[] =
{
    CutsceneScript__EndCommand_StopThreads,
    CutsceneScript__EndCommand_Continue,
    CutsceneScript__EndCommand_Suspend,
};

static CutsceneScriptControlCommand scriptEngineInstructions[] =
{
	NULL,
    CutsceneScript__EngineCommand_Execute,
};

static CutsceneScriptControlCommand scriptUnknownInstructions[] =
{
	NULL,
    CutsceneScript__UnknownCommand_215636C,
    CutsceneScript__UnknownCommand_21563D8,
};

static CutsceneScriptControlCommand scriptStackInstructions[] =
{
    NULL,
    CutsceneScript__StackCommand_Load,
    CutsceneScript__StackCommand_Store,
};

static CutsceneScriptControlCommand scriptFunctionInstructions[] =
{
    NULL,
    CutsceneScript__FunctionCommand_CallFunction,
    CutsceneScript__FunctionCommand_EndFunction,
    CutsceneScript__FunctionCommand_CallFunctionASync,
    CutsceneScript__FunctionCommand_End,
};

static CutsceneScriptControlCommand scriptBranchInstructions[] =
{
    CutsceneScript__IfCommand_Branch,
    CutsceneScript__IfCommand_IfEqual,
    CutsceneScript__IfCommand_IfNotEqual,
    CutsceneScript__IfCommand_IfGreaterEqual,
    CutsceneScript__IfCommand_IfGreater,
    CutsceneScript__IfCommand_IfLessEqual,
    CutsceneScript__IfCommand_IfLess,
};

static CutsceneScriptControlCommand scriptComparisonInstructions[] =
{
    NULL,
    CutsceneScript__ComparisonCommand_Equal,
    CutsceneScript__ComparisonCommand_NotEqual,
    CutsceneScript__ComparisonCommand_Less,
    CutsceneScript__ComparisonCommand_LessEqual,
    CutsceneScript__ComparisonCommand_Greater,
    CutsceneScript__ComparisonCommand_GreaterEqual,
};

static CutsceneScriptControlCommand scriptArithmeticInstructions[] =
{
    CutsceneScript__ArithmeticCommand_Assign,
    CutsceneScript__ArithmeticCommand_Add,
    CutsceneScript__ArithmeticCommand_Subtract,
    CutsceneScript__ArithmeticCommand_Multiply,
    CutsceneScript__ArithmeticCommand_Divide,
    CutsceneScript__ArithmeticCommand_Negate,
    CutsceneScript__ArithmeticCommand_Increment,
    CutsceneScript__ArithmeticCommand_Decrement,
    CutsceneScript__ArithmeticCommand_ShiftR,
};

// this is put in a separate file for now to get the compilation order to match
extern CutsceneScriptControlCommand scriptBitwiseInstructions[];

CutsceneScriptControlCommand *CutsceneScript__InstructionTable[] =
{
    scriptEndInstructions,
    scriptArithmeticInstructions,
    scriptBitwiseInstructions,
    scriptComparisonInstructions,
    scriptUnknownInstructions,
    scriptBranchInstructions,
    scriptFunctionInstructions,
    scriptEngineInstructions,
    scriptStackInstructions,
};