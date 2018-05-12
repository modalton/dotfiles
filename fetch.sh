#Grab all dotfiles

for i in ".emacs" ".bashrc" ".tern-config"
do
    #copied from top level home directory
    cp ~/${i} ./
done

# Luckily git isnt dumb enough to add itself. add regex exemption for git at some point just to be robust!
git add .\!\(|.\)
git add fetch.sh





if [ $1 ];then
    git commit -m "$1"
else
    git commit -m "`date`"
fi

git push origin master
