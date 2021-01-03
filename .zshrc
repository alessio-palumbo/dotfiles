# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Theme
# Favourites: mytheme, philips, refined, murilasso, gozilla, gnzh, tonotdo, kafeitu, frontcube, sunaku, amuse, jtriley
ZSH_THEME="mytheme" #mytheme

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  extract
  zsh-autosuggestions
  zsh-syntax-highlighting
  autojump
  go
  docker
  docker-compose
  aws
  kubectl
  kops
  ssh-agent
  cargo
 # vi-mode
)

# Autojump plugin was installed through apt
. /usr/share/autojump/autojump.sh

# Add version control identities to ssh-agent at startup
zstyle :omz:plugins:ssh-agent identities id_rsa #id_rsa_bb

source $ZSH/oh-my-zsh.sh

# eksctl
fpath=($fpath ~/.zsh/completion)

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

##### Git

# Git aliases
alias gta='git add -A'
alias gtc='git commit -m '
alias gts='git status'
alias gtp='git pull `git symbolic-ref --short HEAD`'
alias gtpr='git pull --rebase'
alias gcm='git checkout master'
alias gcmp='git checkout master && git pull'
alias gc-='git checkout -'
alias gtalias='cat ~/.zshrc | grep "alias g"'
alias glm='git log --author=$(git config user.name)'
alias gdc='git diff --cached'
# git colorized logs
alias glg='git log --date-order --all --graph --format="%C(green)%h%Creset %C(yellow)%an%Creset %C(blue bold)%ar%Creset %C(red bold)%d%Creset%s"'
alias lg='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'

# Git Scripts

gbc () {
	if [[ "$1" == "-h" ]]; then
		echo "Usage: remove all local branches except master"
		return
	fi
    merged="--merged"
    [[ ! -z $1 ]] && [[ $1 == "-f" ]] && merged=""
    git for-each-ref --format '%(refname:short)' "$merged" HEAD refs/heads/ |\
        grep -v master | xargs git branch -D 2>/dev/null ||\
        echo "No unmerged branches found. Use -f to remove unmerged (ecluding master)"
}

gh () {
    [ -n "$1" ] && [ "$1" -gt 0 ] && SKIP=$(($1 - 1)) || SKIP=0
    [ $# -eq 2 ] && FMT=$2 || FMT=H
    echo -n $(git log -1 --skip="$SKIP" --pretty="%$FMT")
}
ghl () {
    git log -p $(gh $1) -1
}
ghc () {
    gh $1 | xclip -sel clip
    echo $(ght $1)
}
ght () {
    SKIP=0; FMT=s
    [ $# -eq 1 ] && SKIP=$1
    [ $# -eq 2 ] && FMT=$2
    gh $SKIP $FMT
}

##### Other Aliases

## General Utils

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

# return list of dirs in stack
alias ldir="dirs | spl"

# tmux
alias ts='tmux new-session -s'
alias ta='tmux attach -t'

# start and stop mongoDB
alias smsta='sudo service mongod start'
alias smsto='sudo service mongod stop'

# restart postgres
alias sprsta='sudo service postgresql restart'

## Platform specific

# swagger compile and run
# alias swag='swagger generate spec -o ./swagger.json && swagger serve ./swagger.json'
# alias swagger="docker run --rm -it -e GOPATH=$HOME/go:/go -v $HOME:$HOME -w $(pwd) --user "$(id -u):$(id -g)" quay.io/goswagger/swagger:v0.25.0"

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

##### Path Languages

# Ruby
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
# export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"
# start ruby server
# alias ruby_s='ruby -run -e httpd . -p 8000'

# Go
export PATH="$HOME/dev/go/bin:/usr/local/go/bin:$HOME/go/bin:$PATH"
export GOPATH="$HOME/dev/go"

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

__mkconfirm() {
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

# kubectrl aliases

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
spl() { tr " " "\n" }

# jq
# format a stringified json payload from clipboard
fclip () { jq -r <<<"$(pblip)" }
# format a stringified inner field from clipboard
finner () { jq -r ."$1" <<<"$(pclip)" | jq . }

# alias cd into path (uses ~/bin/op script)
cdf() {
    cd $(op "$1" path)
    [ -n "$2" ] && cd $(ls | awk "/$2/" | head -n 1)
}

# Source fzf (should be kept last)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
