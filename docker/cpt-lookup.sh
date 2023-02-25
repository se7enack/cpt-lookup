#!/bin/sh
url="https://www.childrenshospital.org/sites/default/files/2022-05/04-2774441_Boston%20Childrens%20Hospital_Standard%20Charges_JSON.json"
file=latest.json

if [ -f "$file" ]; then
        cat ${file} | jq empty
    if ! [ $? == 0 ]; then
        echo "You have the json file but it appears corrupt, downloading a fresh copy..."
        wget ${url} -O ${file}
    fi
else
    echo "You don't have the json file locally, downloading..."
    wget ${url} -O ${file}
fi

if test -z "$cpt"
then
    echo;echo -n "Which CPT code would you like to lookup?: ";read -n5 cpt
fi

lookup(){
    echo;cat latest.json | jq -r ".[] | select( .\"CPT CODE\" == \"$cpt\" )" > /tmp/${cpt}.json
    if ! [ -s /tmp/${cpt}.json ]; then
        echo "CPT ${cpt} does not exist in this file" > /tmp/${cpt}.json
    fi
}

lookup

while true; do
    read -p "Do you wish to search for another?" yn
    case $yn in
        [Yy]* ) echo;echo -n "Which CPT code would you like to lookup?: ";read -n5 cpt;lookup;;
        [Nn]* ) echo;echo "Have a great day!";echo;exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
