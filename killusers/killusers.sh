#!/usr/bin/sh

if [ $1 = "-d" ]	#revisa el parametro opcional -d
then

shift

for j in $@  	#recorre los parametros de directorio y comprueba que existen
do
	if [ ! -d $j ]
	then
	echo "error: dir $j not found" 0>&1
	exit 1
	fi
done

for j in $@	#busca los procesos e imprime el comando que los mato
do
	for process in `ps aux|grep $j|grep -v "$0"|awk '{print $2}'`
	do
	echo "kill -15 $process"
	done
done

else

for j in $@  	#recorre los parametros de documento y comprueba que existen
do
	if [ ! -d $j ]
	then
	echo "error: dir $j not found" 0>&1
	exit 1
	fi
done

for j in $@
do
	for process in `ps aux|grep $j|grep -v "$0"|awk '{print $2}'`
	do
	kill -15 $process
	done
done
fi
