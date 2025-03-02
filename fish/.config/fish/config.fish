if status is-interactive

end

fenv source ~/.bashrc
# fish_config theme choose "Dracula"
# style
starship init fish | source


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

# Create a new frame instead of trying to use the current Emacs frame
alias e 'emacsclient -nc'
alias en 'emacsclient -nw'
# alias emacs 'emacsclient -c; or emacs'


# pyenv
 
# if test (uname) = "Darwin"
set -Ux PYENV_ROOT $HOME/.pyenv
fish_add_path $PYENV_ROOT/bin
pyenv init - | source
# end
alias t 'tmux attach||tmux'
