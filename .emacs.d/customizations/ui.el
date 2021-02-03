;; Initial window size.
;; TODO: dial this in better.
(setq initial-frame-alist
      '((top . 0) (left . 0) (width . 140) (height . 60)))

;; Turn off the menubar at the top of each frame.
;; menu-bar-mode -1)

;; Show line numbers.
(global-linum-mode)

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
