@echo off
set /p version=WangUI Version:
set /p host=HOST:

cd /d %~dp0\
cd /d ..\

echo import /custom/cip-custom.prop.txt>>build.prop
echo # begin build properties>>build.prop
echo # autogenerated by buildinfo.cmd>>build.prop
echo ro.build.cta=noncta>>build.prop
echo ro.meizu.build.spt=0>>build.prop
echo ro.build.id=LMY47D>>build.prop
echo ro.build.mask.id=%version%_%time%>>build.prop
echo ro.build.inside.id=5.1-%date%_%time%>>build.prop
echo ro.build.version.incremental=%random%>>build.prop
echo ro.build.version.sdk=22>>build.prop
echo ro.build.version.codename=REL>>build.prop
echo ro.build.version.all_codenames=REL>>build.prop
echo ro.build.version.release=5.1>>build.prop
echo ro.build.date=%date% %time%>>build.prop
echo ro.build.date.utc=100000000 >>build.prop
echo ro.build.type=user>>build.prop
echo ro.build.user=%username%>>build.prop
echo ro.build.host=%host%>>build.prop
echo ro.build.tags=release-keys>>build.prop
echo ro.build.flavor=full_wui6753_65c_l1-user_release>>build.prop

echo # ro.product.cpu.abi and ro.product.cpu.abi2 are obsolete,>>build.prop
echo # use ro.product.cpu.abilist instead.>>build.prop
echo ro.product.cpu.abi=arm64-v8a>>build.prop
echo ro.product.cpu.abilist=arm64-v8a,armeabi-v7a,armeabi>>build.prop
echo ro.product.cpu.abilist32=armeabi-v7a,armeabi>>build.prop
echo ro.product.cpu.abilist64=arm64-v8a>>build.prop
echo ro.product.locale.language=zh>>build.prop
echo ro.product.locale.region=CN>>build.prop
echo ro.wifi.channels=>>build.prop
echo ro.board.platform=mt6753>>build.prop
echo # ro.build.product is obsolete; use ro.product.device>>build.prop
echo # Do not try to parse description, fingerprint, or thumbprint>>build.prop
echo ro.build.characteristics=default>>build.prop
echo ro.product.brand=Meizu>>build.prop
echo ro.product.manufacturer=Meizu>>build.prop
echo ro.build.display.id=WangUI %version%>>build.prop
echo ro.product.model=m2 note>>build.prop
echo ro.product.name=m2note>>build.prop
echo ro.product.device=m2note>>build.prop
echo ro.product.board=m2note>>build.prop
echo # ro.build.product is obsolete; use ro.product.device>>build.prop
echo ro.build.product=m2note>>build.prop
echo # Do not try to parse ro.build.description or .fingerprint>>build.prop
echo ro.build.description=meizu_m2note-user 5.1 LMY47D %version% release-keys >>build.prop
echo ro.build.fingerprint=Meizu/meizu_m2note/m2note:5.1/LMY47D/%version%:user/release-keys>>build.prop
echo ro.flyme.published = true>>build.prop
echo ro.meizu.has_datamigration_app=true>>build.prop