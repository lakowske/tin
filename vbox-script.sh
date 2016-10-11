export VM="Ubuntu_16.04"
VBoxManage createhd --filename $VM_VDI --size 80000
VBoxManage createvm --name $VM --ostype "Linux_64" --register
VBoxManage storagectl $VM --name "SATA Controller" --add sata --controller IntelAHCI
VBoxManage storageattach $VM --storagectl "SATA Controller" --port 0   --device 0 --type hdd --medium $VM.vdi

# No need to add installer iso for tin machine copies
#VBoxManage storagectl $VM --name "IDE Controller" --add ide
#VBoxManage storageattach $VM --storagectl "IDE Controller" --port 0   --device 0 --type dvddrive --medium $VM_ISO
VBoxManage modifyvm $VM --ioapic on
VBoxManage modifyvm $VM --boot1 dvd --boot2 disk --boot3 none --boot4 none
VBoxManage modifyvm $VM --memory 2048 --vram 128
VBoxManage modifyvm $VM --nic1 nat
VBoxManage modifyvm $VM --nic2 hostonly --hostonlyadapter2 vboxnet1
VBoxManage showvminfo $VM
VBoxManage modifyvm $VM --vrde on
#VBoxHeadless -s $VM
