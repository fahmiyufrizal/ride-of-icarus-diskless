@echo off

:init
 setlocal DisableDelayedExpansion
 set cmdInvoke=1
 set winSysFolder=System32
 set "batchPath=%~0"
 for %%k in (%0) do set batchName=%%~nk
 set "vbsGetPrivileges=%temp%\OEgetPriv_%batchName%.vbs"
 setlocal EnableDelayedExpansion

:checkPrivileges
  NET FILE 1>NUL 2>NUL
  if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges )

:getPrivileges
  if '%1'=='ELEV' (echo ELEV & shift /1 & goto gotPrivileges)

  ECHO Set UAC = CreateObject^("Shell.Application"^) > "%vbsGetPrivileges%"
  ECHO args = "ELEV " >> "%vbsGetPrivileges%"
  ECHO For Each strArg in WScript.Arguments >> "%vbsGetPrivileges%"
  ECHO args = args ^& strArg ^& " "  >> "%vbsGetPrivileges%"
  ECHO Next >> "%vbsGetPrivileges%"

  if '%cmdInvoke%'=='1' goto InvokeCmd 

  ECHO UAC.ShellExecute "!batchPath!", args, "", "runas", 1 >> "%vbsGetPrivileges%"
  goto ExecElevation

:InvokeCmd
  ECHO args = "/c """ + "!batchPath!" + """ " + args >> "%vbsGetPrivileges%"
  ECHO UAC.ShellExecute "%SystemRoot%\%winSysFolder%\cmd.exe", args, "", "runas", 1 >> "%vbsGetPrivileges%"

:ExecElevation
 "%SystemRoot%\%winSysFolder%\WScript.exe" "%vbsGetPrivileges%" %*
 exit /B

:gotPrivileges
 setlocal & cd /d %~dp0
 if '%1'=='ELEV' (del "%vbsGetPrivileges%" 1>nul 2>nul  &  shift /1)

:passfolder
del _fahmiyufrizal.io
title fahmiyufrizal@2021 [github.com/fahmiyufrizal] [Licensed to : 0]
cls 
echo.  
echo.  
echo     Icarus Online Valofe v2.7 for Diskless > _fahmiyufrizal.io
echo     by fahmiyufrizal@2021 >> _fahmiyufrizal.io
echo.  >> _fahmiyufrizal.io
type _fahmiyufrizal.io
echo     github.com/fahmiyufrizal
echo.
echo     Tip me at : trakteer.id/fahmiyufrizal/tip
ping 127.0.0.1 -n 4 > nul
if exist _fahmiyufrizal (
    goto passgan
) else (
    goto exportdulu
)

:exportdulu
mkdir _fahmiyufrizal
echo.
echo     [exp] Pastikan Icarus Online Valofe berjalan dengan baik
echo           di server!
pause
%SystemRoot%\System32\reg.exe export HKCR\SEA-IcarusOnline _fahmiyufrizal/icaruslaunch_hkcr.reg
%SystemRoot%\System32\reg.exe export HKLM\SOFTWARE\Classes\SEA-IcarusOnline _fahmiyufrizal/icaruslaunch_hklm.reg

:passgan
echo     [mkl] Creating mklink
mkdir C:\Valofe
mklink /J C:\Valofe\ICARUS "%~dp0"
echo     [reg] Setting registry...
%SystemRoot%\System32\reg.exe delete HKLM\SOFTWARE\Classes\SEA-IcarusOnline /f
%SystemRoot%\System32\reg.exe delete HKCR\SEA-IcarusOnline /f
%SystemRoot%\System32\reg.exe delete HKLM\SOFTWARE\WOW6432Node\Valofe\ICARUS_SEA /f
%SystemRoot%\System32\reg.exe import _fahmiyufrizal/icaruslaunch_hkcr.reg
%SystemRoot%\System32\reg.exe import _fahmiyufrizal/icaruslaunch_hklm.reg
%SystemRoot%\System32\reg.exe add HKLM\SOFTWARE\WOW6432Node\Valofe\ICARUS_SEA /v Version /t REG_DWORD /d 1000000
%SystemRoot%\System32\reg.exe add HKLM\SOFTWARE\WOW6432Node\Valofe\ICARUS_SEA /v InstallPath /t REG_SZ /d C:\Valofe\ICARUS
%SystemRoot%\System32\reg.exe add HKLM\SOFTWARE\WOW6432Node\Valofe\ICARUS_SEA /v Execute /t REG_SZ /d C:\Valofe\ICARUS\bin32\launcher.exe
echo     [lau] Launching IcarusLauncher...
start "" IcarusLauncher.exe
echo     [enj] Enjoy!...
ping 127.0.0.1 -n 4 > nul
exit