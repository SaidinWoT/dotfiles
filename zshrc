# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory autocd extendedglob
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/scott/.zshrc'

autoload -Uz compinit
compinit
autoload -U promptinit colors
promptinit
colors
prompt walters

export EDITOR='vim'

alias v='vim'
alias cc='gcc -Wall'
alias ccp='gcc -Wall -pedantic'

alias -g hush='> /dev/null 2>&1 &!'
alias w='luakit hush'
alias cw='chromium hush'

alias key='eval $(keychain --eval -q ~/.ssh/id_rsa)'
alias mosh='mosh --server="LANG=$LANG mosh-server"'
alias mu='key && mosh sfrazier@udderweb.com'
alias mut='mu tmux attach'
alias muw='key && mosh uw@udderweb.com'

alias tw='sudo tail -f /var/log/wicd/wicd.log || clear'
alias tww='tw || w'
alias bam='w mut'
alias ta='tw || bam'

alias ls='ls --color=auto --group-directories-first'
alias la='ls -A'
alias lf='ls -lh'
alias ld='ls -Alh'
alias grep='grep --colour=auto'
alias mkdir='mkdir -pv'
function cdls () { cd $* && ls }

alias syu='yaourt -Syu'
alias syua='yaourt -Syua'

alias -s {txt,c,py,lisp}=${EDITOR}
alias -s {odt,doc,docx,ppt,pptx,xls,xlsx,rtf}='libreoffice'
alias -s {png,jpg,jpeg,gif}='feh'
alias -s pdf='epdfview'

alias sc='wine ~/.wine/drive_c/Program\ Files/Starcraft/StarCraft.exe'

alias wifi='wicd-curses'
alias :q='exit'
alias off='sudo poweroff'
alias rbt='sudo reboot'

function sprunge () {
lex=""
if ! [[ "$( tty )" == /dev/* ]] ; then
    link=`curl -sF "sprunge=<-" http://sprunge.us < /dev/stdin`;
elif [ -f "$1" ] ; then
    link=`curl -sF "sprunge=<-" http://sprunge.us < $1`;
    if [ -n "$2" ] ; then
        lex="?$2";
    elif [ "${1/*./}" != "$1" -a ".${1/*./}" != "$1" ] ; then
        lex="?${1/*./}";
    fi
fi
if [ `command -v xclip` ] ; then
    echo $link$lex | tee /dev/stderr | xclip;
else
    echo $link$lex;
fi
}
