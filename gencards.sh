#!/bin/bash
filea=$(mktemp)
fileb=$(mktemp)
copya=$(mktemp)
outfile=outcards.csv
max=14
for i in $(cut -f1 -d',' dynamic.csv | grep . | tail --lines=+2)
do
  seq --format=",$i,%g,," 1 "$max" | tee -a "$filea" >> "$fileb"
done
cp "$filea" "$copya"
while IFS= read -r line
do
  IFS=, read n attr val n n <<< "$line"
  if [ ".$n." == ".." ]
  then
    n=
  fi
  attr=$(echo "$line" | cut -f2 -d',')
  val=$(echo "$line" | cut -f3 -d',')
  insert=$(grep . "$fileb" | grep -vw "$attr" | sort -R | head -1)
  iat=$(echo "$insert" | cut -f2 -d',')
  ival=$(echo "$insert" | cut -f3 -d',')
  sed -i -e "s/$insert//g" "$fileb"
  sed -i -e "s/^,$attr,$val,,$/,$attr,$val,$iat,$ival,,/g" "$filea"
done < "$copya"
cp "$filea" "$outfile"
rm -f "$filea" "$fileb" "$copya"

