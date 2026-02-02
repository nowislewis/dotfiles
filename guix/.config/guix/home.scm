(use-modules (gnu services)
             (gnu packages)
             (gnu home)
             (gnu home services niri)
             (guix gexp)
             (guix transformations))

(home-environment
 (packages
  (map (compose list specification->package+output)
       '("foot" "niri" "waybar" "swaybg" "fuzzel" "font-google-noto-serif-cjk" "xdg-utils"
         "tree" "curl" "gcc-toolchain" "starship"
         "zoxide" "fzf" "git" "zsh" "stow" "make" "zip" "unzip"
         "ripgrep" "fd" "vim"
         "ffmpeg" "cmake"
         )))
 (services
  (append
   (list
    (service home-niri-service-type)
    )
   %base-home-services
   )))
