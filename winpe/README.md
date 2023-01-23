# Windows PE

Okay this is not really related to Steam Deck or Steam OS, but to create the
Windows 2 Go installation I need Rufus, which does not run on Wine and not on a
minimal Windows PE. So I modded all I could out of the popular Hiren's Boot CD
PE to get the file size down and to improve user experience to be more in line
with Linux.¹

- [doc_pemcd.ini.md](./doc_pemcd.ini.md) is some documentation about `pecmd.ini`
- `run.sh` will create a stripped down version of Hiren's Boot CD PE.
- With Ventoy an `HBCD_addons.7z` can be added with a few updated applications
  and settings. The file is meant to be injected by Ventoy and is the way I
  intend to use this project. At the moment the file size if cut in half. Look
  at the Ventoy project page for more information on how to use Ventoy. A
  sample configuration is included here.
- Wallpaper not included, it is the dar variant of the Windows 11 default
  wallpaper, becuase that just works well with the theme and doesn't look so
  dated.

---

1. Yep I replaced Notepad++ with Neovim.
