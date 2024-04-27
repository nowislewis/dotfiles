# Bash initialization for interactive non-login shells and
# for remote shells (info "(bash) Bash Startup Files").

# Export 'SHELL' to child processes.  Programs such as 'screen'
# honor it and otherwise use /bin/sh.
export SHELL

if [[ $- != *i* ]]
then
    # We are being invoked from a non-interactive shell.  If this
    # is an SSH session (as in "ssh host command"), source
    # /etc/profile so we get PATH and other essential variables.
    [[ -n "$SSH_CLIENT" ]] && source /etc/profile

    # Don't do anything else.
    return
fi

# Source the system-wide file.
# [ -f /etc/bashrc ] && source /etc/bashrc

alias ls='ls -p --color=auto'
alias ll='ls -l'
alias grep='grep --color=auto'


#  +------------+
#  | Common Env |
#  +------------+
export VISUAL=vim
export EDITOR=$VISUAL
# style
#export PATH=$PATH:"$HOME/.local/bin"

if [[ $(uname) == "Darwin" ]]
then
    export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.ustc.edu.cn/brew.git"
    export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
    export PATH="/opt/homebrew/opt/libxml2/bin:$PATH"
    export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
    # gnu sort behavior
    export LC_COLLATE=POSIX
fi

if [[ $(uname) == "Linux" ]]
then
    GUIX_PROFILE="/home/lewisliu/.guix-profile"
    . "$GUIX_PROFILE/etc/profile";
    export PATH=$PATH:"/usr/local/bin"; # for manual installed starship
fi


# host_ip=$(cat /etc/resolv.conf | grep "nameserver" | cut -f 2 -d " ")
export host_ip=127.0.0.1


proxy_on() {
    export http_proxy="http://$host_ip:7890"
    export https_proxy="http://$host_ip:7890"
    echo -e "终端代理已开启。"
}

proxy_off() {
    unset http_proxy https_proxy all_proxy
    echo -e "终端代理已关闭。"
}

alias emacs='emacsclient -c||emacs'
