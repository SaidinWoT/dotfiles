# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory autocd extendedglob
unsetopt beep
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/scott/.zshrc'

autoload -Uz compinit
compinit
autoload -U promptinit colors
promptinit
colors
prompt walters

export PATH=${PATH}:/opt/android-sdk/platform-tools
export GOPATH=/home/scott/code/go
export PYTHONPATH=/usr/lib/python3.4/site-packages
# . /usr/share/zsh/site-contrib/powerline.zsh

export EDITOR='vim'

alias cc='gcc -Wall'
alias ccp='gcc -Wall -pedantic'

alias -g hush='> /dev/null 2>&1 &!'
alias w='luakit hush'
alias cw='google-chrome-stable hush'
alias fb='google-chrome-stable --incognito --app="http://www.facebook.com" hush'
alias nf='google-chrome-stable --app="http://www.netflix.com" hush'
alias hulu='google-chrome-stable --app="http://www.hulu.com" hush'

alias key='eval $(keychain --eval -q ~/.ssh/id_rsa)'
alias mosh='mosh --server="LANG=$LANG mosh-server"'
alias mu='key && mosh sfrazier@206.190.128.252'
alias mut='mu tmux attach'

alias ds='~/.suckless/wmstat/dwmstatus hush'
alias wam='w mut'
alias cam='cw mut'
alias fwam='fb wam'

alias redwm='pushd ~/.suckless/dwm && updpkgsums && yes | makepkg -efi; popd'
alias rest='pushd ~/.suckless/st && updpkgsums && yes | makepkg -efi; popd'

alias ls='ls --color=auto --group-directories-first'
alias la='ls -A'
alias lf='ls -lh'
alias ld='ls -Alh'
alias grep='grep --colour=auto'
alias mkdir='mkdir -pv'
alias cdgo='cd /home/scott/code/go/src/github.com/SaidinWoT'
function cdls () { cd $* && ls }

alias sql='sqlite3 -echo -header -column'

alias syu='sudo pacman -Syu'

alias -s {txt,c,py,lisp}=${EDITOR}
alias -s {odt,doc,docx,ppt,pptx,xls,xlsx,rtf}='libreoffice'
alias -s {png,jpg,jpeg,gif}='feh'
alias -s pdf='epdfview'

alias sc='wine ~/.wine/drive_c/Program\ Files/Starcraft/StarCraft.exe'
alias rs='runescape --prmfile=oldschool.prm'

alias emacs='emacs -nw'
alias e='emacs'
alias wifi='wicd-curses'
alias :q='exit'
alias off='sudo systemctl poweroff'
alias rbt='sudo systemctl reboot'

function am () {
    ln -s /home/scott/media/beets/flac/$@ /home/scott/media/google/music/$@
}

function s () {
    regex="s$@p"
    input=$(< /dev/stdin)
    echo $(sed -n $regex <<< $input)
}

function v () {
if [ -n "$1" ] ; then
    vim "$@"
else
    dir=$(basename $(pwd))
    session=".$dir.vim"
    if [ -f $session ] ; then
        vim -S $session
    else
        vim
    fi
fi
}

function sprunge () {
if ! [[ "$( tty )" == /dev/* ]] ; then
    link=$(curl -sF "sprunge=<-" http://sprunge.us < /dev/stdin)
elif [ -f "$1" ] ; then
    link=$(curl -sF "sprunge=<$1" http://sprunge.us)
    if [ -n "$2" ] ; then
        lex="?$2"
    elif [ "${1/*./}" != "$1" -a ".${1/*./}" != "$1" ] ; then
        lex="?${1/*./}"
    else
        lex=""
    fi
fi
if [ $(command -v xclip) ] ; then
    echo "Copying to xclip..."
    echo $link$lex | tee /dev/stderr | xclip
else
    echo $link$lex
fi
}

function webpass() {
    #usage: webpass <website>

    website=$1
    echo "Password: "
    stty -echo
    read password
    stty echo

    #echo "$password$website" | sha1sum - | cut -d" " -f1 | xxd -r -p | base64 | tr -d -c [:alnum:]
    echo "$password$website" | sha1sum - | cut -d" " -f1 | xxd -r -p | base64
}

function hack() {
pause=.1
if [ -n "$1" ] ; then
    pause=$1
fi
seed=$(md5sum <<< $(date))
while true; do
    echo ${seed:0:32}
    if [[ $(( RANDOM & 3 )) -eq 3 ]] ; then
        seed=$(md5sum <<< "$seed")
    elif [[ $(( RANDOM & 3 )) -eq 2 ]] ; then
        seed=$(sha1sum <<< "$seed")
    elif [[ $(( RANDOM & 3 )) -eq 1 ]] ; then
        seed=$(sha256sum <<< "$seed")
    else
        seed=$(sha512sum <<< "$seed")
    fi
    sleep $pause
done
}

function typecrap() {
speed=10
if [ -n "$1" ] ; then
    speed=$1
fi
    < /dev/urandom tr -dc A-Za-z0-9 | pv -qL $speed -i 0.1
}

function paest() {
  local paest_p=""
  local paest_k=""

  # Parse args
  while getopts ":h?up:k:" opt; do
    case "$opt" in
    h|\?)
        echo "paest [-u] [-p paest_id] [-k paest_key] [file]"
        echo "  -u            update the last paest (same as using -p and -k from the last paest call)"
        echo "  -p paest_id   request the provided paest id (default: server provided id)"
        echo "  -k paest_key  use the provided key for paesting, required for updating or deleting"
        echo "  file          optional file to paest, defaults to reading stdin"
        echo ""
        echo "something | paest     Store output of something in a new paest each time"
        echo "paest file            Upload a file"
        echo "something | paest -u  Some output of something, overwriting each time"
        echo "paest -p MyFile file  Upload a file, try to get 'MyFile' as the paest id"
        return
        ;;
    p)  paest_p=$OPTARG
        ;;
    k)  paest_k=$OPTARG
        ;;
    u)  paest_p=$PAEST_P;
        paest_k=$PAEST_K;
        ;;
    esac
  done
  shift $(( $OPTIND - 1 ))

  # Try to get a file
  FILE=$1
  if [ $FILE ]
  then
  shift
  fi

  # We should be out of args now.
  if [ $@ ]
  then
    echo "Error: Unused arguments: $@"
    exit 1
  fi

  # Perform the paest
  url="http://a.pae.st/$paest_p/$paest_k"
  if [ $FILE ]
  then
    out=$(curl -s -F "-d=@$FILE" $url | grep "CLI-PRIVATE" | cut -d# -f1)
  else
    out=$(curl -s -F '-d=<-' $url | grep "CLI-PRIVATE" | cut -d# -f1)
  fi

  # Handle response data
  export PAEST_P=$(echo $out | cut -d/ -f4)
  export PAEST_K=$(echo $out | cut -d/ -f5)
  echo "Id: $PAEST_P"
  echo "Key: $PAEST_K"
}
