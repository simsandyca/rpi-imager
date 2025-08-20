#!/bin/bash 

if [[ $UID != 0 ]]
then
   echo "you gotta be root for this script"
   exit 1
fi
LOOP=$(losetup -f)
echo "LOOP is $LOOP"
if [[ ! -d boot ]]
then
   mkdir -p boot 
fi
if [[ ! -f boot.img ]]
then
   dd if=/dev/zero of=boot.img bs=1M count=36
   losetup -P $LOOP boot.img
   mkfs.vfat $LOOP
else 
   losetup -P $LOOP boot.img
fi
echo "mount $LOOP boot"
mount $LOOP boot
cd output 
cp -rp * ../boot
cd ..
umount boot
losetup -d $LOOP

./rpi-eeprom-digest -k ../private.pem -i boot.img -o boot.sig 

