#!/bin/bash
SCRIPT_DIR=`pwd`
NODES=$(cat ${SCRIPT_DIR}/conf/server_lists/all_nodes)
PFS_SERVERS=($(cat ${SCRIPT_DIR}/conf/server_lists/pfs))
server=${PFS_SERVERS[0]}
for node in $NODES
do
if [[ $node == *"comp"* ]]; then
  mount_dir=/mnt/nvme/hdevarajan/pfs
else
  mount_dir=/mnt/ssd/hdevarajan/pfs
fi
echo "Starting pfs client on $node"
ssh $node /bin/bash << EOF
sudo kill-pvfs2-client
mkdir -p ${mount_dir} 
sudo insmod ${ORANGEFS_KO}/pvfs2.ko
sudo ${ORANGEFS_PATH}/sbin/pvfs2-client -p ${ORANGEFS_PATH}/sbin/pvfs2-client-core
sudo mount -t pvfs2 tcp://$server:3334/orangefs ${mount_dir}
mount | grep pvfs2
EOF
done
