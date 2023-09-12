#!/bin/sh

if  [ ! $# -eq 1 ]
then
	echo "usage: latest [file]" 1>&2
	exit 1
fi

if [ ! -r $1 ]
then
	echo "$1 can't be read" 1>&2
	exit 1
fi

for line in `cat $1`
do
	if [ ! -d $line ]
	then
		echo "$line is not a directory" 1>&2
	else
		
		echo "5 latest files from $line:"
		
		echo "`ls -l -t -R $line | grep ^- | head -n 5 | awk '{ print $6, $7, $8, $9 }'`"
		
	fi
	echo
done
