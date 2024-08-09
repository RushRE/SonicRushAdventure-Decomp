#ifndef NITRO_OS_SYSTEMCALL_H
#define NITRO_OS_SYSTEMCALL_H

#ifdef __cplusplus
extern "C" {
#endif

void SVC_Halt(void);
void SVC_WaitByLoop(s32 count);

#ifdef __cplusplus
}
#endif

#endif // NITRO_OS_SYSTEMCALL_H
