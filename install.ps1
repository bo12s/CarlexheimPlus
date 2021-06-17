$valheimPath = Get-ItemPropertyValue -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 892970" -Name InstallLocation
$bepinex = $valheimPath+"\BepInEx\"
Write-Host $bepinex