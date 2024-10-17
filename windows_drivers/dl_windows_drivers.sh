#!/bin/bash

BASE_URL="https://steamdeck-packages.steamos.cloud/misc/windows/drivers"

wget -O "Sdcard.zip" \
  "${BASE_URL}/BayHub_SD_STOR_installV3.4.01.89_W10W11_logoed_20220228.zip"

if [[ "$1" == "oled" ]]; then
  # 15. August 2024
  wget -O "GPU.zip" \
    "${BASE_URL}/GFX_Driver_48.0.8.40630.zip"
  wget -O "WLAN.zip" \
    "${BASE_URL}/FC66E-WIN_WiFi_driver.zip"
  wget -O "Blue.zip" \
    "${BASE_URL}/FC66E-B_WIN_Bluetooth_driver.zip"
  wget -O "Audio1.zip" \
    "${BASE_URL}/Audio1_cs35l41-V1.2.1.0.zip"
  wget -O "Audio2.zip" \
    "${BASE_URL}/Audio2_NAU88L21_x64_1.0.9.1_WHQL.zip"
  wget -O "Audio3.zip" \
    "${BASE_URL}/amdampdriver.zip"
else
  # Somewhere in 2022
  # "${BASE_URL}/Aerith%20Windows%20Driver_2209130944.zip"
  # 17. November 2023
  wget -O "GPU.zip" \
    "${BASE_URL}/Aerith_Sephiroth_Windows_Driver_2309131113.zip"
  wget -O "WLAN.zip" \
    "${BASE_URL}/RTLWlanE_WindowsDriver_2024.0.10.137_Drv_3.00.0039_Win11.L.zip"
  wget -O "Blue.zip" \
    "${BASE_URL}/RTBlueR_FilterDriver_1041.3005_1201.2021_new_L.zip"
  wget -O "Audio1.zip" \
    "${BASE_URL}/cs35l41-V1.2.1.0.zip"
  wget -O "Audio2.zip" \
    "${BASE_URL}/NAU88L21_x64_1.0.6.0_WHQL%20-%20DUA_BIQ_WHQL.zip"
fi

# Obsolete. Prefer method described below.
#find . -type f -name "*.zip" -exec 7z x "{}" \;

# Extract the drivers into easily predictable folder names.
for file in {GPU,WLAN,Blue,Sdcard}".zip"; do

  mkdir -pv "${file%%.zip}/"

  7z x "${file}" -o"${file%%.zip}"

  case "$file" in
    "GPU.zip")
      mv "${file%%.zip}/"*/*/* "${file%%.zip}/"
      rmdir "${file%%.zip}/"*/* 2> /dev/null
      ;;
    *)
      mv "${file%%.zip}/"*/* "${file%%.zip}"
      ;;
  esac

  rmdir "${file%%.zip}/"* 2> /dev/null
done

cp -vL "sd_card_setup.iss" "Sdcard/setup.iss"

# We are going the use a routine for the audio drivers where is is sufficient
# to up them all in one folder.
mkdir -pv "Audio"
for file in "Audio"{1,2,3}".zip"; do
  7z x "${file}" -o"Audio"
done

swicd_ver="v0.3.3"
#wget -O "SWICD_Setup_${swicd_ver}.exe" \
wget \
  "https://github.com/mKenfenheuer/steam-deck-windows-usermode-driver/releases/download/${swicd_ver}/SWICD_Setup.exe"
