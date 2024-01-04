# style
starship init fish | source

set -x PATH $PATH $HOME/.local/bin
# gnu sort behavior
set -x LC_COLLATE POSIX

set host_ip 127.0.0.1
function proxy_on
	set -x http_proxy http://$host_ip:7890
	set -x https_proxy http://$host_ip:7890
	echo -e "终端代理已开启。"
end

function proxy_off
	set -e http_proxy
  set -e https_proxy
  set -e all_proxy
	echo -e "终端代理已关闭。"
end

proxy_on

alias emacs 'emacsclient -c|| emacs'
