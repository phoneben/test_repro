#!/bin/bash

# Initialize the count variable
tail -7 synthetic_historical_fc_accuracy.tsv >scratch.txt
cut -d $'\t' -f6 scratch.txt
week_fc=$(cut -d $'\t' -f6 scratch.txt)
echo ${week_fc[@]}
for i in "${week_fc[@]}"
do
   : 
   $ diff="${week_fc[$i]}"
$ if ((diff < 0)); then let diff*=-1; fi
$ echo $diff 
done
count=3
lines_in_file="$(wc -l < synthetic_historical_fc_accuracy.tsv)"
echo $lines_in_file
loop_no=$(("$lines_in_file"-2))
for ((i = 1; i <= $loop_no; i++));
#for i in (0..$(echo wc -l rx_poc.log))
do
yesterday_line_count_number="$count"
today_line_count_number=$(($count-1))

yesterday_line_count=$(sed -n "${yesterday_line_count_number}p" rx_poc.log)
today_line_count=$(sed -n "${today_line_count_number}p" rx_poc.log)

yesterday_fc=$(echo "$yesterday_line_count"  | cut -d $'\t' -f 5)
today_temp=$(echo "$today_line_count"| cut -d $'\t' -f 4)
echo "$yesterday_fc - $today_temp"
accuracy=$(("$yesterday_fc"-"$today_temp"))
if [ -1 -le $accuracy ] && [ $accuracy -le 1 ]
then
   accuracy_range=excellent
elif [ -2 -le $accuracy ] && [ $accuracy -le 2 ]
then
    accuracy_range=good
elif [ -3 -le $accuracy ] && [ $accuracy -le 3 ]
then
    accuracy_range=fair
else
    accuracy_range=poor
fi
echo "Forecast accuracy is $accuracy_range"

#row=$($today_line_count)
year=$(echo "$today_line_count" | cut -d $'\t' -f1)
month=$(echo "$today_line_count" | cut -d $'\t' -f2)
day=$(echo "$today_line_count" | cut -d $'\t' -f3)
echo -e "$year\t$month\t$day\t$today_temp\t$yesterday_fc\t$accuracy\t$accuracy_range" >> historical_fc_accuracy.tsv
 # Increment the count
    ((count++))
    echo $count
done
