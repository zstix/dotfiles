;;
;; Packages
;;;;

;; Define package repositories
(require 'package)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "https://stabel.melpa.org/packages/") t)

;; Load and activate emacs packages. Do this first so that the
;; packages are loaded before you start trying to modify them.
;; This also sets the load path.
(package-initialize)

;; Download the ELPA archive description if needed.
;; This informs Emacs about the latest versions of all packages, and
;; makes them available for download.
(when (not package-archive-contents)
  (package-refresh-contents))

;; The packages you want installed. You can also install these
;; manually with M-x package-install
;; Add in your own as you wish:
(defvar my-packages
  '(;; Enhances M-x to allow easier execution of commands. Provides
    ;; a filterable list of possible commands in the minibuffer
    ;; https://www.emacswiki.org/emacs/Smex
    smex
    
    ;; git integration
    magit

    ;; Fuzzy find all the things
    helm
    helm-projectile

    ;; theme
    gruvbox-theme

    ;; clojure key bindings and syntax highlighting
    clojure-mode
    clojure-mode-extra-font-locking

    ;; integration with Clojure REPL
    cider

    ;; colorful parenthesis matching
    rainbow-delimiters

    ;; edit html tags like sexps
    tagedit

    ;; project navigation
    projectile

    ;; JS / Typescript setup
    web-mode
    tide

    ;; completion
    company

    ;; syntax checking
    flycheck

    ;; Because vim is too good to give up
    evil
    ))

;; Fix for OSX not treating GUI and terminal emacs the same.
;; https://github.com/purcell/exec-path-from-shell
(if (eq system-type 'darwin)
    (add-to-list 'my-packages 'exec-path-from-shell))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;; Place downloaded elisp files in ~/.emacs.d/vendor. You'll then be able
;; to load them.
(add-to-list 'load-path "~/.emacs.d/vendor")


;;;;
;; Customization
;;;;

;; Add a directory to our load path so that when you `load` things
;; below, Emacs knows where to look for the corresponding file.
(add-to-list 'load-path "~/.emacs.d/customizations")

;; Sets up exec-path-from-shell so that Emacs will use the correct
;; environment variables.
;; (load "shell-integrations.el")

;; These customizations make it easier for you to navigate files,
;; switch buffers, and choose options from the mininbuffer.
;; (load "navigation.el")

;; These customizations change the way emacs look and disable/enable
;; some of the user interface elements.
(load "ui.el")

;; These customizations make editing a bit nicer.
(load "editing.el")

;; Clojure-specific configuration.
(load "setup-clojure.el")

;; Hard-to-categorize customizations
(load "misc.el")

;; TODO: add in other configuration files

;;;; End manual updates ;;;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(web-mode projectile tagedit rainbow-delimiters cider clojure-mode-extra-font-locking clojure-mode smex magit gruvbox-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
