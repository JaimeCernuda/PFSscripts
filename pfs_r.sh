#!/bin/bash
SCRIPT_DIR=`pwd`
NODES=$(cat ${SCRIPT_DIR}/conf/server_lists/pfs)
for node in $NODES
do
ssh $node /bin/bash << EOF
rm -rf /mnt/hdd/hdevarajan/storage/*
killall pvfs2-server
mkdir -p /mnt/hdd/hdevarajan/storage
pvfs2-server -f -a ${node} ${SCRIPT_DIR}/conf/pfs.conf
pvfs2-server -a ${node} ${SCRIPT_DIR}/conf/pfs.conf
ps -aef | grep pvfs2
EOF
done
