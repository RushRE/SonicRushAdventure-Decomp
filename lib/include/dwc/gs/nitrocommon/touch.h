#ifndef _TOUCH_H_
#define _TOUCH_H_

#define TOUCH_X_RANGE 256
#define TOUCH_Y_RANGE 192

void TouchInit(void);

BOOL GetTouch(int *x, int *y);

void WaitForTouch(void);

#endif