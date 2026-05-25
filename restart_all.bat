@echo off
title Minecraft Network Restarter
echo ==============================================
echo Starting Minecraft Network...
echo ==============================================

echo.
echo [1/3] Starting Velocity Proxy...
cd /d "D:\MC-Server\Minecraft_Network\1_Velocity_Proxy"
start "Velocity Proxy" start_proxy.bat

echo.
echo Waiting 5 seconds for Proxy to initialize...
timeout /t 5 /nobreak > nul

echo.
echo [2/3] Starting Paper Server...
cd /d "D:\MC-Server\Minecraft_Network\2_Paper_Server"
start "Paper Server" start_server.bat

echo.
echo [3/3] Starting playit.gg Tunnel...
cd /d "D:\MC-Server"
start "playit.gg Tunnel" start_tunnel.bat

echo.
echo ==============================================
echo Network Startup Initiated!
echo ==============================================
pause
