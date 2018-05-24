rtrav() {
  test -e $2/$1 && printf %s "$2" || { test $2 != / && rtrav $1 `dirname $2`; }
}
die() {
  [ -n "$1" ] && echo >&2 "Error: $1"
  exit 1
}
stop() {
  [ -n "$1" ] && echo >&2 "$1"
  exit 0
}
initrepo() {
  (
    cd "$1"
    echo .gito/ > .gito/gitoignore
    git config --local core.excludesfile .gito/gitoignore
    git config --local user.email "$(whoami)@$(hostname)"
    git config --local user.name "$(whoami)"
  )
}
setrepo() {
  export GIT_WORK_TREE="`rtrav .gito $(cd $1;pwd)`"
  export GIT_DIR="$GIT_WORK_TREE/.gito"
}

SCRIPT_NAME="$(basename $0)"
SCRIPT_DIR="$(cd `dirname $0`;pwd)"

export PATH="$PATH:$SCRIPT_DIR"
export GIT_CONFIG_NOSYSTEM=1
unset XDG_CONFIG_HOME
unset HOME
