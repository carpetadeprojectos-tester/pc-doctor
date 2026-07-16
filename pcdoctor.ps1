# PC Doctor diagnostic script
Write-Host "===== SYSTEM INFO ====="
systeminfo | Where-Object { $_ -match "OS Name|OS Version|System Manufacturer|System Model|System Type|Total Physical Memory|Available Physical Memory|BIOS Version|Domain|Logon Server" }

Write-Host ""
Write-Host "===== DISK DRIVES ====="
Get-WmiObject Win32_DiskDrive | Select-Object Model, Status, Size | Format-Table -AutoSize | Out-String -Width 120

Write-Host "===== DISK SPACE (C:) ====="
Get-WmiObject Win32_LogicalDisk -Filter "DriveType=3" | Select-Object DeviceID,
    @{N='Size(GB)';E={[math]::Round($_.Size/1GB,1)}},
    @{N='Free(GB)';E={[math]::Round($_.FreeSpace/1GB,1)}},
    @{N='Free%';E={[math]::Round(($_.FreeSpace/$_.Size)*100,1)}} | Format-Table -AutoSize | Out-String -Width 120

Write-Host "===== CPU ====="
Get-WmiObject Win32_Processor | Select-Object Name, NumberOfCores, NumberOfLogicalProcessors, LoadPercentage | Format-Table -AutoSize | Out-String -Width 160

Write-Host "===== MEMORY ====="
$mem = Get-WmiObject Win32_OperatingSystem
$free = [math]::Round($mem.FreePhysicalMemory/1MB,1)
$tot  = [math]::Round($mem.TotalVisibleMemorySize/1MB,1)
Write-Host "Total: $tot GB   Free: $free GB   Used: $([math]::Round($tot-$free,1)) GB ($([math]::Round(($tot-$free)/$tot*100,1))% used)"

Write-Host ""
Write-Host "===== TOP PROCESSES (by memory) ====="
Get-Process | Sort-Object WorkingSet -Descending | Select-Object -First 12 Name,
    @{N='CPU(s)';E={$_.CPU}},
    @{N='Mem(MB)';E={[math]::Round($_.WorkingSet/1MB,1)}} | Format-Table -AutoSize | Out-String -Width 120

Write-Host "===== TOP PROCESSES (by CPU) ====="
Get-Process | Where-Object {$_.CPU -gt 0} | Sort-Object CPU -Descending | Select-Object -First 12 Name,
    @{N='CPU(s)';E={$_.CPU}},
    @{N='Mem(MB)';E={[math]::Round($_.WorkingSet/1MB,1)}} | Format-Table -AutoSize | Out-String -Width 120

Write-Host "===== RECENT SYSTEM ERRORS ====="
$errs = Get-EventLog -LogName System -EntryType Error -Newest 12 -ErrorAction SilentlyContinue
if ($errs) {
    $errs | Select-Object TimeGenerated, Source, @{N='Msg';E={($_.Message -split "`n")[0]}} | Format-Table -AutoSize -Wrap | Out-String -Width 220
} else { Write-Host "No recent system errors found." }

Write-Host "===== BATTERY (if present) ====="
$bat = Get-WmiObject Win32_Battery
if ($bat) { $bat | Select-Object EstimatedChargeRemaining, BatteryStatus, DesignCapacity, FullChargeCapacity | Format-Table -AutoSize | Out-String -Width 120 } else { Write-Host "No battery (desktop) or not reported." }

Write-Host "===== UPTIME ====="
$os = Get-WmiObject Win32_OperatingSystem
$up = (Get-Date) - $os.ConvertToDateTime($os.LastBootUpTime)
Write-Host "Last boot: $($os.ConvertToDateTime($os.LastBootUpTime))   Uptime: $($up.Days)d $($up.Hours)h $($up.Minutes)m"
