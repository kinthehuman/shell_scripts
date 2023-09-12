#!/usr/bin/sh
if [ $# -lt 2 ]
then
echo "PARAMETROS INSUFICIENTES" 0>&1
exit 1
fi

count=$1

shift

for j in $@  	#recorre los parametros de documento y comprueba que existen
do
if [ ! -f $j ]
then
echo "no existe: $j" 0>&1
exit 1
fi
done

for i in $@  	#recorre los documentos y va haciendo pings
do

doc=`pwd`"/"$i

while read direccion
do
ping -c $count $direccion| grep -q "0 received"
estado=$? #si ha encontrado un 0 recieved, el ping ha fallado
if [ $estado -eq 0 ]
then 
mv $doc $doc.down
echo "$direccion no responde" 0>&1
else
echo "$direccion si responde"
fi

done < $doc

done

exit 0
