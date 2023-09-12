#!/bin/sh

if [ ! $# -eq 1 ]
then
	echo "usage: cuenta.sh [dir]" 1>&2
	exit 1
fi

if [ -d $1 ]
then
	files=`ls -l -a $1 | grep '^-' | wc -l`
	directories=`ls -l -a $1 | grep '^d' | wc -l`
	echo "there are $files files in $1"
	echo "there are $directories directories in $1"
else
	echo "$1 is not a directory" 1>&2
	exit 1
fi
