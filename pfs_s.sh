#!/bin/bash
SCRIPT_DIR=`pwd`
NODES=$(cat ${SCRIPT_DIR}/conf/server_lists/pfs)
for node in $NODES
do
ssh $node /bin/bash << EOF
rm -rf /mnt/hdd/hdevarajan/storage/*
killall pvfs2-server
ps -aef | grep pvfs2
EOF
done
