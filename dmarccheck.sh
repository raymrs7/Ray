#!/bin/sh



usage()
{
    echo "Pour vérifier le Dmarc d'un domaine ou un ensemble de domaine regroupé dans un fichier"
    echo ""
    echo "$0"
    echo "		-h ou  --help pour afficher ce message"
    echo "		-d ou --domain domain.bj"
    echo "		-f ou --file /chemin/du/fichier"
    echo ""

}

checkd() {

	dig _dmarc.$1 +short TXT
}

printhead(){
        echo
	printf '\e[1;34m%-30s\e[m \e[1;32m%-30s\e[m' "Domain" "Dmarc"
	echo
}

printDmarc(){
	SPF=`checkd $1 | grep "v="`
#	echo "$1\t\t\t\t$SPF"
	printf "%-30s   %-60s\n" "$1" "$SPF"
}

printFileDmarc(){
	while IFS= read -r line
	do
	  printDmarc $line
	done < "$1"
}

if [ "$1" = "" ]
then
	usage
	exit
else
#while [ "$1" != "" ]; do
#    echo "1 est $1 et 2 est $2"
#    exit
printhead
    case $1 in
        -h | --help)
           usage
            exit
            ;;
        -f | --file)
            printFileDmarc $2
            ;;
        -d | --domain)
	    printDmarc $2
	    exit 0
            ;;

        *)
            echo "Option  \"$PARAM\" inconnu"
            usage
            exit 1
            ;;
    esac
    shift
fi
#done
