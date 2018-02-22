@echo off
::WangUI Develop Team
::@2018

set ver=3.500_test-key
title WangUI Flyme6 PatchRom Tool Ver:%ver%

set /p projectname=Your Project Name:
if not exist %projectname%\ md %projectname%\

:selectformat
set /p mode=Your rom's pack-mode(dat or folder):
if %mode% equ dat (
    call ifdat.cmd %projectname%
    goto next_tomain
)
if %mode% equ folder (
    goto next_tomain
    set dat=0
)
echo Format Cannot Find!
pause
goto selectformat

:next_tomain
echo Chdir to root
cd /d %~dp0
call editprop.cmd

echo Delete Old Themes
rd /s /q %projectname%\system\customizecenter
del /f /s /q %projectname%\system\customizecenter

echo Patch Themes
xcopy resources\customizecenter %projectname%\system\customizecenter /s

echo Patch DragOS APP
xcopy resources\app\DragHelper %projectname%\system\app\DragHelper /s

echo Prepare to pack ziprom
md %projectname%\out
echo Copy file_contexts
::new
if exist %projectname%\file_contexts (
    copy %projectname%\file_contexts %projectname%\out\
)

echo Copy META-INF
xcopy %projectname%\META-INF %projectname%\out\META-INF /s
::del /a /f /s /q %projectname%\out\META-INF\com\google\android\update-binary
::del /a /f /s /q %projectname%\out\META-INF\com\google\android\updater-script
::copy %projectname%_build\update-binary %projectname%\out\META-INF\com\google\android\
::copy %projectname%_build\updater-script %projectname%\out\META-INF\com\google\android\

echo Patch boot
::copy %projectname%\boot.img %projectname%\out\
call patchboot.cmd
::Patch script
::write next time

echo Prepare system
xcopy %projectname%\system %projectname%\out\system /s

echo Delete old system folder
rd /s /q %projectname%\system

echo Prepare path
set path=%path%;%~dp0\build;

echo Chdir to out folder
cd /d %projectname%\out

::chk dat
if %dat% equ 1 (
    call packdat_do.cmd
)

echo Chdir to root
cd /d %~dp0\

echo Chdir to out
cd /d %projectname%\out\

echo Pack ziprom
::write next time
::
::zip -1 WangUI_%projectname%_build.zip META-INF META-INF\com META-INF\com\android\ META-INF\com\android\metadata META-INF\com\android\otacert META-INF\com\google\ META-INF\com\google\android\ META-INF\com\google\android\update-binary META-INF\com\google\android\updater-script type.txt SEC_VER.txt system.new.dat system.patch.dat system.transfer.list boot.img file_contexts

echo Prepare to sign the ziprom
move WangUI_%projectname%_build.zip %~dp0\security\
cd /d %~dp0\security\
ren WangUI_%projectname%_build.zip update.zip

echo Signing the ziprom 
java -jar signapk.jar releasekey.x509.pem releasekey.pk8 update.zip update_signed.zip

del /a /f /s /q update.zip
move update_signed.zip ..\

echo Done!
echo Enjoy WangUI!


pause
goto :eof

::End of file