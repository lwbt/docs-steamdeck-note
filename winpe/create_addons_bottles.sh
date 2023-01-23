#!/bin/bash

# DON'T FORGET THAT FLATPAK CANNOT ACCESS ALL FILES!

# https://superuser.com/a/307679/252532 (msiexec on Windows)
# https://askubuntu.com/a/671280/40581 (msiexec on Wine)
# https://docs.usebottles.com/advanced/use-bottles-as-wine-command
# https://docs.usebottles.com/advanced/cli

flatpak --user install com.usebottles.bottles

# NOTE: You need to run the GUI first, otherwise Bottles will complain about
# missing components.
flatpak --user run --command=bottles-cli com.usebottles.bottles new \
  --bottle-name winpe --environment application

# This should work in theory but does not.
#flatpak --user run --command=bottles-cli com.usebottles.bottles shell \
#  -b winpe -i "msiexec /a Z:${PWD//\//\\\\}\\cache\\Firefox_en-US.msi /qb TARGETDIR=Z:${PWD//\//\\\\}\\cache\\Firefox_en-US"

# Looks like the msiexec implmentation can only install, not extract. We could
# use lessmsi, but installing a third part package in an environment where we
# have no restrictions is overcomplicating things.
flatpak --user run --command=bottles-cli com.usebottles.bottles shell \
  --bottle-name winpe -i "msiexec /i Z:${PWD}/cache/Firefox_en-US.msi /qb"
flatpak --user run --command=bottles-cli com.usebottles.bottles shell \
  --bottle-name winpe -i "msiexec /i Z:${PWD}/cache/Meld-mingw.msi /qb"

# Copy files to cache.
BOTTLES_PATH="$HOME/.var/app/com.usebottles.bottles/data/bottles/bottles"
cp -a "$BOTTLES_PATH/winpe/drive_c/Program Files/Mozilla Firefox" "${PWD}/cache/"
cp -a "$BOTTLES_PATH/winpe/drive_c/Program Files/Meld" "${PWD}/cache/"
