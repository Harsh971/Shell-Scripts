#!/bin/bash

echo "Enter Password Length : "
read LENGTH

sleep 1

echo "How many Passwords You want to Generate : "
read N

for p in $(seq $N);
do
        openssl rand -base64 48 | cut -c1-$LENGTH
done
