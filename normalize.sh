#!/bin/bash
#
# $1 = filename.bib
# $2 = month
# $3 = year
# $4 = altvolume
# $5 = altnumber

sed -i 's/@[aA]rticle[[:space:]]*{[[:space:]]*/@article {/' $1
sed -i 's/^[[:space:]]*author[[:space:]]*=/  author        =/' $1
sed -i 's/^[[:space:]]*title[[:space:]]*=/  title         =/' $1
sed -i '/^[[:space:]]*journal/s/^.*$/  journal       = dtk,/' $1
sed -i "/^[[:space:]]*year/s/^.*$/  year          = \{$3\},/" $1
if [ "$3" -lt "1996" ]
then
  sed -i "/^[[:space:]]*volume/s/^.*$/  volume        = \{$5($3)\},/" $1
else
  sed -i "/^[[:space:]]*volume/s/^.*$/  volume        = \{$5\/$3\},/" $1
fi
sed -i "/^[[:space:]]*altvolume/s/^.*$/  altvolume     = {$4},/" $1
sed -i "/^[[:space:]]*altnumber/s/^.*$/  altnumber     = {$5},/" $1
sed -i "/^[[:space:]]*month/s/^.*$/  month         = {$2},/" $1
sed -i "s/^[[:space:]]*pages[[:space:]]*=/  pages         =/" $1
sed -i "s/^[[:space:]]*annote[[:space:]]*=/  annote        =/" $1
sed -i '/^[[:space:]]*keywords/d' $1
sed -i -r 's/\{([A-ZÄÖÜ]+)\}/\1/g' $1
sed -i -r 's/= ([0-9]+),/= \{\1\},/g' $1
sed -i 's/ä/{\\\"a}/g' $1
sed -i 's/ö/{\\\"o}/g' $1
sed -i 's/ü/{\\\"u}/g' $1
sed -i 's/Ä/{\\\"A}/g' $1
sed -i 's/Ö/{\\\"O}/g' $1
sed -i 's/Ü/{\\\"U}/g' $1
sed -i 's/ß/{\\ss}/g' $1
sed -i 's/»/\\enquote{/g' $1
sed -i 's/«/}/g' $1

dos2unix $1
