// This file is part of the PixelLight project
// See LICENSE for copyright details

#ifdef WIN32

	#ifdef UNICODE
	int wmain(int, wchar_t**)
	#else
	int main(int, char**)
	#endif
	{
		return 0;
	}
#elif LINUX
	int main(int, char**)
	{
		return 0;
	}
#endif