if status is-interactive

end

fish_config theme choose "Dracula"
# style
starship init fish | source

set -gx PATH $PATH $HOME/.local/bin
# gnu sort behavior
set -gx LC_COLLATE POSIX

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
pyenv init -| source
