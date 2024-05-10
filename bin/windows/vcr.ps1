# Copyright (c) cyberyurei2000 2024
# Released under the BSD 3-Clause License
# https://opensource.org/license/bsd-3-clause

$Url = $Args[0]
$VideoDir = "$HOME\Videos"
$LastDir = $(Get-Location)
$Date = $(Get-Date -Format "yyyyMMdd_HHmm")
$Counter = 0

if(Get-Command mpv -ErrorAction SilentlyContinue) {
    Set-Location -Path $VideoDir
    New-Item -Path ".\" -Name "VCR" -ItemType "Directory" -Force
    Set-Location -Path "$VideoDir\VCR"

    if(Test-Path -Path ".\stream.mkv") {
        $Counter += 1
        while(Test-Path -Path "stream${Counter}.mkv") {
            $Counter += 1
        }
    }

    if($Counter -gt 0) {
        mpv --no-resume-playback --stream-record=stream${COUNTER}.mkv $URL
    } else {
        mpv --no-resume-playback --stream-record=stream.mkv $URL
    }

    if(Test-Path -Path ".\stream.mkv" || Test-Path -Path ".\stream${Counter}.mkv") {
        $Name = Read-Host "vcr: save stream name as: "
        if($Counter -gt 0) {
            if($Name -ne "") {
                Rename-Item -Path ".\stream${Counter}.mkv" -NewName "${Name}_${Date}.mkv"
            }
        } else {
            if($Name -ne "") {
                Rename-Item -Path ".\stream.mkv" -NewName "${Name}_${Date}.mkv"
            }
        }
    }
    Set-Location -Path $LastDir
} else {
    Write-Output "ERROR: mpv is necessary for executing this script"
}
