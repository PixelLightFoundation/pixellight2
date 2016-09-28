// This file is part of the PixelLight project
// See LICENSE for copyright details

#ifdef WIN32

	#ifdef UNICODE
	int wmain(int argc, wchar_t **argv)
	#else
	int main(int argc, char **argv)
	#endif
	{
		return 0;
	}
#elif LINUX
	int main(int argc, char **argv)
	{
		return 0;
	}
#endif