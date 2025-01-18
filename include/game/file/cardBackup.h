#ifndef RUSH_CARDBACKUP_H
#define RUSH_CARDBACKUP_H

#include <global.h>

// --------------------
// FUNCTIONS
// --------------------

void InitCardBackupSystem(void);
BOOL InitCardBackupSize(void);
BOOL ReadFromCardBackup(void *src, void *dst, size_t size);
BOOL WriteToCardBackup(void *dst, void *src, size_t size);

#endif // RUSH_CARDBACKUP_H
