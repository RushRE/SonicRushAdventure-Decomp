#include <game/network/vsRoomManager.h>
#include <game/network/wirelessManager.h>
#include <game/graphics/renderCore.h>
#include <network/networkHandler.h>
#include <game/save/saveManager.h>

// --------------------
// VARIABLES
// --------------------

// force string alignment when matching by separating gDPMatchInfo from the strings via file boundary
#ifndef NON_MATCHING
extern char aDpKeyMode[];
extern char aDpKeyScore[];
extern char aMbContestSrl[];
extern char aBannerContestR[];
extern char aBannerContestR_0[];
extern char aBannerContestR_1[];
extern char aBannerContestR_2[];
extern char aDpRace[];
extern char aDpRing[];

DowloadPlayMatchInfo gDPMatchInfo = {
    .key_mode  = aDpKeyMode,
    .key_score = aDpKeyScore,

    .rom = aMbContestSrl,

    .iconPalettePath = { aBannerContestR, aBannerContestR_0 },
    .iconCharPath    = { aBannerContestR_1, aBannerContestR_2 },
    .key_modes       = { aDpRace, aDpRing },
};

#else

// Non-matching can just compile them all in the same file for ease-of-editing
DowloadPlayMatchInfo gDPMatchInfo = {
    .key_mode  = "dp_key_mode",
    .key_score = "dp_key_score",

    .rom = aMbContestSrl,

    .iconPalettePath = { "/banner/contest_race.nbfp", "/banner/contest_ring.nbfp" },
    .iconCharPath    = { "/banner/contest_race.nbfc", "/banner/contest_ring.nbfc" },
    .key_modes       = { "dp_race", "dp_ring" },
};

#endif