@echo off

echo Dockerfile内のDISPLAY=の部分を自動で書き換え、
echo Dockerfile.txtをもとにDockerfileを作成します。
SET /P ANSWER="よろしいですか (Y/N)？"

if /i {%ANSWER%}=={y} (goto :yes)
if /i {%ANSWER%}=={yes} (goto :yes)

EXIT


:yes
for /f "tokens=1,2* usebackq delims=^:" %%i in (`ipconfig ^| findstr /n /r "." ^| findstr /r "IPv4 Address"`) DO @set IP=%%k

rem 取得したIPアドレス前後のスペースを削除
call :Trim %IP%

set BEFORE_STRING=172.27.224.1
set AFTER_STRING=%IP%

if exist Dockerfile rm -f Dockerfile

set INPUT_FILE=Dockerfile.txt
set OUTPUT_FILE=Dockerfile

setlocal enabledelayedexpansion
for /f "delims=" %%a in (%INPUT_FILE%) do (
set line=%%a
echo !line:%BEFORE_STRING%=%AFTER_STRING%!>>%OUTPUT_FILE%
)

echo.
echo Dockerfileの書き換えが終了…
echo.
echo 続いてDockerfileをもとにイメージを作成します。
SET /P ANSWER="よろしいですか (Y/N)？"

if /i {%ANSWER%}=={y} (goto :yes)
if /i {%ANSWER%}=={yes} (goto :yes)

EXIT


:yes
:yes
docker build -t feappv-dev .


echo.
echo Dockerfileからイメージを作成しました。
echo.
echo 続いて作成したイメージからコンテナ―を作成します。
echo.
SET /P ANSWER="よろしいですか (Y/N)？"

if /i {%ANSWER%}=={y} (goto :yes)
if /i {%ANSWER%}=={yes} (goto :yes)

EXIT


:yes
docker run --name feappv5_1 -it -v %CD%:/feappv/decks/ feappv-dev

:Trim
set IP=%*
