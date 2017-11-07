# enabling git compilation
if [ -f `brew --prefix`/etc/bash_completion.d/git-completion.bash ]; then
  . `brew --prefix`/etc/bash_completion.d/git-completion.bash
fi

# loading virtualenvwrapper
export WORKON_HOME=~/Envs                                                    
# could be in any location - just a theme                                               
source /Library/Frameworks/Python.framework/Versions/2.7/bin/virtualenvwrapper.sh
