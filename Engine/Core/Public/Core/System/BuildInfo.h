#pragma once


#include <Core/Core.h>

PL_TODO(AM, "Get rid of STL!");
#include <string>


namespace PixelLight
{
	/**
	 *	Helper class that provides information on the build that produced the currently running binary.
	 *	The information is pulled from file 'BuildInfo.json' located in the application's binary directory. This
	 *	file is updated whenever any part of the PixelLight project is built and thus reflects the most recent
	 *	state - it does _not_ provide per-library information!
	 */
	class PL_CORE_API BuildInfo
	{
	PL_PUBLIC_STATIC_METHODS:
		/** Use to retrieve the build information of the running binary */
		static const BuildInfo& GetCurrent();

	PL_PUBLIC_METHODS:
		/** Helper to retrieve formatted summary of all information this class provides */
		std::string MakeDescriptionString() const;

		PL_TODO(AD, "Move into .inl file(?)");

		/** Name of the project that produced the binary */
		inline const std::string& GetAppName() const { return m_AppName; }
		/** Major version of the project */
		inline int GetVersionMajor() const { return m_VersionMajor; }
		/** Minor version of the project */
		inline int GetVersionMinor() const { return m_VersionMinor; }
		/** Patch version of the project */
		inline int GetVersionPatch() const { return m_VersionPatch; }
		/** Shortened Git commit SHA-1 from which the binary was built */
		inline const std::string& GetVersionRev() const { return m_VersionRev; }
		/** Descriptive name of the binary release */
		inline const std::string& GetVersionName() const { return m_VersionName; }
		/** Full SHA-1 of the Git commit from which the binary was built */
		inline const std::string& GetGitSha() const { return m_GitSHA; }
		/** Name of the Git branch from which the binary was built */
		inline const std::string& GetGitBranch() const { return m_GitBranch; }
		/** Formatted date and time of the build */
		inline const std::string& GetBuildTimestamp() const { return m_BuildTimestamp; }

	PL_PRIVATE_DATA:
		std::string m_AppName;

		int m_VersionMajor = 0;
		int m_VersionMinor = 0;
		int m_VersionPatch = 0;
		std::string m_VersionRev;
		std::string m_VersionName;

		std::string m_GitSHA;
		std::string m_GitBranch;

		std::string m_BuildTimestamp;
	};
}
