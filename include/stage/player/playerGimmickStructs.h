struct
{
    VecFx32 offset;
} followParent;

struct
{
    s32 rail;
} tripleGrindRail;

struct
{
    fx32 radius;
    fx32 launchForce;
} steamFan;

struct
{
    fx32 threshold;
    fx32 x;
    fx32 y;
    BOOL allowTricks;
} popSteam;

struct
{
    fx32 topSpeedY;
    s32 burstTimer;
    s32 timer2;
    fx32 startVelX;
} dreamWing;

struct
{
    s32 width;
    s32 angle;
} icicleGrab;

struct
{
    s32 spinSpeed;
} iceSlide;

struct
{
    fx32 x;
    fx32 y;
    s32 pathType;
    s32 type;
} corkscrewPath;

struct
{
    fx32 startX;
    fx32 startY;
    fx32 progress;
    fx32 animSpeed;
} jumpBox;

struct
{
    fx32 startZ;
    fx32 targetZ;
} dolphinRide;

struct
{
    fx32 boundsL;
    fx32 targetY;
    fx32 boundsR;
} hoverCrystal;

struct
{
    fx32 floatSpeed;
} balloonRide;

struct
{
    fx32 accelX;
    fx32 accelY;
    fx32 startX;
    fx32 startY;
} bungee;

struct
{
    s32 unused;
    s32 angle;
} springRope;