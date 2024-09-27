#include <nitro.h>

#include <nitro/std/unicode.h>
#include "include/sjis2unicode.h"
#include "include/unicode2sjis.h"

// --------------------
// FUNCTIONS
// --------------------

STDResult STD_ConvertStringSjisToUnicode(u16 *dst, int *dst_len, const char *src, int *src_len, STDConvertUnicodeCallback callback)
{
    STDResult retval = STD_RESULT_SUCCESS;

    if (!src)
    {
        retval = STD_RESULT_INVALID_PARAM;
    }
    else
    {
        int src_pos = 0;
        int dst_pos = 0;
        int src_max = (src_len && (*src_len >= 0)) ? *src_len : 0x7FFFFFFF;
        int dst_max = (dst && dst_len && (*dst_len >= 0)) ? *dst_len : 0x7FFFFFFF;

        while ((dst_pos < dst_max) && (src_pos < src_max))
        {
            u16 dst_tmp[4];
            int dst_count = 0;
            int src_count;
            u32 c1 = (u8)src[src_pos];

            if (!c1)
            {
                break;
            }
            else if (c1 <= 0x7E)
            {
                dst_tmp[0] = (u16)c1;
                src_count  = 1;
                dst_count  = 1;
            }
            else if ((c1 >= 0xA1) && (c1 <= 0xDF))
            {
                dst_tmp[0] = (u16)(c1 + (0xFF61 - 0xA1));
                src_count  = 1;
                dst_count  = 1;
            }
            else if (STD_IsSjisCharacter(&src[src_pos]))
            {
                src_count = 2;
                if (src_pos + src_count <= src_max)
                {

                    u32 c2 = (u8)src[src_pos + 1];
                    c1 -= 0x81 + ((c1 >= 0xE0) ? (0xE0 - 0xA0) : 0);
                    dst_tmp[0] = sjis2unicode_array[c1 * 0xC0 + (c2 - 0x40)];
                    dst_count  = (dst_tmp[0] ? 1 : 0);
                }
            }

            if (dst_count == 0)
            {
                if (!callback)
                {
                    retval = STD_RESULT_CONVERSION_FAILED;
                }
                else
                {
                    src_count = src_max - src_pos;
                    dst_count = sizeof(dst_tmp) / sizeof(*dst_tmp);
                    retval    = (*callback)(dst_tmp, &dst_count, &src[src_pos], &src_count);
                }

                if (retval != STD_RESULT_SUCCESS)
                {
                    break;
                }
            }

            if ((src_pos + src_count > src_max) || (dst_pos + dst_count > dst_max))
            {
                break;
            }

            if (dst != NULL)
            {
                int i;
                for (i = 0; i < dst_count; ++i)
                {
                    MI_StoreLE16(&dst[dst_pos + i], (u16)dst_tmp[i]);
                }
            }

            src_pos += src_count;
            dst_pos += dst_count;
        }

        if (src_len != NULL)
        {
            *src_len = src_pos;
        }

        if (dst_len != NULL)
        {
            *dst_len = dst_pos;
        }
    }

    return retval;
}

STDResult STD_ConvertStringUnicodeToSjis(char *dst, int *dst_len, const u16 *src, int *src_len, STDConvertSjisCallback callback)
{
    STDResult retval = STD_RESULT_SUCCESS;

    if (!src)
    {
        retval = STD_RESULT_INVALID_PARAM;
    }
    else
    {
        int src_pos = 0;
        int dst_pos = 0;
        int src_max = (src_len && (*src_len >= 0)) ? *src_len : 0x7FFFFFFF;
        int dst_max = (dst && dst_len && (*dst_len >= 0)) ? *dst_len : 0x7FFFFFFF;

        while ((dst_pos < dst_max) && (src_pos < src_max))
        {
            char dst_tmp[4];
            int dst_count = 0;
            int src_count = 1;
            u32 w         = MI_LoadLE16(&src[src_pos]);

            if (!w)
            {
                break;
            }
            else if ((w >= 0xE000) && (w < 0xF8FF))
            {
                const u32 sjis_page = 188UL;
                const u32 offset    = w - 0xE000;
                u32 c1              = offset / sjis_page;
                u32 c2              = offset - c1 * sjis_page;
                dst_tmp[0]          = (char)(c1 + 0xF0);
                dst_tmp[1]          = (char)(c2 + ((c2 < 0x3F) ? 0x40 : 0x41));
                dst_count           = 2;
            }
            else
            {

                static const int table[][2] = {
                    {
                        0x0000,
                        0x0480 - 0x0000,
                    },
                    {
                        0x2000,
                        0x2680 - 0x2000,
                    },
                    {
                        0x3000,
                        0x3400 - 0x3000,
                    },
                    {
                        0x4E00,
                        0x9FA8 - 0x4E00,
                    },
                    {
                        0xF928,
                        0xFFE6 - 0xF928,
                    },
                };
                enum
                {
                    table_max = sizeof(table) / (sizeof(int) * 2)
                };

                int i;
                int index = 0;
                for (i = 0; i < table_max; ++i)
                {
                    const int offset = (int)(w - table[i][0]);

                    if (offset < 0)
                    {
                        break;
                    }
                    else if (offset < table[i][1])
                    {
                        index += offset;
                        dst_tmp[0] = (char)unicode2sjis_array[index * 2 + 0];
                        if (dst_tmp[0])
                        {
                            dst_tmp[1] = (char)unicode2sjis_array[index * 2 + 1];
                            dst_count  = dst_tmp[1] ? 2 : 1;
                        }
                        break;
                    }
                    else
                    {
                        index += table[i][1];
                    }
                }
            }

            if (dst_count == 0)
            {
                if (!callback)
                {
                    retval = STD_RESULT_CONVERSION_FAILED;
                }
                else
                {
                    src_count = src_max - src_pos;
                    dst_count = sizeof(dst_tmp) / sizeof(*dst_tmp);
                    retval    = (*callback)(dst_tmp, &dst_count, &src[src_pos], &src_count);
                }
                if (retval != STD_RESULT_SUCCESS)
                {
                    break;
                }
            }

            if ((src_pos + src_count > src_max) || (dst_pos + dst_count > dst_max))
            {
                break;
            }

            if (dst != NULL)
            {
                int i;
                for (i = 0; i < dst_count; ++i)
                {
                    MI_StoreLE8(&dst[dst_pos + i], (u8)dst_tmp[i]);
                }
            }

            src_pos += src_count;
            dst_pos += dst_count;
        }

        if (src_len != NULL)
        {
            *src_len = src_pos;
        }

        if (dst_len != NULL)
        {
            *dst_len = dst_pos;
        }
    }

    return retval;
}
