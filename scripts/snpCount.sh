#!/bin/bash -eux

D=$1 # out dir
M=$2 # source(mutect2...)

if [ ! -s $D/$M.haplogroup.tab ] ; then
  find $D/ -name "*.$M.haplogroup"  | xargs cat | grep -v SampleID | sed 's|"||g' | awk '{print $1,$2}' | sort | perl -ane 'BEGIN {print "Run\thaplogroup\n"} print "$F[0]\t$F[1]\n";' > $D/$M.haplogroup.tab
fi
snpCount1.sh $D $M 03
snpCount1.sh $D $M 05
snpCount1.sh $D $M 10
snpCount1.sh $D $M max

join.pl  $D/$M.haplogroup.tab $D/$M.03.tab | join.pl - $D/$M.05.tab | join.pl - $D/$M.10.tab > $D/$M.tab
rm $D/$M.{03,05,10,max}.tab 
