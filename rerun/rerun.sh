#!/usr/bin/sh

usage1(){
echo "usage: este programa requiere al menos 1 parametro" 1>&2
exit 1
}

usage2(){
echo "usage: $1 no cumple los requisitos de formato, todos los parametros deben acabar en _comando" 1>&2
exit 1
}

comprobar_ejecucion(){
ps -ef|grep "$programa"|grep -v "grep"|grep -v "$0" > /dev/null 2>&1
echo $?
}

already_executing(){
echo "$1 ya se esta ejecutando" 1>&2
exit 1
}

fail(){
ubicacion=`pwd`
touch $ubicacion/$1.fail
echo "$1 fail" 1>&2
exit 1
}

#INICIO DEL PROGRAMA
#comprobacion de error de numero de parametros
if [ $# -lt 1 ]
then
usage1
fi

#ciclo inicial de revision de errores
for programa in $@
do

#comprobacion de error de formato de los parametros
echo $programa|grep '\_comando$' > /dev/null 2>&1
	if [ $? -eq 1 ]
	then
	usage2 $programa
	fi

#comprueba que ningun programa se estaba ejecutando
ejecutando=`comprobar_ejecucion $programa`

	if [ $ejecutando -eq 0 ]
	then
	already_executing $programa
	fi
done

#ciclos sucesivos de polling
while true
do
	for programa in $@
	do

	#revisa que programas debe reejecutar/ejecutar, durante el primer ciclo todos, y en ciclos sucesivos solo aquellos que hayan muerto
	ejecutando=`comprobar_ejecucion $programa`
		if [ $ejecutando -eq 1 ]
		then

		#comprueba si la ejecucion del programa es posible, y si no es posible, sale con error fail
			if [ -x $programa ]
			then
			$programa
			else
			fail $programa
			fi
		fi
	done
sleep 1
done

#este script asume que los programas que se usan como parametros se encuentran en el mismo directorio que el propio script
