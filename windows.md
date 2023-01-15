# Running Windows on Steam Deck

- Download Rufus
- Download a Windows image of your choice from Microsoft
- Get an empty hard drive and make selections in Rufus to install Windows as
  Windows to Go from the image you downloaded before
- Power down and boot your Steam Deck while holding to Volume Up button, which
  will bring up the boot menut where you can choos to boot from the external
  drive
- Install Windows drivers:
  https://help.steampowered.com/de/faqs/view/6121-ECCD-D643-BAA8


## Personal opinion about Windows 11 and usage policy as a secondary OS

Quite usable, not as annoying as the moving tiles in the Windows 10 and 8 start
menu. I guess that was a fad and many frequent users of Windows 10 were more
annoyed by invasive marketing than I thought there would be. Still more than a
row of shorcuts to I apps I don't want to use, but they are not preinstalled and
can be removed easily. At best one of the existing scripts can be updated, but I
should brush up my PowerShell knowledge first.

Avoid installing too many things. Use the standard zip tool and editor. Install
games that don't run in SteamOS to run them and nothing else. Do Micromanagement
when you have time.


## Usermode controller driver

Install the latest MSI package from here:
https://github.com/mKenfenheuer/steam-deck-windows-usermode-driver/releases


## Configure Windows to use UTC

https://wiki.archlinux.org/title/System_time#UTC_in_Microsoft_Windows


## Remove features and unwanted software

Apparently this is still active and enabled in 2022 despite numerous CVEs.

```pwsh
Disable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol
```

## Can the Epic Games Launcher detect previously installed games?

https://www.epicgames.com/help/en-US/epic-games-store-c5719341124379/launcher-support-c5719357217435/can-the-epic-games-launcher-detect-previously-installed-games-a5720251596059
