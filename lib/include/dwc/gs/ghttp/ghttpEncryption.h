///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
#ifndef __GHTTPENCRYPTION_H__
#define __GHTTPENCRYPTION_H__

///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
//#include "ghttpCommon.h"

///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
// Encryption method
typedef enum
{
    GHIEncryptionMethod_None,
    GHIEncryptionMethod_Encrypt, // encrypt raw data written to buffer
    GHIEncryptionMethod_Decrypt  // decrypt raw data written to buffer
} GHIEncryptionMethod;

// Encryption results
typedef enum
{
    GHIEncryptionResult_None,
    GHIEncryptionResult_Success,        // successfully encrypted/decrypted
    GHIEncryptionResult_BufferTooSmall, // buffer was too small to hold converted data
    GHIEncryptionResult_Error           // some other kind of error
} GHIEncryptionResult;

///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
struct GHIEncryptor; // forward declare for callbacks
struct GHIConnection;

// Called to start the encryption engine
typedef GHIEncryptionResult (*GHTTPEncryptorInitFunc)(struct GHIConnection *theConnection, struct GHIEncryptor *theEncryptor);

// Called to destroy the encryption engine
typedef GHIEncryptionResult (*GHTTPEncryptorCleanupFunc)(struct GHIConnection *theConnection, struct GHIEncryptor *theEncryptor);

// Called when data needs to be encrypted
//    - entire plain text buffer will be encrypted
typedef GHIEncryptionResult (*GHTTPEncryptorEncryptFunc)(struct GHIConnection *theConnection, struct GHIEncryptor *theEncryptor, const char *thePlainTextBuffer, int *thePlainTextLength,
                                                         char *theEncryptedBuffer, int *theEncryptedLength);

// Called when data needs to be descrypted
//    - encrypted data may be left in the buffer
//    - decrypted buffer is appended to, not overwritten
typedef GHIEncryptionResult (*GHTTPEncryptorDecryptFunc)(struct GHIConnection *theConnection, struct GHIEncryptor *theEncryptor, const char *theEncryptedBuffer, int *theEncryptedLength,
                                                         char *theDecryptedBuffer, int *theDecryptedLength);

///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
typedef struct GHIEncryptor
{
    void *mInterface; // only SSL is currently supported
    GHTTPEncryptionEngine mEngine;
    GHTTPBool mInitialized;
    GHTTPBool mSessionEstablished;

    // Functions for engine use
    GHTTPEncryptorInitFunc mInitFunc;
    GHTTPEncryptorCleanupFunc mCleanupFunc;
    GHTTPEncryptorEncryptFunc mEncryptFunc;
    GHTTPEncryptorDecryptFunc mDecryptFunc;
} GHIEncryptor;

///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
// matrix ssl encryption
#ifdef MATRIXSSL

GHIEncryptionResult ghttpEncryptorSslInitFunc(struct GHIConnection *connection, struct GHIEncryptor *theEncryptor);
GHIEncryptionResult ghttpEncryptorSslCleanupFunc(struct GHIConnection *connection, struct GHIEncryptor *theEncryptor);
GHIEncryptionResult ghttpEncryptorSslEncryptFunc(struct GHIConnection *connection, struct GHIEncryptor *theEncryptor, const char *thePlainTextBuffer, int *thePlainTextLength,
                                                                    char *theEncryptedBuffer, int *theEncryptedLength);
GHIEncryptionResult ghttpEncryptorSslDecryptFunc(struct GHIConnection *connection, struct GHIEncryptor *theEncryptor, const char *theEncryptedBuffer, int *theEncryptedLength,
                                                                    char *theDecryptedBuffer, int *theDecryptedLength);

#endif

///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
#endif // __GHTTPENCRYPTION_H__
