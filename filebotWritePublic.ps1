Set-Location -Path P:
[string[]]$locations = (Get-ChildItem -Directory).FullName
$locations += Get-Location
Write-Host $locations

while ($true) {
    Set-Location -Path $locations[(Get-Random -Minimum 0 -Maximum $locations.Length)]
    Write-Host "started file writing loop on public share"
    $name = [guid]::NewGuid().ToString()
    New-Item -ItemType File -Name "$name.txt"
    Add-Content -Path "$name.txt" -Value "$name"
    Start-Sleep -Seconds (Get-Random -Maximum 100 -Minimum 10)
    Write-Host "finished file writing loop on public share"
}
