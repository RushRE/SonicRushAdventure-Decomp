#ifndef NITRO_INIT_CRT0_H
#define NITRO_INIT_CRT0_H

#ifdef __cplusplus
extern "C" {
#endif

#ifdef SDK_ARM9
void NitroMain(void);
void NitroStartUp(void);
#else
void NitroSpMain(void);
void NitroSpStartUp(void);

#define NitroMain    NitroSpMain
#define NitroStartUp NitroSpStartUp
#endif

#ifdef __cplusplus
}
#endif

#endif // NITRO_INIT_CRT0_H