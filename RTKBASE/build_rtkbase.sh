#!/bin/bash
# Script to build RTKBASE in one command
## build packages
echo 
echo "     Script created by"
echo "     Sylvain POULAIN <sylvain.poulain@giscan.com>"
echo "     released under GPL"
echo "     Attribution"
echo
echo "     if the script doesn't finish properly"
echo "     (i.e. it doesn't print \"script finished\" at the end)"
echo "     please email me the content of the logs folder"
echo
echo
echo "  - script started - `date`"
## dest base path
LOG_PATH="$PWD/logs"
## get sys vars
ARCH=`uname -m`
CORES=`grep -c processor /proc/cpuinfo`
## prevents different (localized) output
LC_ALL=C
## removing old stuff
rm -Rf "$LOG_PATH"
## create needed directory
mkdir -p "$LOG_PATH"
## output sys info
echo "System info:" > "$LOG_PATH/sysinfo.txt"
uname -a > "$LOG_PATH/sysinfo.txt"
echo
echo "  > Install dependencies : "
echo "  > Script will ask your passwork to install it"
sudo apt-get install libxtst-dev build-essential libqt4-dev qt4-qmake > "$LOG_PATH/apt.log" 2>&1
echo "  > building required static lib rtklib"
cd ./lib/rtklib
chmod +x make_library.sh > "$LOG_PATH/rtklib_rights.log" 2>&1
./make_library.sh > "$LOG_PATH/rtklib.log" 2>&1
echo "  < done - `date`"
echo
echo "  > building RTKBASE"
cd ../../
make clean > "$LOG_PATH/RTKBASE_clean.log" 2>&1
qmake > "$LOG_PATH/RTKBASE_qmake.log" 2>&1
make -j$CORES > "$LOG_PATH/RTKBASE.log" 2>&1
echo "  < done - `date`"
echo "  - script finished - `date`"
exit
