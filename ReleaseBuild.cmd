@echo off
set ver=2.x_test-keys
title WangUI Flyme6 PatchRom Tool Ver:%ver%
set /p projectname=Your Project Name:
set /p company=PCB company:

echo ���dat
call unpackdat.cmd %company% %projectname% >nul
echo ת�����乤�߸�Ŀ¼
cd /d %~dp0
echo �޸�build.prop�İ汾��Ϣ
call npp\notepad.exe %~dp0\devices\%company%\%projectname%\system\build.prop
echo ��ͣ
pause
echo ɾ��ԭ�����ļ�
rd /s /q devices\%company%\%projectname%\system\customizecenter
del /f /s /q devices\%company%\%projectname%\system\customizecenter
echo ���������ļ�
xcopy build_official\customizecenter devices\%company%\%projectname%\system\customizecenter /s
echo ����DragOS APP
xcopy build_official\app\DragHelper devices\%company%\%projectname%\system\app\DragHelper /s
echo ׼������
md devices\%company%\%projectname%\out
echo ����file_contexts����ˢ���ɹ���
copy devices\%company%\%projectname%\file_contexts devices\%company%\%projectname%\out\
echo ����META-INF
xcopy devices\%company%\%projectname%\META-INF devices\%company%\%projectname%\out\META-INF /s
echo ɾ��ԭ�ű���binary
del /a /f /s /q devices\%company%\%projectname%\out\META-INF\com\google\android\update-binary
del /a /f /s /q devices\%company%\%projectname%\out\META-INF\com\google\android\updater-script
echo ����META-INF
copy %projectname%_build\update-binary devices\%company%\%projectname%\out\META-INF\com\google\android\
copy %projectname%_build\updater-script devices\%company%\%projectname%\out\META-INF\com\google\android\
echo ����boot
copy devices\%company%\%projectname%\boot.img devices\%company%\%projectname%\out\
echo ����system
xcopy devices\%company%\%projectname%\system devices\%company%\%projectname%\out\system /s
echo ɾ��system�ļ���
rd /s /q devices\%company%\%projectname%\system
echo ���ñ���
set path=%path%;%~dp0\build;
echo ת��outĿ¼
cd /d devices\%company%\%projectname%\out
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
cd /d devices\%company%\%projectname%\out\
echo ���zipˢ����
zip -1 WangUI_%projectname%_build.zip META-INF META-INF\com META-INF\com\android\ META-INF\com\android\metadata META-INF\com\android\otacert META-INF\com\google\ META-INF\com\google\android\ META-INF\com\google\android\update-binary META-INF\com\google\android\updater-script type.txt SEC_VER.txt system.new.dat system.patch.dat system.transfer.list boot.img file_contexts
echo �ƶ�ˢ����λ��
move WangUI_%projectname%_build.zip %~dp0\security\
cd /d %~dp0\security\
ren WangUI_%projectname%_build.zip update.zip
echo ǩ��ˢ����
java -jar signapk.jar testkey.x509.pem testkey.pk8 update.zip update_signed.zip
del /a /f /s /q update.zip
move update_signed.zip ..\
echo ת����һ��
cd ..
echo ��ͣ
pause
echo ���� �˳�
exit