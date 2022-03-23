#!/usr/local/bin/bash

echo $BASH_VERSION
declare -A userdata
for var in "$@"
do
    USERS=$(wget -qO- $var | grep -Eo "/it/Pokemon/Users/[a-zA-Z0-9./?=_-]*" | sed 's/\/it\/Pokemon\/Users\///' | sort -u);
    for USER in $USERS
    do
        if [ ${userdata[$USER]+_} ]; then 
            (( userdata[$USER]++ ))
        else 
            userdata[$USER]=1
        fi
    done
    
done

for k in "${!userdata[@]}"
do
    echo $k '=>' ${userdata["$k"]}
done | sort -rn -k3