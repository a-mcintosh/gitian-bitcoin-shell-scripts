#!/bin/sh
#-------------------------------------------------------------------------------------
#  -- Aubrey McIntosh, PhD
#  -- 1497463063  $Id$
#  -- make an Oracle VirtualBox machine to support a gitian build of bitcoin core
#  -- execute from anywhere, internally relocated to ~
#-------------------------------------------------------------------------------------

#-------------------------------------------------------------------------------------
#  -- based on the instructions at 
#  https://github.com/bitcoin/bitcoin/blob/master/doc/gitian-building.md#create-a-new-virtualbox-vm
#
#  -- and well known resources
#  https://www.virtualbox.org/wiki/Downloads
#  http://cdimage.debian.org/mirror/cdimage/archive/8.5.0/amd64/iso-cd/debian-8.5.0-amd64-netinst.iso
#  http://simpledns.com/private-ipv6.aspx
#-------------------------------------------------------------------------------------
export EPOCH=`date '+%s'`
export gitianbuild="gitianbuild"-$EPOCH
cd ~
mkdir -p opt/gitian/$gitianbuild
export cd_image=`pwd`/opt/debian/debian-8.5.0-amd64-netinst.iso
export vm_images=`pwd`"/VirtualBox VMs/"


echo "#-------------------------------------------------------------------------------------"
echo log: $cd_image
echo log: $vm_images


#-------------------------------------------------------------------------------------
VBoxManage createvm --name "$gitianbuild" --ostype Debian_64 --register
VBoxManage modifyvm "$gitianbuild" --description "Debian machine to support gitian build of bitcoin core." 
VBoxManage modifyvm "$gitianbuild" --clipboard bidirectional --memory 3072 
VBoxManage modifyvm "$gitianbuild" --nic1 nat
VBoxManage modifyvm "$gitianbuild" --natpf1 SSH,tcp,,22222,,22
VBoxManage modifyvm "$gitianbuild" --nic2 hostonly --hostonlyadapter2 vboxnet1
VBoxManage modifyvm "$gitianbuild" --vram 10 --vrde on
VBoxManage createhd --filename "$vm_images/$gitianbuild/$gitianbuild.vdi" --size 40960


#-------------------------------------------------------------------------------------
VBoxManage storagectl "$gitianbuild" --name "SATA Controller" --add sata --portcount 2
VBoxManage storageattach "$gitianbuild"  --storagectl "SATA Controller" --port 0 --device 0 --type dvddrive --medium $cd_image
VBoxManage storageattach "$gitianbuild" --storagectl "SATA Controller" --port 1 --device 0  --type hdd --medium `pwd`"/VirtualBox VMs/$gitianbuild/$gitianbuild.vdi"


echo you may execute the command: VBoxManage startvm "$gitianbuild"
echo "#-------------------------------------------------------------------------------------"

