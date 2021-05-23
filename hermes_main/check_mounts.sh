#!/bin/sh

# sudo crontab line:
# 0 * * * * /usr/bin/sh /home/docker/main/check_mounts.sh > /dev/null

# /etc/fstab lines:
# root@apollo:/home/docker/main  /media/apollo/main  fuse.sshfs  defaults,allow_other,uid=1000,gid=1000,delay_connect  0  0
# root@poseidon:/home/docker/main  /media/poseidon/main  fuse.sshfs  defaults,allow_other,uid=1000,gid=1000,delay_connect  0  0

apollo=$(df -h | grep apollo | wc -l) 
poseidon=$(df -h | grep poseidon | wc -l)
down=$((apollo + poseidon))
echo $down

if [ $down -lt 2 ] # less than number of mounts
then
    mount -a
    docker restart samba
fi
