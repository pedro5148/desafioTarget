#!/usr/bin/env bash
# -------------------------------VARIAVEIS----------------------------------------- #
RED="\033[1;31m"
VERDE="\033[1;32m"
BLUE='\033[34;1m'
FIMCOR="\033[0m"
arq=[]
# ----------------------------------------------------------------------------- #

# -------------------------------TESTS----------------------------------------- #
# Jq instalado?
[ ! -e "$(which jq)" ] && {
    eval sudo apt update -qq &> /dev/null \
    && sudo apt install jq -y &> /dev/null
}

#arquivo encontrador?
dados=$(find ~ -iname dados.json)
[ -z $dados ] && echo "Arquvo .json nao encontrado" exit 1

# ----------------------------------------------------------------------------- #

# -------------------------------FUNCTIONS----------------------------------------- #
extratDados () {
for i in {1..30}; do 
    arq[$i-1]=$(jq ".[$i-1]" $dados | grep -E "dia|valor" | tr -d "\"," | tail -n1 | cut -d: -f2 | sed 's/ //')
done
}

maiorEMenor () {

menor=${arq[0]}
maior=${arq[0]}
diaM=0
diam=0
i=0

for i in {1..30}; do
    if [[ $(bc -l <<< "${arq[$i-1]} > $maior") -eq 1 ]]; then
        maior=${arq[i-1]}
        [ $(bc -l <<< "$maior == ${arq[$i-1]}") ] && diaM=$i
    fi
done
echo "########## Maior valor ###########"
echo -e "O maior valor é ${VERDE}${maior}${FIMCOR} e ocorreu no dia $diaM"
echo ""

i=0
for i in {1..30}; do
    if [[ $(bc -l <<< "${arq[$i-1]} > 0 && ${arq[$i-1]} < $menor") -eq 1 ]]; then
        menor=${arq[i-1]}
        [ $(bc -l <<< "$menor == ${arq[$i-1]}") ] && diam=$i
    fi
done
echo "########## Menor valor ###########"
echo -e "O menor valor é ${RED}${menor}${FIMCOR} e ocorreu no dia $diam"
echo ""
}

media () {

i=0
acumulado=0
media=0
cont=0
for i in {1..30}; do
    if [[ $(bc -l <<< "${arq[$i-1]} > 0 ") -eq 1 ]]; then
        acumulado=$acumulado+${arq[$i-1]}
        let cont++
    fi
done
acumulado=$(bc -l <<< "$acumulado")
media=$(bc -l <<< "scale=3;$acumulado/$cont")
}

fatMaiorqueMedia () {
i=0
for i in {1..30}; do
    if [[ $(bc -l <<< "$media > ${arq[$i-1]}") -eq 0 ]]; then
    #echo "${arq[$i-1]}"
        let fat++
    fi
done
echo "########## Faturamento ###########"
echo -e "Houve faturamento em ${VERDE}${cont}${FIMCOR} dias.
Porem somente em ${RED}${fat}${FIMCOR} dias o valor foi maior que a media de ${BLUE}${media}${FIMCOR}"
}

removeJq () {
    sudo apt purge jq libjq1 libonig5 -y &> /dev/null 
}
# ----------------------------------------------------------------------------- #

main () {
    extratDados
    maiorEMenor
    media
    fatMaiorqueMedia
    removeJq
}

# -------------------------------EXECUTION----------------------------------------- #
main
# ----------------------------------------------------------------------------- #