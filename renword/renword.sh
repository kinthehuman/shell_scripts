#!/usr/bin/sh

if ! [ $# -eq 1 ] 
then
	echo "ERROR(usage): Este pograma requiere 1 parametro" 0>&1
	exit 1
fi

for doc in *
do

file --mime-type $doc | grep -q ^$doc': text'

	if [ $? -eq 0 ]
	then
	cat $doc | grep -q ^$1
		if [ $? -eq 0 ]
		then
		mv $doc $doc.$1
		fi
	fi
	
file --mime-type $doc | grep -q ^$doc': image'
	if [ $? -eq 0 ]
	then
	mv $doc foto_$doc
	fi
	
done

exit 0
