@echo off
set ver=3.x_test-key
title WangUI PatchRom Tool Ver:%ver%
set /p projectname=Project name:

echo ���dat
call build\unpackdat.cmd %projectname%\ota
echo ת�����乤�߸�Ŀ¼
cd /d %~dp0
echo ɾ��ԭ�����ļ�
rd /s /q devices\%projectname%\ota\system\customizecenter
del /f /s /q devices\%projectname%\ota\system\customizecenter
echo BuildProp Step
start build\buildinfo.cmd
pause
type devices\%projectname%\prop\system.prop >>%~dp0\build.prop
del /f /s /q %~dp0\devices\%projectname%\ota\system\build.prop
move %~dp0\build.prop %~dp0\devices\%projectname%\ota\system\
echo �޸�build.prop�ĸ�ʽΪUNIX
call build\core\npp\notepad.exe %~dp0\devices\%projectname%\ota\system\build.prop
echo ��ͣ
pause
echo ���������ļ�
xcopy devices\base\customizecenter devices\%projectname%\ota\system\customizecenter /s
echo ����DragOS APP
xcopy devices\base\app\DragHelper devices\%projectname%\ota\system\app\DragHelper /s
echo ׼������
md devices\%projectname%\ota\out
echo ����file_contexts����ˢ���ɹ���
copy devices\%projectname%\ota\file_contexts devices\%projectname%\ota\out\
echo ����META-INF
xcopy devices\%projectname%\ota\META-INF devices\%projectname%\ota\out\META-INF /s
echo ɾ��ԭ�ű���binary
del /a /f /s /q devices\%projectname%\ota\out\META-INF\com\google\android\update-binary
del /a /f /s /q devices\%projectname%\ota\out\META-INF\com\google\android\updater-script
echo ����META-INF
copy devices\%projectname%\update-binary devices\%projectname%\ota\out\META-INF\com\google\android\
copy devices\%projectname%\updater-script devices\%projectname%\ota\out\META-INF\com\google\android\
echo ����boot
copy devices\%projectname%\boot\boot.img devices\%projectname%\ota\out\
echo ����system
xcopy devices\%projectname%\ota\system devices\%projectname%\ota\out\system /s
echo ɾ��system�ļ���
rd /s /q devices\%projectname%\ota\system
echo ���ñ���
set path=%path%;%~dp0\build\sdk_files;
echo ת��outĿ¼
cd /d devices\%projectname%\ota\out
pause
echo ���dat �������Ժ�ĸ
make_ext4fs.exe -T -1 -S file_contexts -l 1610612736 -a /system system.img system
rimg2sdat.exe system.img
dos2unix.exe system.transfer.list
del system.patch.dat 2>nul
echo 2>aaa.txt >nul
ren aaa.txt system.patch.dat
del aaa.txt 2>nul
del system.img 2>nul
echo ת�����߸�Ŀ¼
cd /d %~dp0\
echo ת��outĿ¼
cd /d devices\%projectname%\ota\out\
echo ���zipˢ����
zip -1 WangUI_%projectname%\ota_build.zip META-INF META-INF\com META-INF\com\android\ META-INF\com\android\metadata META-INF\com\android\otacert META-INF\com\google\ META-INF\com\google\android\ META-INF\com\google\android\update-binary META-INF\com\google\android\updater-script type.txt SEC_VER.txt system.new.dat system.patch.dat system.transfer.list boot.img file_contexts
