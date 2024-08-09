/*
GameSpy GT2 SDK
Dan "Mr. Pants" Schoenblum
dan@gamespy.com

Copyright 2002 GameSpy Industries, Inc

18002 Skypark Circle
Irvine, California 92614
949.798.4200 (Tel)
949.798.4299 (Fax)
devsupport@gamespy.com
*/

#ifndef _GT2_UTILITY_H_
#define _GT2_UTILITY_H_

#include "gt2Main.h"

void gti2MessageCheck(const GT2Byte **message, int *len);

#ifdef RECV_LOG
void gti2LogMessage(unsigned int fromIP, unsigned short fromPort, unsigned int toIP, unsigned short toPort, const GT2Byte *message, int len);
#endif

#endif
