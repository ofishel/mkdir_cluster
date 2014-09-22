#!/bin/bash

#Fresh start point: num=1
num=1

#Fresh start point {b..x}
for x in {b..x}
do
   echo "x = ${x}    num = ${num}"
   sleep 2

   data_dir=/data/${num}
   disk=/dev/sd${x}1

   mkdir -p ${data_dir}

   mkfs -t ext4 ${disk}
   e2label ${disk} ${data_dir}

   vol_uuid=$(blkid -o value -s UUID ${disk})
   echo "UUID=${vol_uuid} ${data_dir} ext4 defaults 0 0" >> /etc/fstab
   mount ${data_dir}

   ((num++))
   echo "Completed disk ${disk} at ${data_dir}"
   sleep 2
done
