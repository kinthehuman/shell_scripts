#!/bin/sh

if [ $# -lt 2 ]
then
	echo "usage: copy.sh [dir] [file1] [file2] ... " 1>&2
	exit 1
fi

if [ -d $1 ]
then
	destino=$1
	shift
else
	echo "$1 is not a directoy" 1>&2
	exit 1
fi

for file in $@
do
	if [ -d $file ]
	then
		echo "$file is a directory" 1>&2
		exit 1
	fi
	
	if [ -e $file ]
	then
		cp $file $destino
	else
		echo "$file does not exist" 1>&2
		exit 1
	fi
done
