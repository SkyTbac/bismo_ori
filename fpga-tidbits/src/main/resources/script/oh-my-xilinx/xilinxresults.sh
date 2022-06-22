#!/bin/zsh
# $1 is the log file generated by the compilation process

echo ${2:=0} > /dev/null

area=`cat results_$1/$1\_usage.xml | grep -A 1 "AGG_SLICE" | sed 's/.*value="\(.*\)".*/\1/' | tail -n 1`
luts=`cat results_$1/$1\_usage.xml | grep -A 1 "NUM_BSUSED" | sed 's/.*value="\(.*\)".*/\1/' | tail -n 1`
dsp=`cat results_$1/$1\_usage.xml | grep -A 1 "DSP" | sed 's/.*value="\(.*\)".*/\1/' | tail -n 1`
bram=`cat results_$1/$1\_usage.xml | grep -A 1 "RAMB" | sed 's/.*value="\(.*\)".*/\1/' | tail -n 1`
#I think this is for HLS/Vivado clock period
#clk=`cat results_$1/$1.twr | grep "CP achieved:" | sed "s/CP achieved:\ *//g"`
#I think this is for ISE clock period
clk=`cat results_$1/$1.twr | grep "Minimum period:" | sed "s/.*:\(.*\){.*/\1/"`

echo ${area:=0} ${luts:=0} ${dsp:=0} ${bram:=0} ${clk:=0} > /dev/null

if [[ $2 -eq 0 ]]; then
	printf "bench,slices,luts,dsp,bram,clk\n" $1 $area $luts $dsp $bram $clk
	printf "%s,%d,%d,%d,%d,%s\n" $1 $area $luts $dsp $bram $clk
else
	echo \'$area\', \'$dsp\', \'$bram\', \'$clk\'
fi