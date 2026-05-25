$logDir = 'd:\MC-Server\Minecraft_Network\1_Velocity_Proxy\logs'
$gzFiles = Get-ChildItem "$logDir\*.log.gz" | Sort-Object LastWriteTime -Descending
foreach ($f in $gzFiles) {
    Write-Host "=== $($f.Name) ===" -ForegroundColor Cyan
    $fs = [System.IO.File]::OpenRead($f.FullName)
    $gz = New-Object System.IO.Compression.GZipStream($fs, [System.IO.Compression.CompressionMode]::Decompress)
    $sr = New-Object System.IO.StreamReader($gz)
    Write-Host $sr.ReadToEnd()
    $sr.Close(); $gz.Close(); $fs.Close()
}
Write-Host "`n=== latest.log ===" -ForegroundColor Cyan
$latestLog = "$logDir\latest.log"
if ((Get-Item $latestLog).Length -gt 0) {
    Get-Content $latestLog
} else {
    Write-Host "(empty)"
}
