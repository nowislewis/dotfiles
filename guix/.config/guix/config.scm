;; This is an operating system configuration generated
;; by the graphical installer.
;;
;; Once installation is complete, you can learn and modify
;; this file to tweak the system configuration, and pass it
;; to the 'guix system reconfigure' command to effect your
;; changes.


;; Indicate which modules to import to access the variables
;; used in this configuration.
(use-modules (gnu) (nongnu packages linux))
(use-modules (gnu) (nongnu system linux-initrd))
(use-modules (gnu packages shells))
(use-service-modules cups desktop networking ssh xorg sddm)

(operating-system
 (kernel linux)
 (firmware (list linux-firmware))
 (initrd microcode-initrd)
 (locale "en_US.utf8")
 (timezone "Asia/Shanghai")
 (keyboard-layout (keyboard-layout "us"))
 (host-name "guix")

 ;; The list of user accounts ('root' is implicit).
 (users (cons* (user-account
                (name "lewisliu")
                (comment "Lewisliu")
                (group "users")
                (shell (file-append zsh "/bin/zsh"))
                (home-directory "/home/lewisliu")
                (supplementary-groups '("wheel" ;; sudo
                                        "netdev" ;; network devices
                                        "lp"       ;; control bluetooth devices
                                        "audio"    ;; control audio devices
                                        "video"))) ;; control video devices
               %base-user-accounts))

 ;; Packages installed system-wide.  Users can also install packages
 ;; under their own account: use 'guix search KEYWORD' to search
 ;; for packages and 'guix install PACKAGE' to install a package.
 (packages (append (map specification->package
                        '("git"
                          "stow"
                          "vim"
                          "bluez"
                          "bluez-alsa"
                          "blueman"
                          ))
                   %base-packages))

 ;; Below is the list of system services.  To search for available
 ;; services, run 'guix system search KEYWORD' in a terminal.
 ;; (services (append
 ;;            (modify-services %base-services
 ;;                             (delete login-service-type)
 ;;                             (delete mingetty-service-type)
 ;;                             (delete console-font-service-type)
 ;;                             )
 ;;            (list)
 ;;            ))
 (services
  (modify-services
   (append (list
		    ;; To configure OpenSSH, pass an 'openssh-configuration'
		    ;; record as a second argument to 'service' below.
		    (service openssh-service-type)
		    ;; (set-xorg-configuration
		    ;;  (xorg-configuration (keyboard-layout keyboard-layout)))
            (service sddm-service-type)
            (service bluetooth-service-type
                     (bluetooth-configuration
                      (auto-enable? #t)))
            )
	       ;; %desktop-services
           (modify-services %desktop-services
                            (delete gdm-service-type))
           )
   (guix-service-type config => (guix-configuration
                                 (inherit config)
                                 (substitute-urls
                                  (append (list "https://mirror.sjtu.edu.cn/guix/" "https://ci.guix.gnu.org" "https://substitutes.nonguix.org")
                                          %default-substitute-urls)
                                  )
                                 (authorized-keys
                                  (append (list (plain-file "non-guix.pub"
  							                                "(public-key
                                    (ecc
                                     (curve Ed25519)
                                     (q #C1FD53E5D4CE971933EC50C9F307AE2171A2D3B52C804642A7A35F84F3A4EA98#)
                                    )
                                  )"
                                                            )
                                                (plain-file "guix-hpc.pub"
                                                            "(public-key
 (ecc
  (curve Ed25519)
  (q #89FBA276A976A8DE2A69774771A92C8C879E0F24614AAAAE23119608707B3F06#)))"

                                                            ))
                                          %default-authorized-guix-keys))))))
 (bootloader (bootloader-configuration
              (bootloader grub-efi-bootloader)
              (targets (list "/boot/efi"))
              (keyboard-layout keyboard-layout)))
 (swap-devices (list (swap-space
                      (target (uuid
                               "b284c6f3-10a2-44cb-88cc-0caa3f108084")))))

 ;; The list of file systems that get "mounted".  The unique
 ;; file system identifiers there ("UUIDs") can be obtained
 ;; by running 'blkid' in a terminal.
 (file-systems (cons* (file-system
                       (mount-point "/boot/efi")
                       (device (uuid "982D-6B98"
                                     'fat32))
                       (type "vfat"))
                      (file-system
                       (mount-point "/")
                       (device (uuid
                                "f3485031-92e2-4ee5-b057-d2a38976c622"
                                'ext4))
                       (type "ext4")) %base-file-systems)))
