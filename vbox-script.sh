#export VM_NAME="Ubuntu_16.04"
#export VM_VDI=/path/to/a/machine.vdi

#Image already created, user points to it with VM_VDI
VBoxManage createhd --filename $VM_VDI --size 80000

VBoxManage createvm --name $VM_NAME --ostype "Linux_64" --register
VBoxManage storagectl $VM_NAME --name "SATA Controller" --add sata --controller IntelAHCI
VBoxManage storageattach $VM_NAME --storagectl "SATA Controller" --port 0   --device 0 --type hdd --medium $VM_VDI

# No need to add installer iso for tin machine copies
#VBoxManage storagectl $VM_NAME --name "IDE Controller" --add ide
#VBoxManage storageattach $VM_NAME --storagectl "IDE Controller" --port 0   --device 0 --type dvddrive --medium $VM_ISO
VBoxManage modifyvm $VM_NAME --ioapic on
VBoxManage modifyvm $VM_NAME --boot1 dvd --boot2 disk --boot3 none --boot4 none
VBoxManage modifyvm $VM_NAME --memory 2048 --vram 128
VBoxManage modifyvm $VM_NAME --nic1 nat
VBoxManage modifyvm $VM_NAME --nic2 hostonly --hostonlyadapter2 vboxnet1
VBoxManage showvminfo $VM_NAME
VBoxManage modifyvm $VM_NAME --vrde on
#VBoxHeadless -s $VM_NAME
