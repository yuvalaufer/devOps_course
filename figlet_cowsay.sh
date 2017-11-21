#! /bin/bash
#works only if figlet and cowsay are installed

echo "what is your name?"

read name1

echo "your name using figlet:"
figlet $name1


echo "your name using cowsay:"
cowsay $name1
