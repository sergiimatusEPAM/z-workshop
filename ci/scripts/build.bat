@echo off

nuget restore -Verbosity normal
if %errorlevel% neq 0 exit /b %errorlevel%

msbuild -p:Configuration=Release ^
        -p:WarningLevel=0
if %errorlevel% neq 0 exit /b %errorlevel%

dotnet.exe test TestProject.csproj --configuration Release --no-build -v n
if %errorlevel% neq 0 exit /b %errorlevel%
