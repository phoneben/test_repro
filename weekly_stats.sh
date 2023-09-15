#!/bin/bash
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


echo $(tail -7 synthetic_historical_fc_accuracy.tsv  | cut -f6) > scratch.txt

week_fc=($(echo $(cat scratch.txt)))

# validate result:
for i in {0..6}; do
    echo ${week_fc[$i]}
done

for i in {0..6}; do
  if (( ${week_fc[$i]} < 0 ))
  # if ((diff < 0)); then let diff*=-1; fi
  then
 echo "minus" ${week_fc[$i]}
    week_fc[$i]=$(((-1)*week_fc[$i]))
  fi
  # validate result:
  echo "new" ${week_fc[$i]}
done

minimum=${week_fc[1]}
maximum=${week_fc[1]}
for item in ${week_fc[@]}; do
   if [[ $minimum > $item ]]
   then
     minimum=$item
   fi
   if [[ $maximum < $item ]]
   then
     maximum=$item
   fi
done

echo "minimum ebsolute error = $minimum"
echo "maximum absolute error = $maximum"
