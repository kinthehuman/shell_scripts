#!/usr/bin/sh

if [ $# -gt 1 ]
then
echo "ESTE PROGRAMA NO ACEPTA MAS DE 1 PARAMETRO" 0>&1
fi

if [ $# -eq 0 ]
#sin exclusion de usuarios
then
#se inicializan variables
ubicacion=`pwd`
top1=0
user1=""
top2=0
user2=""
#se recorre array con los usuarios
	for usuario in `cat /etc/passwd | cut -d ":" -f1`
	do
	#obtenemos numero de procesos
	procesos=`ps -u $usuario | wc -l`
	#si es mayor que el mayor actual, el mayor actual pasa a ser el segundo mayor y se 		reemplaza el mayor actual
		if [ $procesos -gt $top1 ]
		then
		top2=$top1
		user2=$user1
		top1=$procesos
		user1=$usuario
	#si es menor que el mayor actual, pero mayor que el segundo mayor, se reemplaza el segundo 		mayor
	#mayor y segundo mayor se vuelcan en userpairs.txt
		else 
			if [ $procesos -gt $top2 ]
			then
			top2=$procesos
			user2=$usuario
			fi
		fi
	done

#formato de la fecha
day=`date|cut -d' ' -f3`
month=`date|cut -d' ' -f2`
year=`date|cut -d' ' -f6`
hour=`date|cut -d' ' -f4`
fecha=`echo "$day"_"$month"_"$year"_"$hour"`

#se vuelcan los nombres en el documento si existe y es editable y se crea un documento nuevo en caso contrario
	if [ -w $ubicacion/userpairs.txt ]
	then
	echo "$user1 $user2 $fecha" >> $ubicacion/userpairs.txt
	else
	echo "$user1 $user2 $fecha" > $ubicacion/userpairs.txt
	fi

fi

if [ $# -eq 1 ]
#el parametro opcional de fichero de usuarios va con todo el path
#con exclusion de usuarios
then
#se inicializan variables
ubicacion=`pwd`
top1=0
user1=""
top2=0
user2=""
#se recorre array con los usuarios
	for usuario in `cat /etc/passwd | cut -d ":" -f1`
	do
		#se comprueba si coincide con alguno de los usuarios del fichero de entrada
		coincidencia=0
		while IFS= read -r line
		do
		if [ "$line" = "$usuario" ]
		then
		coincidencia=1
		fi
		done < $1
		#si hay coincidencia, se actualizará el valor de la variable $coincidencia, que 		usaremos como condicion
	if [ $coincidencia -eq 0 ]
	then
		#obtenemos numero de procesos
		procesos=`ps -u $usuario | wc -l`
		#si es mayor que el mayor actual, el mayor actual pasa a ser el segundo mayor y se 			reemplaza el mayor actual
		if [ $procesos -gt $top1 ]
		then
		top2=$top1
		user2=$user1
		top1=$procesos
		user1=$usuario
		#si es menor que el mayor actual, pero mayor que el segundo mayor, se reemplaza el 			segundo mayor
		#mayor y segundo mayor se vuelcan en userpairs.txt
		else 
			if [ $procesos -gt $top2 ]
			then
			top2=$procesos
			user2=$usuario
			fi
		fi
	fi
	done

	#formato de la fecha
	day=`date|cut -d' ' -f3`
	month=`date|cut -d' ' -f2`
	year=`date|cut -d' ' -f6`
	hour=`date|cut -d' ' -f4`
	fecha=`echo "$day"_"$month"_"$year"_"$hour"`

	#se vuelcan los nombres en el documento si existe y es editable y se crea un documento 		nuevo en caso contrario
	if [ -w $ubicacion/userpairs.txt ]
	then
	echo "$user1 $user2 $fecha" >> $ubicacion/userpairs.txt
	else
	echo "$user1 $user2 $fecha" > $ubicacion/userpairs.txt
	fi
	
fi




