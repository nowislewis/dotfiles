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
                  (home-directory "/home/lewisliu")
                  (supplementary-groups '("wheel" "netdev" "audio" "video")))
                %base-user-accounts))

  ;; Packages installed system-wide.  Users can also install packages
  ;; under their own account: use 'guix search KEYWORD' to search
  ;; for packages and 'guix install PACKAGE' to install a package.
  (packages %base-packages)

  ;; Below is the list of system services.  To search for available
  ;; services, run 'guix system search KEYWORD' in a terminal.
  (services
   (modify-services
       (append (list
		        (service openssh-service-type)
                (service bluetooth-service-type
                         (bluetooth-configuration
                           (auto-enable? #t)))
		        (set-xorg-configuration
		         (xorg-configuration (keyboard-layout keyboard-layout))))
	           %desktop-services)
    (guix-service-type config => (guix-configuration
                                  (inherit config)
                                  (substitute-urls
                                   (list "https://mirror.sjtu.edu.cn/guix/" "https://substitutes.nonguix.org"))
                                  (authorized-keys
                                   (append (list (local-file "./signing-key.pub"))
                                           %default-authorized-guix-keys))))))
  (bootloader (bootloader-configuration
                (bootloader grub-efi-bootloader)
                (targets (list "/boot/efi"))
                (keyboard-layout keyboard-layout)))

  ;; The list of file systems that get "mounted".  The unique
  ;; file system identifiers there ("UUIDs") can be obtained
  ;; by running 'blkid' in a terminal.
  (file-systems (cons* (file-system
                         (mount-point "/boot/efi")
                         (device (uuid "55DD-B144"
                                       'fat32))
                         (type "vfat"))
                       (file-system
                        (mount-point "/")
                        (device (uuid
                                 "d48055b1-1552-4fbe-ada5-e159b580a073"
                                 'ext4))
                        (type "ext4")) %base-file-systems))
  )
