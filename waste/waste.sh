#!/usr/bin/sh

if [ ! $# -eq 2 ]
then

	echo "usage: ./waste [-m N|-c N]" 1>&2
	exit 2
	
fi

N=$( expr $2 + 1 )

if [ $1 = "-m" ]
then

	ps -A -o pmem,user | sort -r | head -$N | tail -$2 | cut -d ' ' -f3
	
else if [ $1 = "-c" ]
then	

	ps -A -o pcpu,user | sort -r | head -$N | tail -$2 | cut -d ' ' -f3

fi
fi

