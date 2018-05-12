#Grab cop dotfiles

for i in ".emacs" ".bashrc" ".tern-config"
do
    #copied from top level home directory
    cp ~/${i} ./
done

# pipe all dot files into git add. Luckily git isnt dumb enough to add itself.
# add regex exemption for git at some point just to be robust
ls -d .!(|.) || git add
