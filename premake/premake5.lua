local DIR_ROOT = (path.getabsolute("..") .. "/")

workspace "atest2"
	location(path.join("projects", _ACTION))
	targetdir(DIR_BIN)

	language "C++"
	cppdialect "C++17"

	configurations {
		"Debug",
		"Release",
	}

	platforms {
		"x64",
	}

	filter { "Configurations:Debug" }
		symbols "On"
	filter { "Configurations:Release" }
		optimize "On"

	filter { }

	flags { "MultiProcessorCompile" }

	targetdir(path.join(DIR_ROOT, "bin"))

	project "mod_atest2"
		kind "SharedLib"
		targetprefix ""

		files {
			path.join(DIR_ROOT, "src", "**.cpp"),
			path.join(DIR_ROOT, "src", "**.h"),
		}

		-- Maybe I don't need?
		--includedirs {
		--	"/usr/include/apr-1.0",
		--}

