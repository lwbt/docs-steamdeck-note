function Winget-Uninstall-List {

    foreach ($App in $AppList) {

        if( ($($App.state) -eq "uninstall") -and `
            ($($App.type) -eq "winget") ) {

            echo "$($App.state) $($App.name)";
            winget uninstall --silent --purge --exact $($App.name);
        }
    }
}

# Installed as US, but actually I'm german and prefer metric system and date format
Set-Culture de-DE
Set-TimeZone -Id "W. Europe Standard Time"

# Configure Windows to use UTC
New-ItemProperty -LiteralPath "HKCU:\System\CurrentControlSet\Control\TimeZoneInformation" `
	-Name "RealTimeIsUniversal" `
	-Value "1" `
	-PropertyType "DWord" `
	-Force -ea SilentlyContinue;

# Copy SWICD configuration
Copy-Item "config\swicd_app_config.json" `
          "${env:USERPROFILE}\Documents\SWICD\app_config.json"

# Set icon and label for system drive
# TODO: This is buggy, Rufus icon is stuck occasiaonally
Copy-Item "config\autorun.inf" `
          "${env:SystemDrive}\"
Copy-Item "config\autorun.ico" `
          "${env:SystemDrive}\"

# Profile for old pre-installed PowerShell
New-Item  "${env:USERPROFILE}\Documents\WindowsPowerShell"
Copy-Item "config\Microsoft.PowerShell_profile_steamdeck.ps1" `
          "${env:USERPROFILE}\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"

# Profile for upstream PowerShell
New-Item  "${env:USERPROFILE}\Documents\PowerShell"
Copy-Item "config\Microsoft.PowerShell_profile_steamdeck.ps1" `
	  "${env:USERPROFILE}\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"

# Start menu clean up.
Move-Item "${env:ALLUSERSPROFILE}\Microsoft\Windows\Start Menu\Programs\7-Zip\7-Zip File Manager.lnk" `
          "${env:ALLUSERSPROFILE}\Microsoft\Windows\Start Menu\Programs\" -ea SilentlyContinue;
Remove-Item -Recurse `
          "${env:ALLUSERSPROFILE}\Microsoft\Windows\Start Menu\Programs\7-Zip" -ea SilentlyContinue;
Move-Item "${env:ALLUSERSPROFILE}\Microsoft\Windows\Start Menu\Programs\KeePassXC\KeePassXC.lnk" `
          "${env:ALLUSERSPROFILE}\Microsoft\Windows\Start Menu\Programs\" -ea SilentlyContinue;
Remove-Item -Recurse `
          "${env:ALLUSERSPROFILE}\Microsoft\Windows\Start Menu\Programs\KeePassXC" -ea SilentlyContinue;
Move-Item "${env:ALLUSERSPROFILE}\Microsoft\Windows\Start Menu\Programs\TreeSize Free\TreeSize Free.lnk" `
          "${env:ALLUSERSPROFILE}\Microsoft\Windows\Start Menu\Programs\" -ea SilentlyContinue;
Remove-Item -Recurse `
          "${env:ALLUSERSPROFILE}\Microsoft\Windows\Start Menu\Programs\TreeSize Free" -ea SilentlyContinue;
Move-Item "${env:ALLUSERSPROFILE}\Microsoft\Windows\Start Menu\Programs\VideoLAN\VLC\VLC media player.lnk" `
          "${env:ALLUSERSPROFILE}\Microsoft\Windows\Start Menu\Programs\" -ea SilentlyContinue;
Remove-Item -Recurse `
          "${env:ALLUSERSPROFILE}\Microsoft\Windows\Start Menu\Programs\VideoLAN" -ea SilentlyContinue;

# Read data for second uninstall attempt
$AppList = Get-Content 'mswindows_02setup_apps.json' | ConvertFrom-Json

Winget-Uninstall-List

# Rebuild icon cache
ie4uinit.exe -show
