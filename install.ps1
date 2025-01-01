# Copyright (c) cyberyurei2000 2024-2025
# Released under the BSD 3-Clause License
# https://opensource.org/license/bsd-3-clause

$Dir = [Environment]::CurrentDirectory
$IsScriptPath = Test-Path -Path "C:\bin\scripts"

function Set-Scripts {
    if($null -eq $IsScriptPath) {
        New-Item -Path "C:\bin" -Name "scripts" -ItemType "Directory" -Force
    }
    $BinPath = "C:\bin\scripts"

    Copy-Item -Path "$Dir\bin\windows\vcr.ps1" -Destination "$BinPath\vcr.ps1" -Force
}

#Set-Scripts
