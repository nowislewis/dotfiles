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
(use-modules (gnu packages shells))
(use-service-modules cups desktop networking ssh xorg)

(operating-system
  (kernel linux)
  (firmware (list linux-firmware))
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
                  (supplementary-groups '("wheel" "netdev" "audio" "video")))
                %base-user-accounts))

  ;; Packages installed system-wide.  Users can also install packages
  ;; under their own account: use 'guix search KEYWORD' to search
  ;; for packages and 'guix install PACKAGE' to install a package.
  (packages (append (list (specification->package "nss-certs"))
                    %base-packages))

  ;; Below is the list of system services.  To search for available
  ;; services, run 'guix system search KEYWORD' in a terminal.
  (services
   (modify-services
    (append (list 
	       ;;(service sway-desktop-service-type)
		          ;; To configure OpenSSH, pass an 'openssh-configuration'
		          ;; record as a second argument to 'service' below.
		          (service openssh-service-type)
		          ;; (service bluetooth-service-type)
		          (set-xorg-configuration
		           (xorg-configuration (keyboard-layout keyboard-layout))))
	        %desktop-services)
    (guix-service-type config => (guix-configuration
                                  (inherit config)
                                  (substitute-urls
                                   (list "https://mirror.sjtu.edu.cn/guix/" "https://ci.guix.gnu.org" "https://substitutes.nonguix.org"))
                                  (authorized-keys
                                   (append (list (plain-file "non-guix.pub"
  							     "(public-key
                                    (ecc
                                     (curve Ed25519)
                                     (q #C1FD53E5D4CE971933EC50C9F307AE2171A2D3B52C804642A7A35F84F3A4EA98#)
                                    )
                                  )"
                                 )
                                                 )
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
