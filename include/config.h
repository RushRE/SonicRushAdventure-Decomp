#ifndef RUSH_CONFIG_H
#define RUSH_CONFIG_H

// Sets English as default language. This is true of the US & EU versions, JP versions use japanese as the default language.
#if !defined(DEFAULT_LANGUAGE)
#define DEFAULT_LANGUAGE OS_LANGUAGE_ENGLISH
#endif

// Default to european version in the event the region isn't specified
#if !defined(RUSH_EUROPE) && !defined(RUSH_USA) && !defined(RUSH_JAPAN)
#define RUSH_EUROPE
#endif

#endif // RUSH_CONFIG_H
