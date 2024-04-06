# style
export PATH=$PATH:"/usr/local/bin" # for manual installed starship
 eval "$(starship init zsh)"
 # completion
 source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
 # path
 export PATH=$PATH:"$HOME/.local/bin"
 export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.ustc.edu.cn/brew.git"
 export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
 export PATH="/opt/homebrew/opt/libxml2/bin:$PATH"
 export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
 # gnu sort behavior
 export LC_COLLATE=POSIX

 # host_ip=$(cat /etc/resolv.conf | grep "nameserver" | cut -f 2 -d " ")
 host_ip=127.0.0.1
 function proxy_on() {
     export http_proxy="http://$host_ip:7890"
     export https_proxy="http://$host_ip:7890"
     echo -e "终端代理已开启。"
 }

 function proxy_off() {
     unset http_proxy https_proxy all_proxy
     echo -e "终端代理已关闭。"
 }
 # proxy_on

 alias emacs='emacsclient -c||emacs'

 ## for wsl
 # export DISPLAY=`cat /etc/resolv.conf | grep nameserver | awk '{print $2}'`:0.0
 # export DISPLAY=127.0.0.1:0.0

## pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"


     GUIX_PROFILE="/home/lewisliu/.guix-profile"
          . "$GUIX_PROFILE/etc/profile"
fish
