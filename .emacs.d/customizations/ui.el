; Initial window size.
;; TODO: dial this in better.
(setq initial-frame-alist
      '((top . 0) (left . 0) (width . 140) (height . 60)))

;; Turn off the menubar at the top of each frame.
;; menu-bar-mode -1)

;; Show line numbers.
(global-linum-mode)
(add-hook 'eshell-mode-hook 'nolinum)

;; Hide graphical toolbar at the top.
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))

;; Don't show native OS scroll bars for buffers.
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

;; Color themes.
(load-theme 'gruvbox-light-soft t)

;; Increase font size and face for better readability.
;; (set-face-attribute 'default nil :height 140)
(add-to-list 'default-frame-alist
	     '(font . "SauceCodePro Nerd Font-14:weight=normal"))

;; Full path in title bar
(setq-default frame-title-format "%b (%f)")

;; No bell.
(setq ring-bell-function 'ignore)

;; No cursor blinking
(blink-cursor-mode 0)


;;;;
;; Helm Configuration
;;;;

;; TODO: configure this as desired
;; TODO: this might need it's own dedicated file...
(require 'helm-config)
(helm-mode 1)

(define-key global-map [remap find-file] 'helm-find-files)
(define-key global-map [remap occur] 'helm-occur)
(define-key global-map [remap list-buffers] 'helm-buffers-list)
(define-key global-map [remap dabbrev-expand] 'helm-dabbrev)
(define-key global-map [remap execute-extended-command] 'helm-M-x)
(define-key global-map [remap apropos-command] 'helm-apropos)

(unless (boundp 'completion-in-region-function)
  (define-key lisp-interaction-mode-map [remap completion-at-point] 'helm-lisp-completion-at-point)
  (define-key emacs-lisp-mode-map       [remap completion-at-point] 'helm-lisp-completion-at-point))
(add-hook 'kill-emacs-hook #'(lambda () (and (file-exists-p "$CONF_FILE") (delete-file "$CONF_FILE"))))

(define-key helm-map (kbd "TAB") #'helm-execute-persistent-action)
(define-key helm-map (kbd "<tab>") #'helm-execute-persistent-action)
(define-key helm-map (kbd "C-z") #'helm-select-action)
