#!/usr/bin/sh

if [ $# -lt 1 ]
then

	echo "usage: no arguments" 0>&1
	exit 1
	
fi

for argument in $@
do
	if [ ! -e $argument  ]
	then
		echo "usage: $argument not found" 0>&1
		exit 1
	fi

	if [ ! -r $argument  ]
	then
		echo "usage: $argument can't be read" 0>&1
		exit 1
	fi
	
	echo "$argument:"
	
	for n in 0 1 2
	do
		spaces=$(( 1 + 4*$n))

		name=`cat $argument | grep ^[#] | cut -d ' ' -f$spaces`
		
		if [ $n -eq 0 ]
		then
			name=`echo $name | cut -c 2-`
		fi
		
		values=`cat $argument | grep ^[^#] | cut -d ' ' -f$spaces | sort -n`
		
		suma=0
		lines=0
		
		for value in $values
		do
			lines=`echo "$lines + 1" | bc`
		done
		
		parity=$(( lines % 2 ))
		if [ $parity -eq 1 ]
		then
			half=$((lines/2 + 1))
			counter=0
			
			for value in $values
			do
				suma=`echo "$suma+$value" | bc`
				counter=$((counter + 1))
				
				if [ $counter -eq $half ]
				then
					median=$value
				fi	
			done
		else
			half1=$((lines/2))
			half2=$((lines/2 + 1))
			counter=0
			median=0
			
			for value in $values
			do
				suma=`echo "$suma+$value" | bc`
				counter=$((counter + 1))
				
				if [ $counter -eq $half1  ] || [ $counter -eq $half2  ]
				then
					median=`echo "$median+$value" | bc`
				fi	
			done
			median=`echo "scale=2;$median / 2" | bc`
		fi	
		
		avg=`echo "scale=2;$suma / $lines" | bc`
		
		echo "$name	avg:	$avg	median:   $median"
	
	done
	

done

exit 0
