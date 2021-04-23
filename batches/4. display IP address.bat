@echo off

echo あなたのIPアドレスを調べるためのバッチです。
echo.
@pause

@ipconfig



for /f "tokens=1,2* usebackq delims=^:" %%i in (`ipconfig ^| findstr /n /r "." ^| findstr /r "IPv4 アドレス"`) DO @set IP=%%k

rem 取得したIPアドレス前後のスペースを削除
call :Trim %IP%

echo.
echo.
echo 以下をコピペしてください。
echo.
echo export DISPLAY=%IP%:0.0
echo alias feap="/feappv/feappv-5.1.1c/main/feappv"
echo.

@pause

:Trim
set IP=%*