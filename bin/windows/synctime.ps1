#Requires -RunAsAdministrator

# Copyright (c) cyberyurei2000 2024
# Released under the BSD 3-Clause License
# https://opensource.org/license/bsd-3-clause

$w32tmOutput = (& w32tm /stripchart /computer:time.windows.com /samples:1 /dataonly)[-1].Trim("s")
$currentTime = $w32tmOutput.Split(',')[0]

Write-Output "Current time on time.windows.com: $currentTime"
Write-Output "Syncing the time on the PC..."

Set-Date -Date "$currentTime"
if($?) {
    Write-Host "Time was sync sucessfully!" -ForegroundColor "Green"
} else {
    Write-Host "[ERROR] Failed to sync time" -ForegroundColor "Red"
}
