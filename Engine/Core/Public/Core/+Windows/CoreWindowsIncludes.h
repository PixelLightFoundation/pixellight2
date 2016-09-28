#pragma once

// Exclude some stuff from windows.h to speed up compilation a bit
#define WIN32_LEAN_AND_MEAN
#define NOGDICAPMASKS
#define NOMENUS
#define NOICONS
#define NOKEYSTATES
#define NORASTEROPS
#define OEMRESOURCE
#define NOATOM
#define NOMEMMGR
#define NOMETAFILE
#define NOOPENFILE
#define NOSCROLL
#define NOSERVICE
#define NOSOUND
#define NOWH
#define NOCOMM
#define NOKANJI
#define NOHELP
#define NOPROFILER
#define NODEFERWINDOWPOS
#define NOMCX

#include <windows.h>
#include <intrin.h>

// We undef these to avoid name conflicts
#undef DrawText
#undef LoadImage
#undef MessageBox
#undef GetClassName
#undef CreateDirectory
#undef SetCurrentDirectory
#undef GetCurrentDirectory
#undef GetSystemDirectory
#undef GetEnvironmentVariable
#undef SetEnvironmentVariable
#undef GetComputerName
#undef GetUserName
#undef CreateFont
#undef Yield
#undef SendMessage
#undef PostMessage
#undef FindNextFile
