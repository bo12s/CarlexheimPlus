try{
    if(Test-Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Git_is1'){
        $gitUninstall = Get-ItemPropertyValue -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Git_is1" -Name UninstallString
        $gitPath = Split-Path $gitUninstall
        $gitPath = $gitPath.TrimStart('"')
        Write-Host $gitPath
        $gitExe = $gitPath+"\bin\git.exe"
        Write-Host $gitExe
        $gitFound = Test-Path $gitExe -PathType Leaf
    }   
}catch{
    "Not found!"
}

# Delete archive stuff
Write-Host "Removing archives..."
if (Test-Path .\CarlexheimPlus) {
    Remove-Item .\CarlexheimPlus -Recurse -Force
}
if (Test-Path .\main.zip) {
    Remove-Item .\main.zip
}
if (Test-Path .\CarlexheimPlus-main) {
    Remove-Item .\CarlexheimPlus-main -Recurse
}
Write-Host "Done!"
Write-Host ""

# Delete existing files
Write-Host "Removing existing..."
if (Test-Path .\BepInEx) { Remove-Item .\BepInEx -Recurse }
if (Test-Path .\doorstop_libs) { Remove-Item .\doorstop_libs -Recurse }
if (Test-Path .\unstripped_corlib) { Remove-Item .\unstripped_corlib -Recurse }
if (Test-Path .\doorstop_config.ini) { Remove-Item .\doorstop_config.ini }
if (Test-Path .\winhttp.dll) { Remove-Item .\winhttp.dll }
Write-Host "Done!"
Write-Host ""

if($gitFound){
    Write-Host "USING GIT:"
    Write-Host ""
    Write-Host "Cloning..."
    git clone https://github.com/bo12s/CarlexheimPlus.git --quiet
    Write-Host "Done!"
    Write-Host ""
    Write-Host "Copying..."
    Copy-Item -Path .\CarlexheimPlus\* -Destination .\ -Exclude *.ps1 -Recurse
    Write-Host "Done!"
    Write-Host ""
}else{
    Write-Host "WEB REQUEST:"    
    Write-Host ""
    Write-Host "Downloading..."
    $complete = false

    while(not $complete){
       try{
            Start-BitsTransfer -Source "https://github.com/bo12s/CarlexheimPlus/archive/main.zip" -Destination .\main.zip
            $complete = true
            Write-Host "Done!"
    
        }catch{
            "Transfer failed"
        }
    }
        
    Write-Host ""
    
    if(Test-Path .\main.zip -PathType Leaf){
    Write-Host "Extracting..."
        Expand-Archive -LiteralPath .\main.zip -DestinationPath .\    
        Write-Host "Done!"
    } else{
       Write-Host "Missing zip-file, can't extract!" 
    }

    Write-Host ""
    
    if(Test-Path .\CarlexheimPlus-main){
        Write-Host "Copying..."
        Copy-Item -Path .\CarlexheimPlus-main\* -Destination .\ -Exclude *.ps1 -Recurse   
        Write-Host "Done!"
    } else{
       Write-Host "Missing folder, can't copy!" 
    }
    
    Write-Host ""
}

pause