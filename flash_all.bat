fastboot %* getvar product 2>&1 | findstr /r /c:"^product: *lmi" || echo Missmatching image and device
fastboot %* getvar product 2>&1 | findstr /r /c:"^product: *lmi" || exit /B 1

::check anti_version
if exist %~dp0images\anti_version.txt (for /f "delims==" %%a in (%~dp0images\anti_version.txt) do (set CURRENT_ANTI_VER=%%a))
if [%CURRENT_ANTI_VER%] EQU [] set CURRENT_ANTI_VER=0
for /f "tokens=2 delims=: " %%i in ('fastboot %* getvar anti 2^>^&1 ^| findstr /r /c:"anti:"') do (set version=%%i)
if [%version%] EQU [] set version=0
set anticheck="antirollback check pass"
if %version% GTR %CURRENT_ANTI_VER% set anticheck="Current device antirollback version is greater than this pakcage"
echo %anticheck% | findstr /r /c:"pass" || @echo "Antirollback check error" && exit /B 1

fastboot %* erase boot || @echo "Erase boot error" && exit /B 1
fastboot %* flash crclist %~dp0images\crclist.txt || @echo "Flash crclist error" && exit /B 1
fastboot %* flash xbl_4 %~dp0images\xbl_4.elf || @echo "Flash xbl_4 error" && exit /B 1
::fastboot %* flash xblbak %~dp0images\xbl.elf || @echo "Flash xblbak error" && exit /B 1
fastboot %* flash xbl_config_4 %~dp0images\xbl_config_4.elf || @echo "Flash xbl_config_4 error" && exit /B 1
fastboot %* flash xbl_5 %~dp0images\xbl_5.elf || @echo "Flash xbl_5 error" && exit /B 1
::fastboot %* flash xblbak %~dp0images\xbl.elf || @echo "Flash xblbak error" && exit /B 1
fastboot %* flash xbl_config_5 %~dp0images\xbl_config_5.elf || @echo "Flash xbl_config_5 error" && exit /B 1
fastboot %* flash abl %~dp0images\abl.elf || @echo "Flash abl error" && exit /B 1
::fastboot %* flash ablbak %~dp0images\abl.elf || @echo "Flash ablbak error" && exit /B 1
fastboot %* flash tz %~dp0images\tz.mbn || @echo "Flash tz error" && exit /B 1
::fastboot %* flash tzbak %~dp0images\tz.mbn || @echo "Flash tzbak error" && exit /B 1
fastboot %* flash hyp %~dp0images\hyp.mbn || @echo "Flash hyp error" && exit /B 1
::fastboot %* flash hypbak %~dp0images\hyp.mbn || @echo "Flash hypbak error" && exit /B 1
fastboot %* flash devcfg %~dp0images\devcfg.mbn || @echo "Flash devcfg error" && exit /B 1
::fastboot %* flash devcfgbak %~dp0images\devcfg.mbn || @echo "Flash devcfgbak error" && exit /B 1
fastboot %* flash storsec %~dp0images\storsec.mbn || @echo "Flash storsec error" && exit /B 1
::fastboot %* flash storsecbak %~dp0images\storsec.mbn || @echo "Flash storsecbak error" && exit /B 1
fastboot %* flash bluetooth %~dp0images\BTFM.bin || @echo "Flash bluetooth error" && exit /B 1
fastboot %* flash cmnlib %~dp0images\cmnlib.mbn || @echo "Flash cmnlib error" && exit /B 1
::fastboot %* flash cmnlibbak %~dp0images\cmnlib.mbn || @echo "Flash cmnlibbak error" && exit /B 1
fastboot %* flash cmnlib64 %~dp0images\cmnlib64.mbn || @echo "Flash cmnlib64 error" && exit /B 1
::fastboot %* flash cmnlib64bak %~dp0images\cmnlib64.mbn || @echo "Flash cmnlib64bak error" && exit /B 1
fastboot %* flash modem %~dp0images\NON-HLOS.bin || @echo "Flash modem error" && exit /B 1
fastboot %* flash dsp %~dp0images\dspso.bin || @echo "Flash dsp error" && exit /B 1
fastboot %* flash keymaster %~dp0images\km4.mbn || @echo "Flash keymaster error" && exit /B 1
::fastboot %* flash keymasterbak %~dp0images\keymaster64.mbn || @echo "Flash keymasterbak error" && exit /B 1
fastboot %* flash logo %~dp0images\logo.img || @echo "Flash logo error" && exit /B 1
::fastboot %* flash splash %~dp0images\splash.img || @echo "Flash splash error" && exit /B 1
fastboot %* flash featenabler %~dp0images\featenabler.mbn || @echo "Flash featenabler error" && exit /B 1
fastboot %* flash misc %~dp0images\misc.img || @echo "Flash misc error" && exit /B 1
fastboot %* flash aop %~dp0images\aop.mbn || @echo "Flash aop error" && exit /B 1
fastboot %* flash qupfw %~dp0images\qupv3fw.elf || @echo "Flash qupfw error" && exit /B 1
fastboot %* flash uefisecapp %~dp0images\uefi_sec.mbn || @echo "Flash uefisecapp error" && exit /B 1
fastboot %* flash multiimgoem %~dp0images\multi_image.mbn || @echo "Flash multiimgoem error" && exit /B 1
fastboot %* flash vbmeta_system %~dp0images\vbmeta_system.img || @echo "Flash vbmeta_system error" && exit /B 1
fastboot %* flash vbmeta %~dp0images\vbmeta.img || @echo "Flash vbmeta error" && exit /B 1
fastboot %* flash dtbo %~dp0images\dtbo.img || @echo "Flash dtbo error" && exit /B 1
fastboot %* flash super %~dp0images\super.img || @echo "Flash super error" && exit /B 1
::fastboot %* flash odm %~dp0images\odm.img || @echo "Flash odm error" && exit /B 1
fastboot %* flash cache %~dp0images\cache.img || @echo "Flash cache error" && exit /B 1
fastboot %* erase metadata || @echo "Erase metadata error" && exit /B 1
fastboot %* flash userdata %~dp0images\userdata.img || @echo "Flash userdata error" && exit /B 1
fastboot %* flash recovery %~dp0images\recovery.img || @echo "Flash recovery error" && exit /B 1
::fastboot %* erase sec || @echo "Erase sec error" && exit /B 1
if exist %~dp0images\exaid.img (
    fastboot %* flash exaid %~dp0images\exaid.img || @echo "Flash exaid error" && exit /B 1
) else (
    fastboot %* erase exaid || @echo "Erase exaid error" && exit /B 1
)
fastboot %* flash cust %~dp0images\cust.img || @echo "Flash cust error" && exit /B 1
if exist %~dp0images\exaid.img (
    fastboot %* flash exaid %~dp0images\exaid.img || @echo "Flash exaid error" && exit /B 1
) else (
    fastboot %* erase exaid || @echo "Erase exaid error" && exit /B 1
)
fastboot %* flash boot %~dp0images\boot.img || @echo "Flash boot error" && exit /B 1
fastboot %* reboot || @echo "Reboot error" && exit /B 1
