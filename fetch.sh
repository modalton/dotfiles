#! /bin/bash

#Grab all dotfiles

for i in ".emacs" ".bashrc" ".tern-config" ".i3/config" ".i3blocks.conf" ".cowsay" ".Xresources"
do
    #copied from top level home directory
    cp ~/${i} ./
    git add ${i}
done


git add fetch.sh





if [ $1 ];then
    git commit -m "$1"
else
    git commit -m "`date`"
fi

git push origin master
