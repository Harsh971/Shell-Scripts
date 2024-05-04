# Creating First Executable File

<img src="https://github.com/Harsh971/Shell-Scripts/blob/main/0%20-%20Concepts/1%20-%20Create%20first%20Executable%20File/image1.png">

- Here we have used the following set of commands into out Text File
```
echo " Hello World "
echo " This is Harsh Thakkar "
pwd
ls
```
As we know in Scripts, each line is considered as an individual Commands to be executed so each of the above statements are Executed together one after the other

- Through the following Command we can see a list of Files along with their allowed Permissions. Currently by default, our File is not allowed the permission to be **Execute**
```
ls -la
```

- To make our File **Execute** we use the following Command
```
chmod +x first.txt
```

- To Execute out File, we use the following Command
```
./first.txt
```
