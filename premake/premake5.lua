local DIR_ROOT = (path.getabsolute("..") .. "/")
local DIR_ANGELSCRIPT = path.join(DIR_ROOT, "angelscript", "sdk", "angelscript")
local DIR_ANGELSCRIPT_ADDONS = path.join(DIR_ROOT, "angelscript", "sdk", "add_on")

workspace "angelscript"
	location(path.join("projects", _ACTION))
	targetdir(DIR_BIN)

	language "C++"
	cppdialect "C++17"

	configurations {
		"Debug",
		"Release",
	}

	platforms {
		"x86_64",
	}

	filter { "Configurations:Debug" }
		symbols "On"
	filter { "Configurations:Release" }
		optimize "On"
	filter { }

	flags { "MultiProcessorCompile" }

	targetdir(path.join(DIR_ROOT, "bin"))

	project "angelscript"
		kind "StaticLib"

		pic "On"

		files {
			path.join(DIR_ANGELSCRIPT, "source", "as_atomic.cpp"),
			path.join(DIR_ANGELSCRIPT, "source", "as_builder.cpp"),
			path.join(DIR_ANGELSCRIPT, "source", "as_bytecode.cpp"),
			path.join(DIR_ANGELSCRIPT, "source", "as_callfunc.cpp"),
			path.join(DIR_ANGELSCRIPT, "source", "as_compiler.cpp"),
			path.join(DIR_ANGELSCRIPT, "source", "as_configgroup.cpp"),
			path.join(DIR_ANGELSCRIPT, "source", "as_context.cpp"),
			path.join(DIR_ANGELSCRIPT, "source", "as_datatype.cpp"),
			path.join(DIR_ANGELSCRIPT, "source", "as_gc.cpp"),
			path.join(DIR_ANGELSCRIPT, "source", "as_generic.cpp"),
			path.join(DIR_ANGELSCRIPT, "source", "as_globalproperty.cpp"),
			path.join(DIR_ANGELSCRIPT, "source", "as_memory.cpp"),
			path.join(DIR_ANGELSCRIPT, "source", "as_module.cpp"),
			path.join(DIR_ANGELSCRIPT, "source", "as_objecttype.cpp"),
			path.join(DIR_ANGELSCRIPT, "source", "as_outputbuffer.cpp"),
			path.join(DIR_ANGELSCRIPT, "source", "as_parser.cpp"),
			path.join(DIR_ANGELSCRIPT, "source", "as_restore.cpp"),
			path.join(DIR_ANGELSCRIPT, "source", "as_scriptcode.cpp"),
			path.join(DIR_ANGELSCRIPT, "source", "as_scriptengine.cpp"),
			path.join(DIR_ANGELSCRIPT, "source", "as_scriptfunction.cpp"),
			path.join(DIR_ANGELSCRIPT, "source", "as_scriptnode.cpp"),
			path.join(DIR_ANGELSCRIPT, "source", "as_scriptobject.cpp"),
			path.join(DIR_ANGELSCRIPT, "source", "as_string.cpp"),
			path.join(DIR_ANGELSCRIPT, "source", "as_string_util.cpp"),
			path.join(DIR_ANGELSCRIPT, "source", "as_thread.cpp"),
			path.join(DIR_ANGELSCRIPT, "source", "as_tokenizer.cpp"),
			path.join(DIR_ANGELSCRIPT, "source", "as_typeinfo.cpp"),
			path.join(DIR_ANGELSCRIPT, "source", "as_variablescope.cpp"),
			path.join(DIR_ANGELSCRIPT, "source", "**.h"),
		}

		defines {
			"AS_NO_THREADS",
			"AS_NO_EXCEPTIONS",
		}

		filter { "architecture:x86_64", "system:linux" }
			files {
				path.join(DIR_ANGELSCRIPT, "source", "as_callfunc_x64_gcc.cpp"),
			}
		filter { }

	project "mod_angelscript"
		kind "SharedLib"
		targetprefix ""

		files {
			path.join(DIR_ROOT, "src", "**.cpp"),
			path.join(DIR_ROOT, "src", "**.h"),

			path.join(DIR_ANGELSCRIPT_ADDONS, "**.cpp"),
			path.join(DIR_ANGELSCRIPT_ADDONS, "**.h"),
		}

		links {
			"angelscript",
		}

		includedirs {
			path.join(DIR_ROOT, "src"),

			path.join(DIR_ANGELSCRIPT, "include"),
			DIR_ANGELSCRIPT_ADDONS,

			"/usr/include/apr-1.0",
		}

