#pragma once


#include <Core/Core.h>

namespace PixelLight
{
	/**
	 *	PixelLight virtual filesystem
	 *	Similar to UNIX filesystem with different physical locations mounted in
	 *	a virtual folder tree under common root '/'
	 */
	namespace FileSystem
	{
		/**
		 *	Mount the given physical node into a virtual directory
		 */
		PL_CORE_API void Mount(const char* physicalPath, const char* virtualPath);

		/**
		 *	Unmount the given physical node
		 */
		PL_CORE_API void Unmount(const char* physicalPath);
	}
}
