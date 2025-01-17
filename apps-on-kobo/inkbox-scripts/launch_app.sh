#!/bin/sh
# This file is intended to be launched by qt creator as a custom executable, for inkbox os
# LD_LIBRARY_PATH can be your qt, or used by inkbox

# Before launching this script its needed to add those custom steps:
# ifsctl mnt rootfs rw
# rm /kobo/tmp/exec|| EXIT_CODE=0
# "Upload files via SFTP" step

cd /
ash -c "killall -9 inkbox.sh inkbox inkbox-bin exec; sleep 1; killall -9 inkbox.sh inkbox inkbox-bin exec" || EXIT_CODE=0
fbink -c
chroot /kobo /bin/ash -c "env LD_LIBRARY_PATH=/mnt/onboard/.adds/qt-linux-5.15.2-kobo/lib QT_QPA_PLATFORM=kobo /tmp/exec"
# for inkbox for example:
# First with this setup umount those libraries:
# umount /mnt/onboard/.adds/qt-linux-5.15.2-kobo/plugins/platforms/libkobo.so
# umount /mnt/onboard/.adds/qt-linux-5.15.2-kobo
# umount /kobo/mnt/onboard/.adds/qt-linux-5.15.2-kobo/plugins/platforms/libkobo.so
# umount /kobo/mnt/onboard/.adds/qt-linux-5.15.2-kobo
# chroot /kobo /bin/ash -c "env LD_LIBRARY_PATH="/qt-linux-5.15.2-kobo/lib:lib" QTPATH="/qt-linux-5.15.2-kobo" QT_QPA_PLATFORM=kobo ADDSPATH="/mnt/onboard/.adds/" PATH="${PATH}:/mnt/onboard/.adds/Python-3.9.2/" DEBUG=true QT_FONT_DPI=$(cat /kobo/mnt/onboard/.adds/inkbox/.config/09-dpi/config) LD_PRELOAD=/lib/invert_screen.so /tmp/inkbox"
fbink -c

# the proper way for inkbox: bind mount it to the place it should
#umount -f /kobo/mnt/onboard/.adds/inkbox/inkbox-bin
#mount -o ro,bind /kobo/tmp/exec /kobo/mnt/onboard/.adds/inkbox/inkbox-bin
#/usr/bin/inkbox.sh; read;

# This approach for qt creator is faster, just launch the script:
##!/bin/bash

#mv inkbox exec

#servername="root@10.42.0.28"
#passwd="root"

#sshpass -p $passwd ssh $servername "bash -c \"ifsctl mnt rootfs rw\""
#sshpass -p $passwd ssh $servername "bash -c \"rm /kobo/tmp/exec\""
#sshpass -p $passwd scp exec $servername:/kobo/tmp/

#sshpass -p $passwd ssh $servername "bash -c \"sync\""

#sshpass -p $passwd ssh $servername "bash -c \"/kobo/launch_app.sh\""
