Invoke-WebRequest https://github.com/bo12s/CarlexheimPlus/archive/main.zip -OutFile main.zip

Expand-Archive -LiteralPath .\main.zip -DestinationPath .\

Remove-Item .\BepInEx -Recurse
Remove-Item .\doorstop_libs -Recurse
Remove-Item .\unstripped_corlib -Recurse
Remove-Item .\doorstop_config.ini
Remove-Item .\winhttp.dll

Copy-Item -Path .\CarlexheimPlus-main\* -Destination .\ -Exclude *.ps1