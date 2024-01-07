if status is-interactive

end

fish_config theme choose "Dracula"
# style
starship init fish | source


# var
if test (uname) = "Darwin"
   set -xg HOMEBREW_BREW_GIT_REMOTE "https://mirrors.ustc.edu.cn/brew.git"
   set -xg HOMEBREW_CORE_GIT_REMOTE "https://mirrors.ustc.edu.cn/homebrew-core.git"
   set -xg HOMEBREW_BOTTLE_DOMAIN "https://mirrors.ustc.edu.cn/homebrew-bottles"
   set -xg HOMEBREW_API_DOMAIN "https://mirrors.ustc.edu.cn/homebrew-bottles/api"
end


set -gx PATH $PATH $HOME/.local/bin
# gnu sort behavior
set -gx LC_COLLATE POSIX

pyenv init -| source
# proxy
set -gx host_ip 127.0.0.1
function proxy_on
	set -gx http_proxy "http://$host_ip:7890"
	set -gx https_proxy "http://$host_ip:7890"
	echo -e "终端代理已开启。"
end

function proxy_off
    set -e http_proxy
    set -e https_proxy
    set -e all_proxy
    echo -e "终端代理已关闭。"
end

function e
    emacsclient -c $$argv||emacs $argv
end


