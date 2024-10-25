# Copyright (c) cyberyurei2000 2024
# Released under the BSD 3-Clause License
# https://opensource.org/license/bsd-3-clause

$Url = $Args[0]
$UserAgent = $Args[1]
$VideoDir = "$HOME\Videos"
$LastDir = $(Get-Location)
$Date = $(Get-Date -Format "yyyyMMdd_HHmmss")
$Counter = 0

if(Get-Command mpv -ErrorAction SilentlyContinue) {
    if(-Not(Test-Path -Path "${VideoDir}\VCR")) {
        New-Item -Path $VideoDir -Name "VCR" -ItemType "Directory"
    }
    Set-Location -Path "$VideoDir\VCR"

    if(Test-Path -Path ".\stream.mkv") {
        $Counter += 1
        while(Test-Path -Path "stream${Counter}.mkv") {
            $Counter += 1
        }
    }

    if($UserAgent -ne "") {
        $Args_ = "--user-agent=$UserAgent"
    } else {
        $Args_ = ""
    }

    if($Counter -gt 0) {
        $TempFile = "stream${Counter}.mkv"
    } else {
        $TempFile = "stream.mkv"
    }
    mpv $Args_ --no-resume-playback --stream-record=$TempFile $URL

    if(Test-Path -Path ".\${TempFile}") {
        if((Get-Item -Path ".\${TempFile}").length -ne 0) {
            $Name = Read-Host "vcr: save stream name as: "
            if($Name -ne "") {
                $FinalFile = "${Name}_${Date}.mkv"
            } else {
                $FinalFile = "stream_${Date}.mkv"
            }
            Rename-Item -Path ".\${TempFile}" -NewName "${FinalFile}"
        }
    }

    Set-Location -Path $LastDir
} else {
    Write-Output "ERROR: mpv is necessary for executing this script"
}
