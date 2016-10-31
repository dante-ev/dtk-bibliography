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
sed -i 's/{\\\"a}/ä/g' $1
sed -i 's/{\\\"o}/ö/g' $1
sed -i 's/{\\\"u}/ü/g' $1
sed -i 's/{\\\"A}/Ä/g' $1
sed -i 's/{\\\"O}/Ö/g' $1
sed -i 's/{\\\"U}/Ü/g' $1
sed -i 's/{\\ss}/ß/g' $1
