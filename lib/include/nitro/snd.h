#ifndef NITRO_SND_H
#define NITRO_SND_H

#include <nitro/snd/common/main.h>
#include <nitro/snd/common/alarm.h>
#include <nitro/snd/common/command.h>
#include <nitro/snd/common/global.h>

#ifdef SDK_ARM9

#include <nitro/snd/ARM9/interface.h>

#endif // SDK_ARM9

#include <nitro/snd/common/work.h>
#include <nitro/snd/common/channel.h>
#include <nitro/snd/common/capture.h>
#include <nitro/snd/common/exchannel.h>
#include <nitro/snd/common/data.h>
#include <nitro/snd/common/bank.h>
#include <nitro/snd/common/mml.h>
#include <nitro/snd/common/seq.h>
#include <nitro/snd/common/midiplayer.h>
#include <nitro/snd/common/util.h>

#endif // NITRO_SND_H
