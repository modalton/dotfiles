#! /bin/bash

#Grab all dotfiles

for i in ".emacs" ".bashrc" ".tern-config"
do
    #copied from top level home directory
    cp ~/${i} ./
done


# this is a bash glob and not a git glob
git add .??*
git add fetch.sh





if [ $1 ];then
    git commit -m "$1"
else
    git commit -m "`date`"
fi

git push origin master
