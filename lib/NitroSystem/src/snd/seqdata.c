#include <nnsys/snd/seqdata.h>

#include <nnsys/misc.h>

// --------------------
// FUNCTIONS
// --------------------

u32 NNSi_SndSeqArcGetSeqCount(const NNSSndSeqArc *seqArc)
{
    return seqArc->count;
}

const NNSSndSeqArcSeqInfo *NNSi_SndSeqArcGetSeqInfo(const NNSSndSeqArc *seqArc, int index)
{
    if (index < 0)
        return NULL;

    if (index >= seqArc->count)
        return NULL;

    if (seqArc->info[index].offset == NNS_SND_SEQ_ARC_INVALID_OFFSET)
        return NULL;

    return &seqArc->info[index];
}
