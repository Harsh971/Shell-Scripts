# Installing Packages using Shell

## Code File :
```sh
#!/bin/bash

echo "Installation started"

if [ "$(uname)" == "Linux" ];
then
        echo "this is linux box,installing git"
        sudo apt-get install git -y
elif [ "$(uname)" == "Darwin" ];
then
        echo "this is not linux box"
        echo "this is Macos"
        sudo brew install git
else
        echo "not installing"
fi
```
<img src="https://github.com/Harsh971/Shell-Scripts/blob/main/General%20Projects/Installing%20Packages/image1.png">

