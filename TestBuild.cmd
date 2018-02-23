@echo off
set ver=3.x_test-key
title WangUI PatchRom Tool Ver:%ver%
set /p projectname=Project name:

echo 解包dat
call build\unpackdat.cmd %projectname%\ota
echo 转到适配工具根目录
cd /d %~dp0
echo 删除原主题文件
rd /s /q devices\%projectname%\ota\system\customizecenter
del /f /s /q devices\%projectname%\ota\system\customizecenter
echo BuildProp Step
start build\buildinfo.cmd
pause
type devices\%projectname%\prop\system.prop >>%~dp0\build.prop
del /f /s /q %~dp0\devices\%projectname%\ota\system\build.prop
move %~dp0\build.prop %~dp0\devices\%projectname%\ota\system\
echo 修改build.prop的格式为UNIX
call build\core\npp\notepad.exe %~dp0\devices\%projectname%\ota\system\build.prop
echo 暂停
pause
echo 复制主题文件
xcopy devices\base\customizecenter devices\%projectname%\ota\system\customizecenter /s
echo 复制DragOS APP
xcopy devices\base\app\DragHelper devices\%projectname%\ota\system\app\DragHelper /s
echo 准备出包
md devices\%projectname%\ota\out
echo 复制file_contexts增加刷机成功率
copy devices\%projectname%\ota\file_contexts devices\%projectname%\ota\out\
echo 复制META-INF
xcopy devices\%projectname%\ota\META-INF devices\%projectname%\ota\out\META-INF /s
echo 删除原脚本及binary
del /a /f /s /q devices\%projectname%\ota\out\META-INF\com\google\android\update-binary
del /a /f /s /q devices\%projectname%\ota\out\META-INF\com\google\android\updater-script
echo 复制META-INF
copy devices\%projectname%\update-binary devices\%projectname%\ota\out\META-INF\com\google\android\
copy devices\%projectname%\updater-script devices\%projectname%\ota\out\META-INF\com\google\android\
echo 复制boot
copy devices\%projectname%\boot\boot.img devices\%projectname%\ota\out\
echo 复制system
xcopy devices\%projectname%\ota\system devices\%projectname%\ota\out\system /s
echo 删除system文件夹
rd /s /q devices\%projectname%\ota\system
echo 设置变量
set path=%path%;%~dp0\build\sdk_files;
echo 转到out目录
cd /d devices\%projectname%\ota\out
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
cd /d devices\%projectname%\ota\out\
echo 打包zip刷机包
zip -1 WangUI_%projectname%\ota_build.zip META-INF META-INF\com META-INF\com\android\ META-INF\com\android\metadata META-INF\com\android\otacert META-INF\com\google\ META-INF\com\google\android\ META-INF\com\google\android\update-binary META-INF\com\google\android\updater-script type.txt SEC_VER.txt system.new.dat system.patch.dat system.transfer.list boot.img file_contexts
