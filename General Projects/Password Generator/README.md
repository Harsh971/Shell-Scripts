# Password Generator using Shell

## Code File :
```sh
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

```
<img src="https://github.com/Harsh971/Shell-Scripts/blob/main/General%20Projects/Password%20Generator/image1.png">

## Code Explaination :
This shell script generates a random string of characters using OpenSSL and then truncates it to a certain length specified by the variable **`$PASS_LENGTH`**.

Let's break down the code:

- **`for p in $(seq $N)`** : This initiates a loop that runs once, as seq 1 generates a sequence from 1 to N. So, it essentially loops only N times.
- **`openssl rand -base64 48`** : This command generates a random sequence of bytes using OpenSSL's rand command with the -base64 option, which generates random bytes in Base64 format. The 48 specifies the number of bytes to generate, which is then encoded in Base64.
- **`cut -c1-$PASS_LENGTH`** : This part takes the generated random string and uses the cut command to extract only the characters from the first character to the character at position $PASS_LENGTH. So, it effectively truncates the generated random string to the length specified by the variable $PASS_LENGTH.