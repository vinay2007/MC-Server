# Fix FastLogin SQLite issue on Velocity
$pluginDir = "d:\MC-Server\Minecraft_Network\1_Velocity_Proxy\plugins"
$sqliteUrl = "https://repo1.maven.org/maven2/org/xerial/sqlite-jdbc/3.46.1.0/sqlite-jdbc-3.46.1.0.jar"
$sqliteDest = "d:\MC-Server\Minecraft_Network\1_Velocity_Proxy\sqlite-jdbc.jar"

Write-Host "Downloading SQLite JDBC driver..." -ForegroundColor Cyan
Invoke-WebRequest -Uri $sqliteUrl -OutFile $sqliteDest -UseBasicParsing
Write-Host "SQLite JDBC downloaded to $sqliteDest" -ForegroundColor Green

# Update the start_proxy.bat to include sqlite on classpath
$batPath = "d:\MC-Server\Minecraft_Network\1_Velocity_Proxy\start_proxy.bat"
$batContent = @"
@echo off
java -Xmx1G -Xms1G -cp "sqlite-jdbc.jar;velocity.jar" com.velocitypowered.proxy.Velocity
pause
"@
Set-Content -Path $batPath -Value $batContent -Encoding ASCII
Write-Host "Updated start_proxy.bat to include SQLite on classpath" -ForegroundColor Green
Write-Host ""
Write-Host "Now restart the Velocity proxy using start_proxy.bat" -ForegroundColor Yellow
