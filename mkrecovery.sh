. build/envsetup.sh
lunch full_rk29-eng
#make clobber
make -j4 recoveryimage

#cp device/rockchip/rk29/recovery/misc.img out/target/product/rk29/recovery/root/
#cp device/rockchip/rk29/recovery/rk29xxnand_ko.ko.2.6.32.27 out/target/product/rk29/recovery/rk29xxnand_ko.ko
#cp device/rockchip/rk29/recovery/rk29xxnand_ko.ko.3.0.8+ out/target/product/rk29/recovery/root/rk29xxnand_ko.ko 
#cp device/rockchip/rk29/recovery/ueventd.rk29board.rc out/target/product/rk29/recovery/root/
#cp device/rockchip/rk29/recovery/charger out/target/product/rk29/recovery/root/
#cp device/rockchip/rk29/recovery/init.goldfish.rc out/target/product/rk29/recovery/root/
#cp device/rockchip/rk29/recovery/ueventd.goldfish.rc out/target/product/rk29/recovery/root/
#cp device/rockchip/rk29/recovery/recoveryimg.cfg out/target/product/rk29/recovery/

cp device/rockchip/rk29/recovery/root/* out/target/product/rk29/recovery/root/
cp device/rockchip/rk29/recovery/root/sbin/* out/target/product/rk29/recovery/root/sbin/

#cd out/target/product/rk29/recovery/
#find . ! -name "."|sort|cpio -oa -H newc|gzip -n >../newinitrd.gz

#cd ..
#abootimg-pack-initrd -f out/target/product/rk29/ramdisk-recovery.img out/target/product/rk29/recovery/root/

#abootimg --create out/target/product/rk29/recoveryk.img -f device/rockchip/rk29/recovery/recoveryimg.cfg -k out/target/product/rk29/kernel -r out/target/product/rk29/ramdisk-recovery.img
#abootimg --create out/target/product/rk29/recovery_#376.img -f device/rockchip/rk29/recovery/recoveryimg.cfg -k device/rockchip/rk29/kernel_#376 -r out/target/product/rk29/ramdisk-recovery.img

#rkcrc -k out/target/product/rk29/ramdisk-recovery.img out/target/product/rk29/recovery.img

#cd ../../../../
#abootimg -create out/target/product/rk29/recovery.img -f device/rockchip/rk29/recovery/bootimg.cfg -k out/target/product/rk29/kernel -r out/target/product/rk29/newinitrd.gz
#rkcrc -k ../newinitrd.gz ../recoverynew.img




echo '****************  start pack recovery images ****************'

OUT=out/target/product/rk29
DEVICE_DIR=device/rockchip/rk29

echo '****************  pack ext3'
cp $DEVICE_DIR/recovery.fstab.ext3 $OUT/recovery/root/etc/recovery.fstab
abootimg-pack-initrd -f $OUT/ramdisk-recovery.img $OUT/recovery/root/
rkcrc -k $OUT/ramdisk-recovery.img $OUT/recovery_ext3.img
abootimg --create $OUT/recoveryk_ext3.img -f $DEVICE_DIR/recovery/recoveryimg.cfg -k $OUT/kernel -r $OUT/ramdisk-recovery.img
#cp $OUT/recovery_ext3.img $PRODUCT_IMAGES
#cp $OUT/recoveryk_ext3.img $PRODUCT_IMAGES

echo '****************  pack ext4'
cp $DEVICE_DIR/recovery.fstab.ext4 $OUT/recovery/root/etc/recovery.fstab
abootimg-pack-initrd -f $OUT/ramdisk-recovery.img $OUT/recovery/root/
rkcrc -k $OUT/ramdisk-recovery.img $OUT/recovery_ext4.img
abootimg --create $OUT/recoveryk_ext4.img -f $DEVICE_DIR/recovery/recoveryimg.cfg -k $OUT/kernel -r $OUT/ramdisk-recovery.img
#cp $OUT/recovery_ext4.img $PRODUCT_IMAGES
#cp $OUT/recoveryk_ext4.img $PRODUCT_IMAGES
	
echo 'make recovery imgages ok!'
