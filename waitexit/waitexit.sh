#!/usr/bin/sh

numero_de_procesos=`expr $# - 1`

comando=$1
shift

for n in `seq 20`
do
	procesos_activos=0
	for PID in $@
	do
	ps | grep $PID | grep -v grep
	resultado=$?
	if [ $resultado -eq 1 ]
	then
	echo "$PID existe"
	procesos_activos=`expr $procesos_activos + 1`
	fi
	done #esto es el polling
echo $procesos_activos
echo $numero_de_procesos
if [ $procesos_activos -eq $numero_de_procesos ]
then
$comando
exit 0
fi
sleep 1
done

for PID in $@
do
kill -s KILL $PID	
done

