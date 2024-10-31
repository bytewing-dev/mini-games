#!/bin/bash

. ./wordle_lib.sh 

answer=$(getRandomWord)

guessCount=0 
guessMax=6

G='\e[32m' 
Y='\e[33m'
R='\e[31m'
N='\e[0m'

b=$(tput bold)
nb=$(tput sgr0)
u=$(tput smul)

echo "${b}${u}Bienvenue sur Wordle.${nb} Le but du jeu est de deviner, en 6 essais maximum, un mot en anglais généré aléatoirement." 
echo "Les lettres de votre mot ${b}${u}changeront de couleur${nb} selon si elles sont correctes (vert), correctes mais mal placées (jaune) ou incorrectes (rouge)."

while [[ $guessCount -ne $guessMax ]]; do 
    
    guessCount=$((guessCount + 1))
    guess=$(getInput)
    color=()
    
    if [[ ${#guess} -eq "5" ]] && [[ $guess =~ ^[[:upper:]] ]] ; then
        
        if [[ $guess == $answer ]] ; then
            echo -e "${G}${guess:0:1}${guess:1:1}${guess:2:1}${guess:3:1}${guess:4:1}${N}"
            echo "${b}${u}Gagné !${nb} Vous avez trouvé le mot caché."
            break
        
        else
            for (( i=0; i<${#guess}; i++ )) ; do
                if [[ ${guess:$i:1} == ${answer:$i:1} ]] ; then
                    color+=('\e[32m')
                elif  [[ "$answer" == *"${guess:$i:1}"* ]] ; then
                    color+=('\e[33m')
                else 
                    color+=('\e[31m')
                fi    
            done
            
            echo -e "${color[0]}${guess:0:1}${N}${color[1]}${guess:1:1}${N}${color[2]}${guess:2:1}${N}${color[3]}${guess:3:1}${N}${color[4]}${guess:4:1}${N}"
        
        fi

        if [[ $guessCount == $guessMax ]] ; then
            echo "${b}${u}Perdu...${nb} Vous n'avez pas trouvé le mot caché."
            echo "La réponse était ${b}${u}$answer${nb}."
        fi
    
    else
        echo "Votre réponse doit être un mot de ${b}${u}5 lettres${nb} et qui commence par une ${b}${u}majuscule${nb}."
        guessCount=$((guessCount - 1))
    fi

done