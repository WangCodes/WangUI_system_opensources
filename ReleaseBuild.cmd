@echo off
set ver=2.x_test-keys
title WangUI Flyme6 PatchRom Tool Ver:%ver%
set /p projectname=Your Project Name:
set /p company=PCB company:

echo 解包dat
call unpackdat.cmd %company% %projectname% >nul
echo 转到适配工具根目录
cd /d %~dp0
echo 修改build.prop的版本信息
call npp\notepad.exe %~dp0\devices\%company%\%projectname%\system\build.prop
echo 暂停
pause
echo 删除原主题文件
rd /s /q devices\%company%\%projectname%\system\customizecenter
del /f /s /q devices\%company%\%projectname%\system\customizecenter
echo 复制主题文件
xcopy build_official\customizecenter devices\%company%\%projectname%\system\customizecenter /s
echo 复制DragOS APP
xcopy build_official\app\DragHelper devices\%company%\%projectname%\system\app\DragHelper /s
echo 准备出包
md devices\%company%\%projectname%\out
echo 复制file_contexts增加刷机成功率
copy devices\%company%\%projectname%\file_contexts devices\%company%\%projectname%\out\
echo 复制META-INF
xcopy devices\%company%\%projectname%\META-INF devices\%company%\%projectname%\out\META-INF /s
echo 删除原脚本及binary
del /a /f /s /q devices\%company%\%projectname%\out\META-INF\com\google\android\update-binary
del /a /f /s /q devices\%company%\%projectname%\out\META-INF\com\google\android\updater-script
echo 复制META-INF
copy %projectname%_build\update-binary devices\%company%\%projectname%\out\META-INF\com\google\android\
copy %projectname%_build\updater-script devices\%company%\%projectname%\out\META-INF\com\google\android\
echo 复制boot
copy devices\%company%\%projectname%\boot.img devices\%company%\%projectname%\out\
echo 复制system
xcopy devices\%company%\%projectname%\system devices\%company%\%projectname%\out\system /s
echo 删除system文件夹
rd /s /q devices\%company%\%projectname%\system
echo 设置变量
set path=%path%;%~dp0\build;
echo 转到out目录
cd /d devices\%company%\%projectname%\out
pause
echo 打包dat 代码来自航母
make_ext4fs.exe -T -1 -S file_contexts -l 1610612736 -a /system system.img system
rimg2sdat.exe system.img
dos2unix.exe system.transfer.list
del system.patch.dat 2>nul
echo 2>aaa.txt >nul
ren aaa.txt system.patch.dat
del aaa.txt 2>nul
del system.img 2>nul
echo 转到工具根目录
cd /d %~dp0\
echo 转到out目录
cd /d devices\%company%\%projectname%\out\
echo 打包zip刷机包
zip -1 WangUI_%projectname%_build.zip META-INF META-INF\com META-INF\com\android\ META-INF\com\android\metadata META-INF\com\android\otacert META-INF\com\google\ META-INF\com\google\android\ META-INF\com\google\android\update-binary META-INF\com\google\android\updater-script type.txt SEC_VER.txt system.new.dat system.patch.dat system.transfer.list boot.img file_contexts
echo 移动刷机包位置
move WangUI_%projectname%_build.zip %~dp0\security\
cd /d %~dp0\security\
ren WangUI_%projectname%_build.zip update.zip
echo 签名刷机包
java -jar signapk.jar testkey.x509.pem testkey.pk8 update.zip update_signed.zip
del /a /f /s /q update.zip
move update_signed.zip ..\
echo 转到上一级
cd ..
echo 暂停
pause
echo 结束 退出
exit