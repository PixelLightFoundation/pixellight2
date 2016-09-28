#pragma once


// Compile-time messaging helpers
#define _MKSTRING(x) #x
#define STRINGIFY(x) _MKSTRING(x)

// Prints generic compile-time message to the output
#define PL_MESSAGE(x) __pragma(message("\n"__FILE__"("STRINGIFY(__LINE__)")\n^ "#x"\n^"))

// Specialized todo message
#define PL_TODO(author, msg) PL_MESSAGE([TODO] (author) msg)


// Unused parameter helper
#define PL_UNUSED(x) (void)x


// Copy & assignment protection
#define PL_COPY_PROTECT(clss) \
	clss(const clss&); \
	clss& operator=(const clss&);
