try { 
    $valheimPath = Get-ItemPropertyValue -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 892970" -Name InstallLocation
    $bepinex = $valheimPath+"\BepInEx" 
    $configPath = $bepinex+"\config\" 
    $pluginsPath = $bepinex+"\plugins\" 
    $patchersPath = $bepinex+"\patchers\" 
}
catch { 
    "Couldn't find Valheim folder through registry, install manually."
    return 
}

Write-Host "BepInEx folder found:"
Write-Host $bepinex
Write-Host 


RemoveFolder -targetFolder $configPath
RemoveFolder -targetFolder $pluginsPath
CopyToBepInEx -source .\config
CopyToBepInEx -source .\plugins

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

function CopyToBepInEx{
    param($source)

    Copy-Item $source -Destination $bepinex -Recurse
}