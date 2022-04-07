#!/bin/bash

# Create file directories, and clean them up if they exist
mkdir -p dependencies
mkdir -p lib

# Build GLFW
pushd dependencies
	# Clone repos
	git clone --depth 1 "https://github.com/glfw/glfw"

	pushd glfw
		mkdir build
		pushd build
			cmake -G "Unix Makefiles" .. -DGLFW_BUILD_EXAMPLES=OFF -DGLFW_BUILD_TESTS=OFF -DGLFW_BUILD_DOCS=OFF -DCMAKE_BUILD_TYPE=RELEASE
			cmake --build . --config Release
		popd
		if [[ `uname` == "Darwin" ]]; then
			cp build/src/libglfw3.a ../../lib/libglfw3-osx.a
		else
			cp build/src/libglfw3.a ../../lib/libglfw.a
		fi
	popd

popd

rm -rf dependencies
