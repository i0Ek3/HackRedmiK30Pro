@echo off
mode con cols=100 lines=30
TITLE Redmi K30 Pro(lmi) Flash Script 
color 2f
echo. -----------------------------------------------------------------
echo. Confirm the computer installed USB driver
echo.
echo.    1. Open phone USB debugging mode
echo.
echo.    2. Connect Phone to the computer
echo.
echo. Press any key to continue...
echo. -----------------------------------------------------------------
pause >NUL 2>NUL
CLS
for /f "tokens=5" %%i in ('netstat -nao ^|find /i "listening" ^|find /i "5037"') do taskkill /f /pid %%i 
adb reboot bootloader

:MENU1
CLS
echo. ----------------------------------------
echo. Please enter 1 ^| 2 select what you need
echo.
echo.    1. Flash TWRP Without Decrypt
echo.
echo.    2. Flash vbmeta.img to Decrypt(Before Flashing vbmeta.img Please Flash the no_replace_twrp_avb2.zip Manually)
echo.
echo.    3. Reset Factory(Please Ensure Your Phone Under the Fastboot Mode and Then Uncompress Your Fastboot Package and Move Folder /images into Root)
echo.
echo.    4. Exit
echo. ----------------------------------------

set choice=
set /p choice= Your choice:
IF NOT "%Choice%"=="" SET Choice=%Choice:~0,1%
if /i "%choice%"=="1" goto TWRP
if /i "%choice%"=="2" goto VBMETA
if /i "%choice%"=="3" goto FASTBOOT
if /i "%choice%"=="4" goto EXIT
echo.
echo. Choice is invalid, please enter again
echo.
goto MENU1

:TWRP
CLS
echo. ---------------------------------------
echo. Flashing TWRP...
fastboot flash recovery_ramdisk twrp.img
goto OKorNo%ERRORLEVEL%

:VBMETA
CLS
echo. ---------------------------------------
echo. Flashing vbmeta.img...
fastboot --disable-verity --disable-verification flash vbmeta vbmeta.img
goto OKorNo%ERRORLEVEL%

:FASTBOOT
CLS
echo. ---------------------------------------
echo. Resetting Fastboot...
echo.   Please Uncompress the Fastboot Package Under the Root
.\flash_all.bat

:OKorNo0
CLS
echo. ---------------------------------------
echo. Flash successfully!
color 2f
echo. ------------------------------------------------------------------------------
pause >NUL 2>NUL
fastboot reboot
echo.
echo. Flash process completed, press any key to close this window!
pause >NUL 2>NUL

:EXIT
exit

:OKorNo1
echo. ---------------------------------------
echo. Flash abortively!
pause
exit
