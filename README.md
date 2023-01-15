# What is this?

This a repository, but actually just a bunch of notes in markdown format. Even
though it is a GIT repository you should not depend on it in its current form. I
may turn it into a Wiki, something like [Root Pages][1], [Obsidian][2], a
monorepo or something different.

You should start reading [FAQ.md](./FAQ.md)


## Status: Windows

- Should be cleaned up a bit
- Windows installation is fine so far for my needs
  - `windows_drivers` contains a script to download the last known to work
    drivers
  - `windows_installation` contains scripts to be run right after the initial
    boot to set up things
  - `windows_installation\config` contains a few configuration files or assets
    for the initial setup, everything beyond that should be handled in dotfiles
- Mostly used to run games from Epic Games Store! Sorry if you expected the
  perfect setup.
  - [Restore
    Games](windows.md#can-the-epic-games-launcher-detect-previously-installed-games)
    should allow for quick recovery when an isntallation has issues wihtout
    downloading a lot of content again.

Going forward this will be my only Windows installation that I keep around and
I will not use it much. Thank you Valve for making Windows almost obsolete for
an occasional ganer like me, and for improving Wine and developing Proton!


## Status: Linux

- Drive is unencrypted and I will not change the partition layout myself right now
- Dotfiles (private repo) are messy and need to be restructured
- Flatpaks are fine


## Tinkering with SteamOS aka »Don't have a Steam Deck!«

Put [Ventoy][3] on a USB drive or SD card, and put the [HoloISO][4] ISO file
onto it. Boot it. Now you see what Steam OS is like. Requires a general
purpose computer obviously, not a Chromebook or anything with an ARM chip.
For now. Installation to hard drive can be done, but I guess the developer
needs a hand getting UEFI to work.


## More tinkering with Windows

Some people invested more time than me, non-surprisingly, and published more
stuff since Steam Deck became generally available.

I prefer to keep my repo small (no blobs), and I didn't have time to check all
the contant yet, but I might need to do that to keep up to date.

- https://github.com/baldsealion/Steamdeck-Ultimate-Windows11-Guide/wiki
  - https://github.com/ayufan/steam-deck-tools
  - https://github.com/Lulech23/ReplaceOSK
  - https://github.com/builtbybel/ThisIsWin11 a new debloater tool
- https://github.com/ryanrudolfoba/SteamDeckPostInstallScript

## Where is the tabbed explorer in Win11?

It will be available when you install version H22 of Windows 11 and install the
latest updates, it's not included out of the box.

## Some research on Powershell

Some parts got lost somewhere, here are the parts that have survived:

- https://anderssonpeter.github.io/Bedazzling-Windows-Terminal/
- https://github.com/PowerShell/CompletionPredictor
- https://github.com/PowerShell/UnixCompleters
- https://www.develves.net/blogs/asd/articles/using-git-with-powershell-on-windows-10/

```
Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted    
Install-Module -Name PSReadLine -AllowPrerelease -Scope CurrentUser -Force -SkipPublisherCheck
```

[1]: https://rootpages.lukeshort.cloud/
[2]: https://obsidian.md/
[3]: https://github.com/ventoy/Ventoy/
[4]: https://github.com/theVakhovskeIsTaken/holoiso
