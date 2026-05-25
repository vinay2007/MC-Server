# Setup Minecraft Network automated builder
$ErrorActionPreference = "Stop"

# Define base directories
$BaseDir = "d:\MC-Server\Minecraft_Network"
$ProxyDir = "$BaseDir\1_Velocity_Proxy"
$ServerDir = "$BaseDir\2_Paper_Server"
$ProxyPluginsDir = "$ProxyDir\plugins"
$ServerPluginsDir = "$ServerDir\plugins"

Write-Host "=============================================" -ForegroundColor Cyan
Write-Host "Creating Minecraft Network Directory Structure" -ForegroundColor Cyan
Write-Host "=============================================" -ForegroundColor Cyan

# 1. Create Directories
$Dirs = @($BaseDir, $ProxyDir, $ServerDir, $ProxyPluginsDir, $ServerPluginsDir)
foreach ($Dir in $Dirs) {
    if (-not (Test-Path $Dir)) {
        New-Item -ItemType Directory -Path $Dir | Out-Null
        Write-Host "Created: $Dir" -ForegroundColor Green
    } else {
        Write-Host "Exists: $Dir" -ForegroundColor Yellow
    }
}

Write-Host "`n=============================================" -ForegroundColor Cyan
Write-Host "Downloading Execution Jars (Velocity & Paper)" -ForegroundColor Cyan
Write-Host "=============================================" -ForegroundColor Cyan

$UserAgent = "MinecraftNetworkUpdater/1.0"
$Headers = @{ "User-Agent" = $UserAgent }

# Download Velocity
Write-Host "Fetching latest Velocity version..." -ForegroundColor Gray
$VelocityVersions = (Invoke-RestMethod -Uri "https://api.papermc.io/v2/projects/velocity" -Headers $Headers).versions
$LatestVelocityVersion = $VelocityVersions[-1]
$VelocityBuilds = (Invoke-RestMethod -Uri "https://api.papermc.io/v2/projects/velocity/versions/$LatestVelocityVersion" -Headers $Headers).builds
$LatestVelocityBuild = $VelocityBuilds[-1]
$VelocityFileName = "velocity-$LatestVelocityVersion-$LatestVelocityBuild.jar"
$VelocityUrl = "https://api.papermc.io/v2/projects/velocity/versions/$LatestVelocityVersion/builds/$LatestVelocityBuild/downloads/$VelocityFileName"

Write-Host "Downloading Velocity version $LatestVelocityVersion build $LatestVelocityBuild..." -ForegroundColor Gray
Invoke-WebRequest -Uri $VelocityUrl -OutFile "$ProxyDir\velocity.jar" -Headers $Headers
Write-Host "Velocity downloaded successfully!" -ForegroundColor Green

# Download Paper
Write-Host "Fetching latest Paper version..." -ForegroundColor Gray
$PaperVersions = (Invoke-RestMethod -Uri "https://api.papermc.io/v2/projects/paper" -Headers $Headers).versions
$LatestPaperVersion = $PaperVersions[-1]
$PaperBuilds = (Invoke-RestMethod -Uri "https://api.papermc.io/v2/projects/paper/versions/$LatestPaperVersion" -Headers $Headers).builds
$LatestPaperBuild = $PaperBuilds[-1]
$PaperFileName = "paper-$LatestPaperVersion-$LatestPaperBuild.jar"
$PaperUrl = "https://api.papermc.io/v2/projects/paper/versions/$LatestPaperVersion/builds/$LatestPaperBuild/downloads/$PaperFileName"

Write-Host "Downloading Paper version $LatestPaperVersion build $LatestPaperBuild..." -ForegroundColor Gray
Invoke-WebRequest -Uri $PaperUrl -OutFile "$ServerDir\paper.jar" -Headers $Headers
Write-Host "Paper downloaded successfully!" -ForegroundColor Green

Write-Host "`n=============================================" -ForegroundColor Cyan
Write-Host "Writing Startup Batch Scripts" -ForegroundColor Cyan
Write-Host "=============================================" -ForegroundColor Cyan

# start_proxy.bat
$ProxyBatContent = @"
@echo off
java -Xmx1G -Xms1G -jar velocity.jar
pause
"@
$ProxyBatContent | Out-File -FilePath "$ProxyDir\start_proxy.bat" -Encoding ascii
Write-Host "Created start_proxy.bat" -ForegroundColor Green

# start_server.bat
$ServerBatContent = @"
@echo off
java -Xmx4G -Xms4G -jar paper.jar nogui
pause
"@
$ServerBatContent | Out-File -FilePath "$ServerDir\start_server.bat" -Encoding ascii
Write-Host "Created start_server.bat" -ForegroundColor Green

Write-Host "`n=============================================" -ForegroundColor Cyan
Write-Host "Downloading Plugin Modules" -ForegroundColor Cyan
Write-Host "=============================================" -ForegroundColor Cyan

# Download SkinsRestorer
Write-Host "Downloading SkinsRestorer (GitHub Release)..." -ForegroundColor Gray
$SkinsRestorerUrl = "https://github.com/SkinsRestorer/SkinsRestorer/releases/latest/download/SkinsRestorer.jar"
Invoke-WebRequest -Uri $SkinsRestorerUrl -OutFile "$ProxyPluginsDir\SkinsRestorer.jar" -Headers $Headers
Copy-Item -Path "$ProxyPluginsDir\SkinsRestorer.jar" -Destination "$ServerPluginsDir\SkinsRestorer.jar"
Write-Host "SkinsRestorer placed in Proxy & Paper plugins directories!" -ForegroundColor Green

# Download FastLogin Velocity
Write-Host "Downloading FastLogin Velocity (CodeMC Jenkins)..." -ForegroundColor Gray
$FastLoginVelocityUrl = "https://ci.codemc.io/job/Games647/job/FastLogin/lastSuccessfulBuild/artifact/velocity/target/FastLoginVelocity.jar"
Invoke-WebRequest -Uri $FastLoginVelocityUrl -OutFile "$ProxyPluginsDir\FastLogin.jar" -Headers $Headers
Write-Host "FastLogin Velocity version placed in Proxy plugins!" -ForegroundColor Green

# Download FastLogin Bukkit
Write-Host "Downloading FastLogin Bukkit (CodeMC Jenkins)..." -ForegroundColor Gray
$FastLoginBukkitUrl = "https://ci.codemc.io/job/Games647/job/FastLogin/lastSuccessfulBuild/artifact/bukkit/target/FastLoginBukkit.jar"
Invoke-WebRequest -Uri $FastLoginBukkitUrl -OutFile "$ServerPluginsDir\FastLogin.jar" -Headers $Headers
Write-Host "FastLogin Bukkit version placed in Paper plugins!" -ForegroundColor Green

# Download AuthMe Reloaded Paper
Write-Host "Downloading AuthMe Reloaded Paper (CodeMC Jenkins)..." -ForegroundColor Gray
$AuthMePaperUrl = "https://ci.codemc.org/job/AuthMe/job/AuthMeReloaded/lastSuccessfulBuild/artifact/authme-paper/target/AuthMe-6.0.1-SNAPSHOT-Paper.jar"
Invoke-WebRequest -Uri $AuthMePaperUrl -OutFile "$ServerPluginsDir\AuthMe-Reloaded.jar" -Headers $Headers
Write-Host "AuthMe Reloaded Paper version placed in Paper plugins!" -ForegroundColor Green

# Download LuckPerms Bukkit
Write-Host "Downloading LuckPerms Bukkit..." -ForegroundColor Gray
$LuckPermsMetadata = Invoke-RestMethod -Uri "https://metadata.luckperms.net/data/downloads"
$LuckPermsUrl = $LuckPermsMetadata.downloads.bukkit
Invoke-WebRequest -Uri $LuckPermsUrl -OutFile "$ServerPluginsDir\LuckPerms.jar" -Headers $Headers
Write-Host "LuckPerms Bukkit version placed in Paper plugins!" -ForegroundColor Green

Write-Host "`n=============================================" -ForegroundColor Cyan
Write-Host "Setup Completed Successfully!" -ForegroundColor Green
Write-Host "=============================================" -ForegroundColor Cyan
