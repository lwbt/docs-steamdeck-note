# Access vom CLI via nvim $PROFILE
Set-Alias -Name 7z -Value "$env:ProgramFiles\7-Zip\7z.exe"
Set-Alias -Name keepassxc-cli -Value "$env:ProgramFiles\KeePassXC\keepassxc-cli.exe"
Set-Alias -Name ll -Value ls
Set-Alias -Name vim -Value nvim
Set-Alias -Name vlc -Value "$env:ProgramFiles\VideoLAN\VLC\vlc.exe"
Set-PSReadlineKeyHandler -Key ctrl+d -Function DeleteCharOrExit

function pgrep {
    param(
        [string]$search,
        [string]$inc
    )

    Get-ChildItem -recurse -include $inc |
    Select-String -CaseSensitive $search
}
