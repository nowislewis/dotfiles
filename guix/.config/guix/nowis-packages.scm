(use-modules (guix packages)
             (guix git-download)
             (guix build-system gnu)
             (guix gexp)
             (guix utils)
             (gnu packages emacs)
             (gnu packages version-control)
             (gnu packages tree-sitter)
             (gnu packages gtk))

(define emacs-local
  (package
   (inherit emacs-next-pgtk)
   (name "emacs-local")
   (source (local-file "/home/lewisliu/Downloads/emacs" #:recursive? #t))
   (native-inputs
    `(("git" ,git)  ; 添加 git
      ,@(package-native-inputs emacs-next-pgtk)))
    (inputs
     (modify-inputs (package-inputs emacs-next-pgtk)
       (prepend tree-sitter)))
    (arguments
     (substitute-keyword-arguments (package-arguments emacs-next-pgtk)
       ((#:configure-flags flags #~'())
        #~(append #$flags
                  (list
                   "--with-native-compilation=no"
                   "--with-tree-sitter"
                   )))
       ((#:make-flags flags #~'())
        #~(append (list "-j16") #$flags))
       ((#:tests? _ #f) #f)
       ((#:phases phases)
        #~(modify-phases #$phases
            (delete 'validate-comp-integrity)))
       ))
  ))

emacs-local
