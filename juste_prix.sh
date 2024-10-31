#!/bin/bash

function justePrix() {

    answer=$((1 + RANDOM % 100))

    tryCount=0 
    tryMax=10
    tryRemaining=10

    diffLevel="false"

    G='\e[32m' 
    Y='\e[33m'
    R='\e[31m'
    LC='\e[96m'
    B='\e[34m'
    N='\e[0m'

    b=$(tput bold)
    nb=$(tput sgr0)
    u=$(tput smul)


    echo "${b}${u}Bienvenue sur le Juste Prix !${nb}"
    read -p "Quel est votre prénom ? " name
    read -p "$(echo -e Très bien $name ! Commencez par choisir un niveau de difficulté : ${G}facile${N}, ${Y}normal${N} ou ${R}difficile${N} ? ) " -r level

    while [[ $diffLevel != "true" ]] ; do
   
    if [[ $level == "facile" || $level == "Facile" ]] ; then
        tryMax=15
        tryRemaining=15
        answer=$((1 + RANDOM % 50))
        diffLevel="true"
        echo -e "$name vous avez choisi le niveau ${G}facile${N}, le nombre que vous devez trouver se situe entre ${b}${u}1 et 50 inclus${nb}, et vous avez le droit à ${b}${u}15 tentatives${nb}. Bonne chance !"

    elif [[ $level == "normal" || $level == "Moyen" ]] ; then
        tryMax=10
        tryRemaining=10
        answer=$((1 + RANDOM % 100))
        diffLevel="true"
        echo -e "$name vous avez choisi le niveau ${Y}normal${N}, le nombre que vous devez trouver se situe entre ${b}${u}1 et 100 inclus${nb}, et vous avez le droit à ${b}${u}10 tentatives${nb}. Bonne chance !"


    elif [[ $level == "difficile" || $level == "Difficile" ]] ; then
        tryMax=7
        tryRemaining=7
        answer=$((1 + RANDOM % 500))
        diffLevel="true"
        echo -e "$name vous avez choisi le niveau ${R}difficile${N}, le nombre que vous devez trouver se situe entre ${b}${u}1 et 500 inclus${nb}, et vous avez le droit à ${b}${u}7 tentatives${nb}. Bonne chance !"


    else 
        read -p "$(echo -e Je n\'ai pas compris votre réponse... Pouvez-vous répéter un niveau de difficulté ? Écrivez ${G}facile${N}, ${Y}normal${N} ou ${R}difficile${N}. )" -r level

    fi

    done


    while [[ $tryCount != $tryMax ]] ; do

    tryCount=$((tryCount + 1))
    tryRemaining=$((tryRemaining - 1))
    
    read -p "Quel est le ${b}${u}juste prix${nb} ? " guess

        if [[ $guess =~ ^[0-9]+$ ]] ; then
                
            if [[ $guess == $answer ]] ; then 
                echo "${b}${u}Bravo $name !${nb} Vous avez trouvé le juste prix en $tryRemaining tentatives."
                break
            
            elif [[ $guess -gt $answer ]] ; then 
                echo -e "${LB}C'est moins !${N} Le juste prix est ${b}${u}plus petit${nb} que $guess."
                echo "$name, il vous reste ${b}${u}$tryRemaining tentatives${nb}."
            
            else
                echo -e "${B}C'est plus !${N} Le juste prix est ${b}${u}plus grand${nb} que $guess."
                echo "$name, il vous reste ${b}${u}$tryRemaining tentatives${nb}."
            fi

            if [[ $tryCount == $tryMax ]] ; then
                echo "${b}${u}Dommage $name...${nb} Vous n'avez pas trouvé le juste prix."
                echo "Le juste prix était ${b}${u}$answer${nb}."
            fi
            
        else echo -e "Votre réponse doit être un ${b}${u}nombre entier positif${nb}."

        fi

    done

    read -p "Voulez-vous ${b}${u}relancer une partie${nb} ? Répondez par ${b}${u}oui${nb} ou par ${b}${u}non${nb}. " replay

    if [[ $replay == "oui" || $replay == "Oui" ]] ; then 
        echo "Super c'est parti !"
        justePrix
    
    else echo "D'accord, à bientôt $name !"
    
    fi

}

justePrix