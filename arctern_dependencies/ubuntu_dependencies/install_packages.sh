#!/bin/bash

set -e

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
SCRIPTS_DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

ALL_INSTALL=0
JDK_INSTALL=0
GL_MESA_INSTALL=0

for arg in "$@"
do
	if [ $arg == "all" ];then
		ALL_INSTALL=1
	elif [ $arg == "jdk" ];then
		JDK_INSTALL=1
	elif [ $arg == "gl" ];then
		GL_MESA_INSTALL=1
	else
		echo "Please enter parameters"
		exit 0
	fi
done

if [ ${ALL_INSTALL} == 1 ];then
	echo "Install all packages!"
	JDK_INSTALL=1
	GL_MESA_INSTALL=1
fi

if [ ${JDK_INSTALL} == 1 ];then
	echo "Install JDK!"
	cd ${SCRIPTS_DIR}/openjdk-8-jdk
	sudo dpkg -i ./*.deb
fi

if [ ${GL_MESA_INSTALL} == 1 ];then
	echo "Install GL_MESA!"
	cd ${SCRIPTS_DIR}/gl-mesa
	sudo dpkg -i ./*.deb
fi
