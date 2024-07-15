#!/bin/bash

for arg in "$@"; do
    if [ -d "$arg" ]; then
        # Este director
        owner=$(ls -ld "$arg" | awk '{print $3}')
        echo "$arg este un director, utilizatorul proprietar este: $owner"
    elif [ -f "$arg" ]; then
        # Este fișier
        group=$(ls -ld "$arg" | awk '{print $4}')
        echo "$arg este un fișier, grupul proprietar este: $group"
    elif grep -q "^$arg:" /etc/passwd; then
        # Este utilizator
        home_dir=$(grep "^$arg:" /etc/passwd | awk -F: '{print $6}')
        echo "$arg este un utilizator, directorul home este: $home_dir"
    elif grep -q "^$arg:" /etc/group; then
        # Este grup
        members=$(grep "^$arg:" /etc/group | awk -F: '{print $4}')
        if [ "$members" != "" ]; then
            user_count=$(echo "$members" | awk -F, '{print NF}')
        else
            user_count=0
        fi
        echo "$arg este un grup, numărul de utilizatori este: $user_count"
    else
        # Altceva
        echo "Eroare: $arg nu este un director, fișier, utilizator sau grup valid"
    fi
done

