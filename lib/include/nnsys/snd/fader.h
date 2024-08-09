#ifndef NNS_SND_FADER_H
#define NNS_SND_FADER_H

#include <nitro/types.h>

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// STRUCTS
// --------------------

typedef struct NNSSndFader
{
    int origin;
    int target;
    int counter;
    int frame;
} NNSSndFader;

// --------------------
// FUNCTIONS
// --------------------

void NNSi_SndFaderInit(NNSSndFader *fader);
void NNSi_SndFaderSet(NNSSndFader *fader, int target, int frame);
int NNSi_SndFaderGet(const NNSSndFader *fader);
void NNSi_SndFaderUpdate(NNSSndFader *fader);
BOOL NNSi_SndFaderIsFinished(const NNSSndFader *fader);

#ifdef __cplusplus
}
#endif

#endif // NNS_SND_FADER_H
