@echo off
set selekshn=0
set version=1.0.0

if not exist "files\fistrun.conf" (
echo make sure to enable adb on the device before continuing
echo learn more at
echo https://shorturl.at/GAiPz
pause

echo. >"files\fistrun.conf"
)


:a

cls

echo ADB Helper v%version%
echo.
echo ^%jedna% Shell
echo ^%dva% Logcat
echo ^%tri% Reboot to...
echo ^%ctyri% Change battery percentage
echo ^%pet% Reset battery percentage
echo ^%sest% Exit

files\getinput.exe 294 296 13

if %errorlevel%==1 (set /a selekshn=%selekshn%-1)
if %errorlevel%==2 (set /a selekshn=%selekshn%+1)
if %errorlevel%==3 (goto selectd)

set jedna=
set dva=
set tri=
set ctyri=
set pet=
set sest=

if %selekshn%==0 (set /a selekshn=6)
if %selekshn%==7 (set /a selekshn=1)

if %selekshn%==1 (set jedna=^>)
if %selekshn%==2 (set dva=^>)
if %selekshn%==3 (set tri=^>)
if %selekshn%==4 (set ctyri=^>)
if %selekshn%==5 (set pet=^>)
if %selekshn%==6 (set sest=^>)

goto a

:selectd

if %selekshn%==1 (files\adb.exe shell)
if %selekshn%==2 (files\adb.exe logcat)
if %selekshn%==3 (goto rebutto)
if %selekshn%==4 (goto changpercent)
if %selekshn%==5 (start /min files\adb.exe shell dumpsys battery reset)
if %selekshn%==6 (goto :eof)

goto a

:rebutto

cls

echo ^%rbtJedna% Reboot normally
echo ^%rbtDva% Reboot to bootloader
echo ^%rbtTri% Reboot to recovery
echo ^%rbtCtyri% Reboot to sideload

files\getinput.exe 294 296 13

if %errorlevel%==1 (set /a rbtSelekshn=%rbtSelekshn%-1)
if %errorlevel%==2 (set /a rbtSelekshn=%rbtSelekshn%+1)
if %errorlevel%==3 (goto selectdRbt)

set rbtJedna=
set rbtDva=
set rbtTri=
set rbtCtyri=

if %rbtSelekshn%==0 (set /a rbtSelekshn=5)
if %rbtSelekshn%==5 (set /a rbtSelekshn=1)

if %rbtSelekshn%==1 (set rbtJedna=^>)
if %rbtSelekshn%==2 (set rbtDva=^>)
if %rbtSelekshn%==3 (set rbtTri=^>)
if %rbtSelekshn%==4 (set rbtCtyri=^>)

goto rebutto

:selectdRbt

if %rbtSelekshn%==1 (files\adb.exe reboot)
if %rbtSelekshn%==2 (files\adb.exe reboot bootloader)
if %rbtSelekshn%==3 (files\adb.exe reboot recovery)
if %rbtSelekshn%==4 (files\adb.exe reboot sideload)

goto a

:changpercent

cls

set /p precetn=Percentage ^> 
start /min files\adb.exe shell dumpsys battery set level %precetn%

goto a