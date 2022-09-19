parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1="\[\033[01;32m\]\u@\h\[\033[01;33m\] \w\[\033[31m\]\$(parse_git_branch)\[\033[00m\] \n\[\033[01;34m\]\$\[\033[00m\] "
