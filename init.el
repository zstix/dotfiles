(setq vc-follow-symlinks t)
(org-babel-load-file
 (expand-file-name
  "config.org"
  user-emacs-directory))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(ag git-gutter-fringe erc-hl-nicks eterm-256color prettier-js undo-tree cmake-mode vterm yaml-mode atom-one-dark-theme helm company evil-leader dracula-theme evil-escape evil-escape-mode evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-block ((t (:background "#1e1e2a")))))
