(use-modules (gnu services)
             (gnu packages)
             (gnu home)
             (gnu home services niri)
             (guix gexp)
             (guix transformations))

(home-environment
  (packages
   (map (compose list specification->package+output)
        '("foot" "alacritty" "niri" "font-google-noto-serif-cjk"
          "tree" "curl" "gcc-toolchain" "starship"
          "zoxide" "fzf" "git" "zsh" "stow" "make" "zip" "unzip"
          "ripgrep" "fd" "emacs-next-pgtk" "vim")))
  (services
   (list
    (service home-niri-service-type)
    (service home-zsh-service-type
             (home-zsh-configuration
              (default-shell? #t)))
    )))
