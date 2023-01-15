# Get-Content mswindows_01powershell.ps1 | PowerShell.exe -noprofile -

# !!! Run the command from the first line manually !!!

# By default script execution is disabled, thus we need to enable it
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned

# Using PowerShell directly navigate to the App Installer app in the store and update it
Start-Process -FilePath ms-windows-store://pdp/?ProductId=9NBLGGH4NNS1
