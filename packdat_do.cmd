
echo Packing dat image...
make_ext4fs.exe -T -1 -S file_contexts -l 1610612736 -a /system system.img system
rimg2sdat.exe system.img
dos2unix.exe system.transfer.list
del system.patch.dat 2>nul
echo 2>aaa.txt >nul
ren aaa.txt system.patch.dat
del aaa.txt 2>nul
del system.img 2>nul