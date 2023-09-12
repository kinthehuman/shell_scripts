#!/usr/bin/sh

if [ ! $# -eq 2 ]
then

	echo "usage: ./waste [-m N]" 1>&2
	exit 2
	
fi

N=$( expr $1 + 1 )

ps -A -o pmem,user | sort -r | head -$N | tail -$1 | cut -d ' ' -f3
