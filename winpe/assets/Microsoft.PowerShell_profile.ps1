# Access from CLI via nvim $PROFILE
Set-Alias -Name 7z -Value "Y:\Programs\7-Zip\7z.exe"
Set-Alias -Name keepassxc-cli -Value "$env:ProgramFiles\KeePassXC\keepassxc-cli.exe"
Set-Alias -Name ll -Value ls
Set-Alias -Name nvim -Value "$env:ProgramFiles\Neovim\bin\nvim.exe"
Set-Alias -Name vim -Value nvim
Set-Alias -Name mpv -Value "$env:ProgramFiles\mpv\mpv.exe"
Set-PSReadlineKeyHandler -Key ctrl+d -Function DeleteCharOrExit

function pgrep {
    param(
        [string]$search,
        [string]$inc
    )

    Get-ChildItem -recurse -include $inc |
    Select-String -CaseSensitive $search
}

# Switch from installation directory to home directory.
cd $HOME
