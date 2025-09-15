sudo umount m
rm -rf boot m init.cpio
cd initramfs
find . | cpio -o -H newc >> ../init.cpio
cd ..
dd if=/dev/zero of=boot bs=1M count=50
mkfs -t fat boot
syslinux boot
mkdir m
sudo mount boot m
sudo cp bzImage init.cpio m
sudo umount m
rm -rf m
cd ISO/iso/boot/
rm -rf bzImage init.cpio
cd ../../../
cp init.cpio bzImage ISO/iso/boot
cd ISO
grub-mkrescue -o result.iso iso/
rm -rf ../result/current.iso
mv result.iso ../result/current.iso
mv ../boot ../result/boot
cd ..
cd result
qemu-system-x86_64 boot
