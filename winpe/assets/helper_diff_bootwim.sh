#!/bin/bash

# A helper script I wrote to compare a handcrafted image with it's original to
# generate a list for programatic reproducibility.
#
# Quality and approach could be improved quire a bit.

FILE_PATH="sources/boot.wim"
UNTOUCHED="$1"
MODIFED="$2"
UNTOUCHED="HBCD_PE_x64"
MODIFED="HBCD_PE_x64_"

7z l "${UNTOUCHED}/${FILE_PATH}" > "1_untouched.txt"
7z l "${MODIFED}/${FILE_PATH}" > "2_modified.txt"

# 999 coulumns is a bit much, there has to be a better way to create the list
# without so much work on the format.
diff \
  --left-column \
  --side-by-side \
  --suppress-common-lines  \
  --width=999 \
  "1_untouched.txt" \
  "2_modified.txt"  \
> "list_diff.txt"

grep -E "<$" "list_diff.txt" 
| cut -c 54- \
| sed -e "{s/ *<$//g; s/\t*//g}" \
| sort > "list_diff_2.txt"

# This final list may have been reviewed and edited by hand to roll back soem
# aggressive changes.
