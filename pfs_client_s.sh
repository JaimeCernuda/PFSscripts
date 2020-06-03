#!/bin/bash
SCRIPT_DIR=`pwd`
NODES=$(cat ${SCRIPT_DIR}/conf/server_lists/all_nodes)
for node in $NODES
do
echo "Stopping client on $node"
ssh $node /bin/bash << EOF
sudo kill-pvfs2-client
mount | grep pvfs2
EOF
done
