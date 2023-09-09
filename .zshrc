export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="mytheme"

# Use custom directory for completion dumpfile.
ZSH_COMPDUMP="$ZSH/cache/.zcompdump"

plugins=(
  git
  extract
  zsh-autosuggestions
  zsh-syntax-highlighting
  autojump
  golang
  docker
  docker-compose
  aws
  kubectl
  kops
  gcloud
  rust
  # vi-mode
)

# Avoid exiting terminal when pressing ctrl+D
setopt ignore_eof

fpath=( $ZSH/custom/completion "${fpath[@]}" )

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
export EDITOR=nvim

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Git aliases
alias gta='git add -A'
alias gtc='git commit -m '
alias gts='git status'
alias gtp='git pull `git symbolic-ref --short HEAD`'
alias gtpm='git pull --rebase origin main'
alias gcm='git checkout main'
alias gcmp='git checkout main && git pull --rebase'
alias gc-='git checkout -'
alias glm='git log --author=$(git config user.email)'
alias gdc='git diff --cached'
alias glg='git log --date-order --all --graph --format="%C(green)%h%Creset %C(yellow)%an%Creset %C(blue bold)%ar%Creset %C(red bold)%d%Creset%s"'
alias lg='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'

# Git Scripts

gtr () { git rebase ${1:=main} }

gbc () {
    desc="Usage: remove all local branches except main/master.\nUse -f to remove unmerged.\nUse -m with 'pattern' to remove matching."
	print_usage "$1" "$desc" && return

    merged="--merged"
	case "$1" in
		"-m") [[ "$#" -ne 2 ]] && echo "Missing pattern to match" && return
            del=$(git branch --list $2)
            echo -n "Do you want to delete the following? (y/n)\n$del\n"
            read answer
            [[ "$answer" != "${answer#[Yy]}" ]] && echo "$del" | xargs git branch -D; return ;;
        "-f") merged="" ;;
	esac

    git for-each-ref --format '%(refname:short)' "$merged" HEAD refs/heads/ |\
        grep -v 'main\|master' | xargs git branch -D 2>/dev/null ||\
        echo "No unmerged branches found. Use -f to remove unmerged (ecluding main/master)"
}

gh () {
    [ -n "$1" ] && [ "$1" -gt 0 ] && SKIP=$(($1 - 1)) || SKIP=0
    [ $# -eq 2 ] && FMT=$2 || FMT=H
    echo -n $(git log -1 --skip="$SKIP" --pretty="%$FMT")
}

ghl () {
    desc="Usage: [ghl [<position-from-head>] [<dir>] Log changes for a commit from HEAD"
    print_usage "$1" "$desc" && return

    cmd="git log -p $(gh $1) -1"
    [[ ! -z "$2" ]] && cmd+=" -- $2"
    eval "$cmd"
}

ghc () {
    [[ `uname` == "Darwin" ]] && cmd=pbcopy || cmd='xclip -sel clip'
    gh $1 | $cmd
    echo $(ght $1)
}
ght () {
    SKIP=0; FMT=s
    [ $# -eq 1 ] && SKIP=$1
    [ $# -eq 2 ] && FMT=$2
    gh $SKIP $FMT
}

gblt () {
    cmd="git branch --sort=-committerdate -v | grep -v 'main\|master'"
    [[ "$1" =~ "^[1-9]+$" ]] && lines="$1" | lines=1
    eval "$cmd" | awk -v lines="$lines" 'NR<=lines {print $1,$2,$3}'
}

gdh () {
    desc="Usage: [gdh <commit> [<dir>]] Diffs the given commit against HEAD in the given <dir> or defaults to the current dir"
    print_usage "$1" "$desc" && return

    commit="$1"
    dir="$2"
    [[ -z "$dir" ]] && dir="."
    git diff "$commit" HEAD -- "$dir" ':!*test.go'
}

gln () {
    desc="Usage: [gln <search term> [<depth>]] Looks up the last <number> of commits and prefixed by the index in the search returning only the ones with the search term"
    print_usage "$1" "$desc" && return

    [[ -z "$2" ]] && depth=10 || depth="$2"
	arg="NR<$depth"
	arg+=' {print NR": " $0}'
    git log --oneline | awk "$arg" | grep "$1"
}

##### Other Aliases

## General Utils
alias se='sudoedit'
alias vz='vim $HOME/.zshrc'
alias vim='nvim'
alias oldvim='\vim'
alias lst='ls -t | head -1'

# random hash
alias randh='openssl rand -base64 48'
# generate random passphrase (128 bits of entropy)
alias randp="dd if=/dev/urandom bs=16 count=1 2>/dev/null | base64 | sed 's/=//g'"

# see which localhost are running and listen
alias ckports='netstat -nptl'
alias ckport='lsof -i'

# ubuntu version
alias ubuntuv='lsb_release -a'

# curl
alias curltm='curl -o /dev/null -s -w "----
Conn: %{time_connect}
StartTransf: %{time_starttransfer}
Total time: %{time_total}
----\n"'

# xclip
alias cclip="xclip -sel clip"
alias pclip="xclip -o"

# Limit pushd stacksize to elements from 0 to 5
DIRSTACKSIZE=6
# return list of dirs in stack
alias lsd="dirs -v"
alias cld="dirs -c"
jd() {
	[[ ! -z "$1" ]] && cd ~"$1"
}

# tmux
alias ts='tmux new-session -s'
alias ta='tmux attach -t'

# docker
alias dc='docker-compose'
alias dcc="docker ps -aq -f status=exited | xargs docker rm && docker images -f dangling=true -q | xargs docker rmi"

# kube
alias kc=kubectl

# microk8s
alias mk=microk8s
alias mkc=microk8s.kubectl

# Aws localstack
alias awl='AWS_SECRET_ACCESS_KEY=DUMMY_TEST_KEY AWS_ACCESS_KEY_ID=DUMMY_TEST_ID aws --endpoint-url http://localhost:4566 --region ap-southeast-2'

##### Path

# Go
export PATH="$HOME/Dev/go/bin:/usr/local/go/bin:$PATH"
export GOPATH="$HOME/Dev/go"

# Nvm node
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Need to check this one
export PATH="$HOME/.local/bin:$PATH"

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

##### Scripts

# print_usage prints the given description if the script was run with a help tag
# usage: print_usage "$1" "$desc" && return
print_usage() {
	case "$1" in
		"-h" | "--help")
			[[ ! -z "$2" ]] && echo "$2" || echo "no description provided"
			true;;
		*) false;;
	esac
}

mkcd() {
	desc="Usage: [mkcd 'dirpath'] creates the given dir and any parent dirs, then cd into it."
	print_usage "$1" "$desc" && return

	mkdir -p "$1" && cd "$_"
}

mktouch() {
	desc="Usage: [mktouch 'filepath'] creates the given file and any parent dirs, then cd in its containing dir."
	print_usage "$1" "$desc" && return

	mkcd "$(dirname "$1")" && touch "$(basename "$1")"
}

mkcode() {
	desc="Usage: [mkcode 'filepath'] creates the given file and any parent dirs, cd in its containing
      	dir and open it in the edito given or default to vscode"
	print_usage "$1" "$desc" && return

	[ -n "$2" ] && EDITOR="$2" || EDITOR="code"
	mktouch $1 && "$EDITOR" "$(basename "$1")"
}

mkconfirm() {
	dest="$1"

    echo -n "Directory $dest does not exist. Create? [Yy/Nn] "
    read reply #-p -n 1 -r

    if [[ $reply =~ ^[Yy]$ ]]; then
      mkdir -p "$dest" && echo "New directory created: $dest"
      return # will return true if the above is successful otherwise false
	fi

    echo "Directory creation aborted!"
    false
}

mvp() {
	desc="Usage: [mvp 'file' 'dest'] moves a file creating parent dirs if necessary."
	print_usage "$1" "$desc" && return

	[[ $# -ne 2 ]] && { echo "Need a source and a destination"; return; }

	dest="$2"
    [[ -f "$dest" ]] && { echo "Second argument must be a folder" return; }
    [[ ! -d "$dest" ]] && { __mkconfirm "$dest" || return }

	mv "$1" "$dest" && echo -n "Successfully moved $1 to $dest"
}

cpd() {
	desc="Usage: [cpd 'file' 'dest'] recursively copies a file to destination creating parent dirs if necessary."
	print_usage "$1" "$desc" && return

	dest="$2"
    [[ ! -d "$dest" ]] && { __mkconfirm "$dest" || return }

    cp -r "$1" "$dest" && echo -n "Successfully copied $1 to $dest"
}

ased() {
	desc="Usage: [ased 'search_term' 'replace_regex'] Find all the files containing the given search_term and applies the given regex."
	print_usage "$1" "$desc" && return

    force=false
    search=$1
    replace=$2
    [[ "$#" -lt 2 ]] && { echo "Expecting a search term and a replace regex string"; return }
    if [[ "$#" -eq 3 ]]; then
      [[ "$1" != "-f" ]] && { echo "First arg should be -f to force replace"; return }
      force=true
      search=$2
      replace=$3
    fi
    # Make sure we are in a git repo, to be safe, unless force is used.
    git rev-parse 2>/dev/null || [[ "$force" = true ]] && ag -Ql "$search" | xargs sed -i "" "$replace"
}

# kubectrl aliases
kcu() {
    env="$1"
    kc config use-context "$env"
}

kcl() {
    pod="$1"
    kc logs -f $(kc get po | grep "$pod" | awk 'NR==1 {print $1}')
}

kcc() {
	env="$1"
	app="$2"

	[[ "$#" -eq 0 ]] && { echo "Missing args, required env and optional pod name"; return }
	[[ "$#" -eq 1 ]] && { eval "kc -n $env get po"; return }
	eval "kc -n $env describe po $app | grep Image: | cut -d: -f3"
}

kvars() {
	env="$1"
	app="$2"

	[[ -z "env" ]] && { echo "Missing env"; return }
	kc -n "$env" exec -it $(kcc "$env" | grep "$app" | head -1 | cut -d" " -f 1) env | grep URL
}

# Reset mouse when it gets stuck (e.g. when left click stops working)
remouse() {
    modprobe -r psmouse
    modprobe psmouse
}

# ways of splitting into lines
#     tr : \\n
#     sed 's/:/\n/g'
#     awk '{ gsub(":", "\n") } 1'
spl() {
	[[ ! -z "$1" ]] && DELIM="$1" || DELIM=" "
	tr "$DELIM" "\n"
}

# Print the given line number from a file.
# If no file is provided it assumes the file is the output of a pipe.
pln() {
    USAGE="Usage: pln <line_number> [optional]<file>"
    [[ "$#" -eq 0 ]] || [[ "$1" == -h ]] && echo "$USAGE"; return
    sed "${1}q;d" $2
}

awkat() {
    usage='print_usage "-h" "Usage: Concat string with awk output
    => awkat <string> [-o <lines to offset>] [-l <lines to return>]
    [-f <filename>] [-a (append instead of prepend)]"; return'

    offset=0
    lines=0
    file=''
    append='false'
    str=''

    while test $# -gt 0; do
        case "$1" in
            -h) eval "$usage" ;;
            -o) [[ -z "$2" ]] && eval "$usage"
                offset=$2; shift 2 ;;
            -l) [[ -z "$2" ]] && eval "$usage"
                lines=$2; shift 2 ;;
            -f) [[ -z "$2" ]] && eval "$usage"
                file=$2; shift 2 ;;
            -a) append='true'; shift ;;
            -*) echo ">>> unknown flag: $1!"; eval "$usage" ;;
            *) str="$1"; shift ;;
        esac
    done

    arg="NR>$offset"
    [[ $lines -gt 0 ]] && arg+="&&NR<=$(($lines+$offset))"

    if [[ "$append" == 'true' ]]; then
        arg+=' {print $1 s}'
    else
        arg+=' {print s $1}'
    fi
    awk "$arg" s=$str $file
}

## jq
# format a stringified json payload from clipboard
fclip () { jq -r <<<"$(pblip)" }
# format a stringified inner field from clipboard
finner () { jq -r ."$1" <<<"$(pclip)" | jq . }
# output a csv from a json array input
jqv () { jq -r '(.[0] | keys_unsorted) as $keys | $keys, map([.[ $keys[] ]])[] | @csv' }

# cp latest downloaded file
cpl () {
    latest=$(ls -t $HOME/Downloads | head -1)
    cp -r $HOME/Downloads/"$latest" . && echo "$latest"
}

# converts bytes to their decimal value.
# If the -r flag is used then it also converts it back to ASCII
xxdb () {
    cmd='while read -r line; do printf "%x" $(((2#$line))); done < ${1:-/dev/stdin}'
    if [[ "$1" == "-r" ]]; then
        shift; eval "$cmd | xxd -r -p"; return
    fi
    eval "$cmd"
}

# Vim script to be called when in vim termianl to change window local directory to pwd
if [[ -n "$VIM_TERMINAL" ]]; then
  cdv() {
    printf -- '\033]51;["call", "Tapi_lcd", "%q"]\007' "$(pwd)"
  }
elif [[ -n "$NVIM" ]]; then
  cdv() {
    # Requires neovim-remote installed
    nvr --servername "$NVIM" --remote-expr "$(printf -- 'Tapi_lcd(0, "%q")' "$(pwd)")"
  }

  # Make sure we are not nesting nvim sessions
  alias nvim=nvr
fi

# Source fzf (should be kept last)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
