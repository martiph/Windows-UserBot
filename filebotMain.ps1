$privateSharePath = "\\192.168.10.41\Secret"
$publicSharePath = "\\192.168.10.41\Public"

if (-not (Test-Path -Path "S:")) {
    Write-Host "Please enter the credentials for the private share"
    New-PSDrive -Name "S" -PSProvider "Filesystem" -Root $privateSharePath -Description "The secret share" -Credential (Get-Credential) -Persist
}

if (-not (Test-Path -Path "P:")) {
    New-PSDrive -Name "P" -PSProvider "Filesystem" -Root $publicSharePath -Description "The public Share" -Persist
}

Start-Process -FilePath pwsh -ArgumentList "-NoExit -Command &'$PSScriptRoot/filebotReadPrivate.ps1'" 
Start-Process -FilePath pwsh -ArgumentList "-NoExit -Command &'$PSScriptRoot/filebotWritePrivate.ps1'"

Start-Process -FilePath pwsh -ArgumentList "-NoExit -Command &'$PSScriptRoot/filebotReadPublic.ps1'"
Start-Process -FilePath pwsh -ArgumentList "-NoExit -Command &'$PSScriptRoot/filebotWritePublic.ps1'"
