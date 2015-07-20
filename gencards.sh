#!/bin/sh
rm -f a b
for i in Aim Force Evade Defend
do
  seq --format=",$i,%g,," 1 14 | tee -a a >> b
done
for i in $(cat a)
do
  attr=$(echo $i | cut -f2 -d',')
  val=$(echo $i | cut -f3 -d',')
  insert=$(grep . b | grep -vw $attr | sort -R | head -1)
  iat=$(echo $insert | cut -f2 -d',')
  ival=$(echo $insert | cut -f3 -d',')
  sed -i -e "s/$insert//g" b
  sed -i -e "s/^,$attr,$val,,$/,$attr,$val,$iat,$ival,,/g" a
done

