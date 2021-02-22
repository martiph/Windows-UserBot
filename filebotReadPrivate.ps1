function GetAllFilesInDirectory([string]$directory) {
    Set-Location $directory

    # get every file in this directory
    $allFilesInDirectory = Get-ChildItem -File

    # get every subdirectory
    $allDirectories = Get-ChildItem -Directory

    foreach ($dir in $allDirectories) {
        $allFilesInSubdirectory = GetAllFilesInDirectory($dir.FullName)
        foreach ($file in $allFilesInSubdirectory) {
            $allFilesInDirectory += $file
        }
    }
    return $allFilesInDirectory
}

while ($true) {
    Set-Location -Path S:
    $allFiles = $null
    Write-Host  "started file reading loop on private share"
    $allFiles = GetAllFilesInDirectory((Get-Location))
    Write-Host $allFiles
    if ($null -ne $allFiles) {
        foreach ($file in $allFiles) {
            Get-Content -Path $file
            Start-Sleep -Seconds (Get-Random -Maximum 10 -Minimum 1)
        }
    }
    else {
        Write-Host "no file found"
    }
    Write-Host "finished file reading loop on private share"
}
