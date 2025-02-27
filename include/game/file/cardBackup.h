#ifndef RUSH_CARDBACKUP_H
#define RUSH_CARDBACKUP_H

#include <global.h>

// --------------------
// FUNCTIONS
// --------------------

void InitCardBackupSystem(void);
BOOL InitCardBackupSize(void);
BOOL ReadFromCardBackup(size_t src, void *dst, size_t size);
BOOL WriteToCardBackup(size_t dst, void *src, size_t size);

#endif // RUSH_CARDBACKUP_H
