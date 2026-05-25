@echo off
title playit.gg Tunnel Agent
echo ==============================================
echo Starting playit.gg Tunnel...
echo ==============================================

set PLAYIT_EXE="D:\MC-Server\Minecraft_Network\playit.exe"

echo.
echo Starting playit.gg... 
echo If it asks to claim, click the link provided in this window.
echo.

if not exist %PLAYIT_EXE% (
    echo [ERROR] playit.exe not found at %PLAYIT_EXE%
    pause
    exit /b
)

%PLAYIT_EXE%
pause
