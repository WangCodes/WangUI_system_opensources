@echo off
set path=%path%;%~dp0\build;
cd /d %1\
del system.img.ext4 2>nul
sprs2ext.exe system.transfer.list system.new.dat
ren system.img.ext4 system.img 2>nul
rd /s /q system\ 2>nul
rd /s /q system_\ 2>nul
Imgextractor.exe system.img -i
Imgextractor.exe system.img.ext4 -i
del system__statfile.txt 2>nul
ren system_ system 2>nul
del system\.journal 2>nul
del system_\.journal 2>nul
del system.img 2>nul
goto :eof