rtrav() {
  test -e $2/$1 && printf %s "$2" || { test $2 != / && rtrav $1 `dirname $2`; }
}
info() { echo >&2 INFO: $@; }
warn() { echo >&2 WARNING: $@; }
die() {
  [ -n "$1" ] && echo >&2 "Error: $1"
  exit 1
}
stop() {
  [ -n "$1" ] && echo >&2 "$1"
  exit 0
}
initrepo() {
  (cd "$1"
    echo .gito/ > .gito/gitoignore
    touch .gito/produce
    touch .gito/consume
    git config -f .gito/config core.sharedRepository group
    git config -f .gito/config core.excludesfile .gito/gitoignore
    git config -f .gito/config user.email "$(whoami)@$(hostname)"
    git config -f .gito/config user.name "$(whoami)"
    git config -f .gito/config receive.denyCurrentBranch ignore
    git config -f .gito/config --unset core.worktree
  )
}
setrepo() {
  worktree=`gitopath "$1"` || die "Not a gito repo"
  export GIT_WORK_TREE="$worktree"
  export GIT_DIR="$worktree/.gito"
  export CONSUME_FILE="$worktree/.gito/consume"
}
gitopath () {
  rtrav .gito "$(cd "${1-.}" &>/dev/null || cd "$(dirname "${1-.}")";pwd)"
}

exec 0<&-

SCRIPT_NAME="$(basename $0)"
SCRIPT_DIR="$(cd `dirname $0`;pwd)"

export PATH="$PATH:$SCRIPT_DIR"
export GIT_CONFIG_NOSYSTEM=1
unset XDG_CONFIG_HOME
unset HOME
