# SteamOS configuration and usage

## Running SteamOS on other devices = HoloISO

A common fallacy is that one needs a Steam Deck device to run SteamOS. Many will
give you misleading advice and this excuse, which is not true. Wikipedia notes
that SteamOS version 1 and 2 were based on Debian. A Debian based SteamOS 3 was
apparently in the works but never published, an Arch Linux based version was
published instead. You could download the older versions of SteamOS inteded for
Steam machines directly from Valve, but the documents seem to be outdated and
stil refer to APT repositories and Debian or Ubuntu.

You can find up to date [Recovery Instructions][1], which some community members
converted into standard ISOs and offering them as [HoloISO][2]. I hope I got
that right. I need to look into how they do this when I have time.

Specualation on my side: They finally wanted to deliver a product with recent
components and have control over the source without getting to involved with the
technical boards of the major 3 Linuxi vendor ecosystems in the corporate market
(Red Hat, Suse, Ubuntu/Debian). They probably hired new talent with Arch Linux
experience.  Steam had been ported to Flatpak already and Google was quite
successful with their Gentoo based ChromeOS platform 2.  Enough with gossip
which I have no sufficient proof for.

So there is a way, but people will find excuses too.


## Basics, guides and resources

- [Steam Deck Desktop FAQ][3]

- Desktop Mode: long press the power button and select **Switch to Desktop**
- Leave Desktop Mode: use the logout desktop icon on the desktop or Application
  Launcher menu or press the power button
- Bring up the on-screen keyboard: press the `Steam` button and the `X` button

- https://github.com/mikeroyal/Steam-Deck-Guide#Other-Linux-Operating-Systems-for-the-Steam-Deck
  
  A big list of many things I don't just want to duplicate here.

- https://gitlab.com/popsulfr/steam-deck-tricks

  A more Linux focused list of tricks you should know about.

- https://boilingsteam.com/getting-started-with-the-steam-deck-desktop/

  A review I can recommend to read.

- https://www.steamgriddb.com/

  Artwork database for customization if artwork is missing or not up to your
  taste.


## Heroic Game Launcher

In desktop mode open the Software Center (KDE Discover) and search for Heroic,
then install it. It is a Launcher which gives you access to the Epic Games store
and GOG store. You can get free games which you normally have to pay for in the
Epic Games store. Most of the games run on Linux, but it depends on the
publisher. Fortnite can be installed, but does not run, it requires to have
anticheat programs running which don't like or don't expect what SteamOS does
with Wine and Proton.

Adding games from Heroic to Steam can be done through a shell script named
[HeroicBashLauncher][8]. It can also be done through the add **add a game**
button in the Steam desktop client and selecting the respective desktop shortcut
which you might need to create first from the tools tab of the respective game
in Heroic. Recently an new feature was added to each game page to add it to
Steam.

TODO: You might need to install and configure settings in Flatseal for this app.


## ScummVM

To play older games like the early Moneky Island titles or Indiana Jones and the
Fate of Atlantis you open the Software Center (KDE Discover) in desktop mode and
search for **ScummVM**, then install it. Configure ScummVM as you are used to or
refer to the ScummVM manual to setup your games.

On your desktop from the context menu select Create New -> Link to Application
and enter the following:

```
/usr/bin/flatpak run --branch=stable --arch=x86_64 --command=scummvm_wrapper org.scummvm.ScummVM atlantis
```

`atlantis` is the reference to the game in ScummVM you want to start. You can
get a list of available games with `scummvm --list-targets`. Finally add the
game to Steam as you did with games from Heroic. Source: [reddit][4]

TODO: You might need to install and configure settings in Flatseal for this app.


## Installation and use Proton GE

[Proton GE][6] is a customized build of Proton.

Open the Software Center (KDE Discover) in desktop mode and search for
**ProtonUp-Qt**, then install it. Run the program in desktop mode to let it
install the latest Proton GE version. You could add the program as a game in
steam if you feel the need to access it quickly and don't mind clutter, like I
did for the terminal application. From the Steam UI you will be able to set
Proton GE as the runtime environment once the initial setup and download are
done. Desktop mode Steam settings and Steam UI settings seem to be independent.

Sources:

- [GitHub GloriousEggroll/proton-ge-custom][6]
- [rockpapershotgun.com][7]


## Installation and use Bottles

TBD


## Flatpak overrides and Flatseal

Existing flatpak overrides can be exported from and imported to the following
directory: `$HOME/.local/share/flatpak/overrides/` 

Noteworthy examples in heredoc format for copy and pasting:

```bash
mkdir -p "$HOME/.local/share/flatpak/overrides"

tee "$HOME/.local/share/flatpak/overrides/org.scummvm.ScummVM" << 'EOF'
[Context]
filesystems=~/Games
EOF
```

## Passwordless `sudo` access

Ideally you should not need this. Especially if you don't understand what sudo
is and how you can recover from a faulty sudoers configuration, which is beyond
the scope of this document.

```bash
# Set a temporary sudo password like 123456 for current user deck
passwd
# Configure passwordless sudo access for users in the wheel group
echo "%wheel ALL=(ALL) NOPASSWD:ALL" \
| sudo tee /etc/sudoers.d/wheel >/dev/null
# Remove the temporary password for the user deck
sudo passwd -d deck
```

Source: [reddit][5]


## Known issues with games

### Anti-Cheat

Integrated in recent releases from Heoric: https://areweanticheatyet.com/

Excerpt:

- Fornite: Denied
- Genshin Impact: Broken
- Halo Infinite: Running with Proton-GE!
- Halo MCC: Planned
- Valorant: Broken


### ProtonDB suggestions for specific games

- Dead Or Alive 5 LR  https://www.protondb.com/app/311730 `PROTON_NO_ESYNC=1 PROTON_NO_FSYNC=1 %command%`
- Dead Or Alive 6 https://www.protondb.com/app/838380 Use Proton GE for working story mode
- Tomb Raider Underworld: https://www.protondb.com/app/8140 `PROTON_USE_WINED3D=1 %command% gamescope -w 1920 -h 1080 -r 60 -n`


### Heroic: Epic Games Store and GOG

Epic Games:

- Shadow of Tomb Raider, apparently does not launch with DX12 mode

GOG:

- Tomb Raider 1+2+3
  - Controller mappings: https://www.thekinsie.com/words/tombraider/
  - Been unable to launch Tomb Raider 3 yet


## Known issues with hardware

### Monitors with USB-C input work but integrated USB hubs and attached devices don't work

That is the YMMV part. I have two Dell U2720Q. One had firmware M2T101 and the
other firmware M2T104. The latter can be upgraded to newer firmware, the other
can apparently not and USB devices are not detected on the device with the
older firmware while the newer has no problems and works just fine.


## Linux settings and dotfiles

I'm used to more friendlier configuration of aliases and command completion from
Debian and Ubuntu. This is typical for other distributions.

TODO: link dotfiles repo here.

While SteamOS should be treated like an appliance investigation which parts
could be handled through Ansible configuration management should be evaluated.

## Battery life extender (aka stop charing at 80%)

> If your device has been left on the charger for long periods of time, it may
> report less than 100% charge. This is normal. We allow the battery to slowly
> discharge after long periods of time under charge to optimize long-term
> battery health.

Source: https://help.steampowered.com/en/faqs/view/69E3-14AF-9764-4C28

So It can be considered "safe" for the battery life to leave it plugged in and
docked, it won't top up the battery like crazy. The 80% thing may be a
marketing gimmick from Apple and other manucaturers.


[1]: https://help.steampowered.com/en/faqs/view/1B71-EDF2-EB6D-2BB3
[2]: https://github.com/theVakhovskeIsTaken/holoiso
[3]: https://help.steampowered.com/en/faqs/view/671A-4453-E8D2-323C
[4]: https://www.reddit.com/r/SteamDeck/comments/po1vg0/add_scummvm_games_to_your_steam_launcher/
[5]: https://www.reddit.com/r/SteamDeck/comments/t8ddl4/run_sudo_commands_without_a_password_on_steam_deck/
[6]: https://github.com/GloriousEggroll/proton-ge-custom
[7]: https://www.rockpapershotgun.com/how-to-install-proton-ge-on-the-steam-deck
[8]: https://github.com/redromnon/HeroicBashLauncher/wiki/Steam-Deck-(Flatpak)-Guide
