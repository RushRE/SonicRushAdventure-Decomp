#ifndef NITRO_MI_BYTEACCESS_H
#define NITRO_MI_BYTEACCESS_H

#ifdef __cplusplus
extern "C"
{
#endif

static inline u8 MI_ReadByte(const void *address)
{
    return *(u8 *)address;
}

static inline void MI_WriteByte(void *address, u8 value)
{
    *(u8 *)address = value;
}

#ifdef __cplusplus
}
#endif

#endif // NITRO_MI_BYTEACCESS_H