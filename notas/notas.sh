#!/usr/bin/sh

if [ $# -lt 1 ]; then
	echo "PARAMETROS INSUFICIENTES" 1>&2
fi

if [ -e NOTAS ]; then
	echo "error: NOTAS already exists" 1>&2
	exit 1
fi

badgrade(){
	echo "NOTA NO VALIDA"
	exit 1
}

cat $@| awk '($2<0.0 || $2>10.0)|| ($2 !~ /\./ ) {exit (1);}' || badgrade

names=$(cat $@|awk '{print $1}' | sort -u)

for i in $names; do
	nota=''
	nfiles=$(grep \^$i'[	 ]' $@ /dev/null|awk -F: '{print $1}'|sort -u|wc -w)
	if ! [ $nfiles = $# ]; then
		nota=NP
	fi
	if ! [ "$nota" = NP ]; then
		nota=$(grep $i $@|awk '{avg+=$2}END{avg/=NR; printf("%2.1f", avg);}')
	fi
	echo "$i	$nota" >> NOTAS
done
