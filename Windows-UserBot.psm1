function Start-UserBot {

    param(
        [string[]]$Services
    )

    

}

function Start-BrowserProcess {

    # This functions opens a browser and visits duckduckgo.com or another site provided as a parameter. By default the script waits with starting the next website for 30 seconds.
    param(
    [ValidateNotNullOrEmpty()]
    [string[]] $Websites = "https://duckduckgo.com",
    [int] $Sleep = 30
    )

    foreach ($Website in $Websites){
        $global:BrowserProcesses += Start-Process $Website -Passthru
        Start-Sleep -Seconds $Sleep
    }

    # maybe on windows one could start a website in a specific browser using the following code:
    # [system.Diagnostics.Process]::Start("firefox","https://debug.to")
    # just replace "firefox" with "chrome", "msedge" or "iexplore"

}

function Stop-BrowserProcess {

    # This function closes all the processes that were started with "Start-BrowserProcess"    
    param(
        [int] $Sleep = 30
    )

    foreach ($Process in $global:BrowserProcesses){
        Stop-Process -Id $Process.Id
        Start-Sleep -Seconds $Sleep
    }

}

Start-RandomFileCreation {

    # creates a random number of txt-files (max 100) in the specified directory (default is the current directory), filename is a GUID

    param(
    [ValidateNotNullOrEmpty()]    
    [string]$Path = "./"
    )

    for ($i = 0; $i -le $(Get-Random -Maximum 100); $i++){
        New-Item -ItemType File -Name "$((New-Guid).Guid).txt" -Path $Path
    }

}

Start-RandomDirectoryCreation {

    # creates a random number of directories (max 100) in the specified directory (default is the current directory), directoryname is a GUID

    param(
    [ValidateNotNullOrEmpty()]    
    [string]$Path = "./"
    )

    for ($i = 0; $i -le $(Get-Random -Maximum 100); $i++){
        New-Item -ItemType Directory -Name "$((New-Guid).Guid)" -Path $Path
    }

}