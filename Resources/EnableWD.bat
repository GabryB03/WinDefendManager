@echo off
set "services=HKLM\SYSTEM\ControlSet001\Services"

:: Windows Defender
reg add "%services%\MsSecCore" /v "Start" /t REG_DWORD /d "0" /f >NUL 2>nul
reg add "HKLM\SYSTEM\ControlSet001\Services\MsSecFlt" /v "Start" /t REG_DWORD /d "0" /f >NUL 2>nul
reg add "%services%\MsSecWfp" /v "Start" /t REG_DWORD /d "3" /f >NUL 2>nul
reg add "HKLM\SYSTEM\ControlSet001\Services\SecurityHealthService" /v "Start" /t REG_DWORD /d "3" /f >NUL 2>nul
reg add "HKLM\SYSTEM\ControlSet001\Services\Sense" /v "Start" /t REG_DWORD /d "3" /f >NUL 2>nul
reg add "HKLM\SYSTEM\ControlSet001\Services\WdBoot" /v "Start" /t REG_DWORD /d "0" /f >NUL 2>nul
reg add "HKLM\SYSTEM\ControlSet001\Services\WdFilter" /v "Start" /t REG_DWORD /d "0" /f >NUL 2>nul
reg add "HKLM\SYSTEM\ControlSet001\Services\WdNisDrv" /v "Start" /t REG_DWORD /d "3" /f >NUL 2>nul
reg add "HKLM\SYSTEM\ControlSet001\Services\WdNisSvc" /v "Start" /t REG_DWORD /d "3" /f >NUL 2>nul
reg add "HKLM\SYSTEM\ControlSet001\Services\WinDefend" /v "Start" /t REG_DWORD /d "2" /f >NUL 2>nul
reg add "%services%\wscsvc" /v "Start" /t REG_DWORD /d "2" /f >NUL 2>nul
reg add "%services%\MDCoreSvc" /v "Start" /t REG_DWORD /d "2" /f >NUL 2>nul

:: WindowsSystemTray
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "SecurityHealth" /t REG_EXPAND_SZ /d "%systemroot%\system32\SecurityHealthSystray.exe" /f >NUL 2>nul

:: SystemGuard
reg add "HKLM\SYSTEM\ControlSet001\Services\SgrmAgent" /v "Start" /t REG_DWORD /d "0" /f >NUL 2>nul
reg add "HKLM\SYSTEM\ControlSet001\Services\SgrmBroker" /v "Start" /t REG_DWORD /d "2" /f >NUL 2>nul

:: WebThreatDefSvc
reg add "HKLM\SYSTEM\ControlSet001\Services\webthreatdefsvc" /v "Start" /t REG_DWORD /d "3" /f >NUL 2>nul
reg add "HKLM\SYSTEM\ControlSet001\Services\webthreatdefusersvc" /v "Start" /t REG_DWORD /d "2" /f >NUL 2>nul
for /f %%i in ('reg query "HKLM\SYSTEM\ControlSet001\Services" /s /k "webthreatdefusersvc" /f 2^>nul ^| find /i "webthreatdefusersvc" ') do (
  reg add "%%i" /v "Start" /t REG_DWORD /d "2" /f >NUL 2>nul
)

:: Windows Defender Smartscreen
reg delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\smartscreen.exe" /f >NUL 2>nul
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Associations" /f >NUL 2>nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "SmartScreenEnabled" /t REG_SZ /d "On" /f >NUL 2>nul
reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\SmartScreen" /f >NUL 2>nul
reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates" /f >NUL 2>nul

reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\AppHost" /v "EnableWebContentEvaluation" /f >NUL 2>nul
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\AppHost" /v "PreventOverride" /f >NUL 2>nul
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\AppHost" /v "EnableWebContentEvaluation" /f >NUL 2>nul

::Smart App Control
reg delete "HKLM\SYSTEM\ControlSet001\Control\CI\Policy" /v "VerifiedAndReputablePolicyState" /f >NUL 2>nul

:: Remove Defender policies
reg delete "HKLM\Software\Policies\Microsoft\Windows Defender" /f >NUL 2>nul
reg delete "HKLM\Software\Policies\Microsoft\Windows Advanced Threat Protection" /f >NUL 2>nul
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center" /f >NUL 2>nul

::Configure detection for potentially unwanted applications
reg add "HKLM\Software\Microsoft\Windows Defender" /v "PUAProtection" /t REG_DWORD /d "1" /f >NUL 2>nul

::Device Security
reg delete "HKLM\SYSTEM\ControlSet001\Control\CI\Config" /v "VulnerableDriverBlocklistEnable" /f >NUL 2>nul
reg delete "HKLM\SYSTEM\ControlSet001\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v "Enabled" /f >NUL 2>nul

for %%j in (
	"%systemroot%\system32\smartscreen.exe"
) do (
	if not exist %%j if exist "%%j.revi" ren "%%j.revi" "smartscreen.exe" >NUL 2>nul
)

:: Group Policies
reg delete "HKLM\Software\Policies\Microsoft\Windows Defender" /f >NUL 2>nul

:: New entries
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.SecurityAndMaintenance" /v "Enabled" /t REG_DWORD /d "1" /f >NUL 2>nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\SmartScreenEnabled" /v "@" /t REG_DWORD /d "1" /f >NUL 2>nul
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\WTDS\Components" /v "ServiceEnabled" /t REG_DWORD /d "01 /f >NUL 2>nul
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\AppHost" /v "PreventOverride" /t REG_DWORD /d "1" /f >NUL 2>nul
reg add "HKLM\SYSTEM\ControlSet001\Control\WMI\Autologger\DefenderApiLogger'" /v "Start" /t REG_DWORD /d "1" /f >NUL 2>nul

goto :EOF