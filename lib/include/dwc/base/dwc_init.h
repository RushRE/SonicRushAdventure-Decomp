#ifndef DWC_INIT_H
#define DWC_INIT_H

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// ENUMS
// --------------------

enum
{
    DWC_INIT_RESULT_NOERROR,
    DWC_INIT_RESULT_CREATE_USERID,
    DWC_INIT_RESULT_DESTROY_USERID,
    DWC_INIT_RESULT_DESTROY_OTHER_SETTING,
    DWC_INIT_RESULT_LAST,

    DWC_INIT_RESULT_DESTORY_USERID        = DWC_INIT_RESULT_DESTROY_USERID,
    DWC_INIT_RESULT_DESTORY_OTHER_SETTING = DWC_INIT_RESULT_DESTROY_OTHER_SETTING
};

// --------------------
// FUNCTIONS
// --------------------

int DWC_Init(void *work);
u64 DWC_GetAuthenticatedUserId(void);

#ifdef __cplusplus
}
#endif

#endif // DWC_INIT_H
