if status is-interactive

end

fenv source ~/.bashrc
# fish_config theme choose "Dracula"
# style
starship init fish | source

if test (uname) = "Darwin"
   pyenv init -| source
end

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

