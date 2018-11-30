@echo off

rem Create file directories, and clean them up if they  exist

if not exist "dependencies" mkdir dependencies
if not exist "lib" mkdir lib

REM Build glfw
pushd dependencies
	REM Clone repos
	git clone https://github.com/glfw/glfw

	pushd glfw
	    mkdir build 
	    pushd build 
	        cmake -G "NMake Makefiles" .. -DGLFW_BUILD_EXAMPLES=OFF -DGLFW_BUILD_TESTS=OFF -DGLFW_BUILD_DOCS=OFF -DUSE_MSVC_RUNTIME_LIBRARY_DLL=OFF -DCMAKE_BUILD_TYPE=RELEASE
	    popd
	    cmake --build build --config Release
	    copy build\src\glfw3.lib ..\..\lib\glfw3.lib
	popd
popd
