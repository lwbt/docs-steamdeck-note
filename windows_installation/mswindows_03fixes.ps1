Set-Culture de-DE
Set-TimeZone -Id "W. Europe Standard Time"

# Configure Windows to use UTC
New-ItemProperty -LiteralPath "HKCU:\System\CurrentControlSet\Control\TimeZoneInformation" `
	-Name "RealTimeIsUniversal" `
	-Value "1" `
	-PropertyType "DWord" `
	-Force -ea SilentlyContinue;

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

# Read data
$AppList = Get-Content 'mswindows_02setup_apps.json' | ConvertFrom-Json

function Winget-Uninstall-List {

    foreach ($App in $AppList) {

        if( ($($App.state) -eq "uninstall") -and `
            ($($App.type) -eq "winget") ) {

            echo "$($App.state) $($App.name)";
            winget uninstall --silent --purge --exact $($App.name);
        }
    }
}

Winget-Uninstall-List
