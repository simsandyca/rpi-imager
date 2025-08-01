#!/bin/bash 

if [[ $UID != 0 ]]
then 
    echo "relax guy you probably gotta be root to run this"
    exit 1
fi
git checkout qml 
time ./build-qt.sh 
git checkout cli_boot_server
cd embedded 
./build.sh 
./pack.sh 
cd - 

