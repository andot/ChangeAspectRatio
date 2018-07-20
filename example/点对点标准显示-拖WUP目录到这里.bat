@ECHO OFF
Cls

set PDR=%~dp0
set WAY=%~f1

cd "%WAY%"

"%PDR%CDecrypt.exe" title.tmd title.tik "%PDR%ckey.bin"

md DecryptFiles
move code DecryptFiles
move meta DecryptFiles
move content DecryptFiles

cd DecryptFiles/code

for /f "delims=" %%i in ('dir /b "*.rpx"') do (
    set RPXFILE=%%i
)

"%PDR%wiiurpxtool.exe" -d %RPXFILE%
"%PDR%ChangeAspectRatio.exe" %RPXFILE%
"%PDR%wiiurpxtool.exe" -c %RPXFILE%

cd ../..

move DecryptFiles "%PDR%"

cd "%PDR%"

java -jar NUSPacker.jar -in DecryptFiles -out WupFiles

rd /s /q tmp
rd /s /q output

move "%PDR%WupFiles" "%WAY% (PIXEL)"

rd /s /q DecryptFiles

ECHO OK.
pause>NUL
