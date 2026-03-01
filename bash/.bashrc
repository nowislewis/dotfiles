# Bash initialization for interactive non-login shells and
# for remote shells (info "(bash) Bash Startup Files").

# Export 'SHELL' to child processes.  Programs such as 'screen'
# honor it and otherwise use /bin/sh.
export SHELL

if [[ $- != *i* ]]
then
    [[ -n "$SSH_CLIENT" ]] && source /etc/profile
    return
fi

alias ls='ls -p --color=auto'
alias ll='ls -l'
alias grep='grep --color=auto'


#  +------------+
#  | Common Env |
#  +------------+
export VISUAL=vim
export EDITOR=$VISUAL
# style
# for d2
export PATH=$PATH:"$HOME/.local/bin"
export PATH=$PATH:"$HOME/my_soft/bin"
export PATH=$PATH:"$HOME/go/bin"; # for go install

# mkdir -p ~/.npm-global
# npm config set prefix '~/.npm-global'
export PATH=$PATH:"$HOME/.npm-global/bin"
if [[ $(uname) == "Darwin" ]]
then
    # export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.ustc.edu.cn/brew.git"
    export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
    export PATH="/opt/homebrew/opt/libxml2/bin:$PATH"
    export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
    export PATH="/Users/liuyi/Downloads/emacs/nextstep/Emacs.app/Contents/MacOS:$PATH"
fi

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

alias e='emacsclient -nc'
alias en='emacsclient -nw'
alias t='tmux attach||tmux'

if [ -d "/gnu/store" ]; then
    GUIX_PROFILE="/home/lewisliu/.guix-profile"
    . "$GUIX_PROFILE/etc/profile"
    unset GUIX_PROFILE
fi

setup_env_from_temp() {
    local config_file=${HOME}/.authinfo

    [ -f "$config_file" ] || return 0

    while read -r line; do
        domain=$(awk '{print $2}' <<< "$line" | sed 's/[.\/-]/_/g')
        password=$(awk '{print $NF}' <<< "$line")
        
        # 忽略以数字开头的域名
        [[ "$domain" =~ ^[0-9] ]] && continue
        
        export "$(tr '[:lower:]' '[:upper:]' <<< "$domain")_KEY"="$password"
    done < "$config_file"
}
setup_env_from_temp
