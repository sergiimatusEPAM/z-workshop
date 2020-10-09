@echo off

set DOCKER_IMAGE 1>NUL 2>NUL
if errorlevel 1 echo DOCKER_IMAGE environment variable must be set && exit /b 1

set SCRIPT_PATH 1>NUL 2>NUL
if errorlevel 1 echo SCRIPT_PATH environment variable must be set && exit /b 1

for /f "tokens=*" %%G in ('dir /b') do call set volumes=%%volumes%% -v "%cd%\%%G:C:\Concourse\%%G"
if errorlevel 1 exit /b %errorlevel%

echo. 2>environmentVariables.txt
if errorlevel 1 exit /b %errorlevel%

for /f "tokens=*" %%G in ('set ^| findstr ENV_') do echo %%G >> environmentVariables.txt
if errorlevel 1 exit /b %errorlevel%

powershell -Command "(gc environmentVariables.txt) -replace 'ENV_', '' | Out-File environmentVariables.txt -Encoding ascii"
if errorlevel 1 exit /b %errorlevel%

set WORKING_DIRECTORY 1>NUL 2>NUL
if errorlevel 1 (set workingDirectory=Concourse && cmd /c "exit /b 0") else (set workingDirectory=Concourse\%WORKING_DIRECTORY%)
if errorlevel 1 exit /b %errorlevel%

docker pull %DOCKER_IMAGE%
if errorlevel 1 exit /b %errorlevel%

docker run ^
    --entrypoint "%SCRIPT_PATH%" ^
    -w "C:\%workingDirectory%" ^
    %volumes% ^
    --env-file environmentVariables.txt ^
    --rm ^
    %DOCKER_IMAGE%
if errorlevel 1 exit /b %errorlevel%