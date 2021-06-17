try { 
    $valheimPath = Get-ItemPropertyValue -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 892970" -Name InstallLocation
    $bepinexPath = $valheimPath+"\BepInEx" 
    $configPath = $bepinexPath+"\config\" 
    $pluginsPath = $bepinexPath+"\plugins\" 
    $patchersPath = $bepinexPath+"\patchers\" 
}
catch { 
    "Couldn't find Valheim folder through registry, install manually."
    return 
}

Write-Host "Valheim folder found:"
Write-Host $valheimPath
Write-Host 


RemoveFolder -targetFolder $bepinexPath
CopyToValheim -source .\BepInEx

function RemoveFolder{
    param($targetFolder)

    Write-Host "Removing:"$targetFolder

    if (Test-Path $targetFolder) {        
        Remove-Item $targetFolder -Recurse
        Write-Host "Done!"
    }
    else
    {
        Write-Host "Not found."
    }
}

function CopyToValheim{
    param($source)

    Copy-Item $source -Destination $valheimPath -Recurse
}