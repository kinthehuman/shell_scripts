#!/usr/bin/sh

if [ ! $# -eq 2 ]
then

	echo "usage: ./waste [-c N]" 1>&2
	exit 2
	
fi

N=$( expr $1 + 1 )

ps -A -o pcpu,user | sort -r | head -$N | tail -$1 | cut -d ' ' -f3
