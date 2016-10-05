#pragma once


#include <Core/Core.h>

namespace PixelLight
{
    /** File descriptor wrapper */
    typedef FILE* FileDesc;
    
    /** Standard stream wrappers */
    PL_CORE_API extern const FileDesc StdIn;
    PL_CORE_API extern const FileDesc StdOut;
    PL_CORE_API extern const FileDesc StdErr;
}