;; Use "cmd" for "meta" on OSX.
(setq mac-option-key-is-meta nil
      mac-command-key-is-meta t
      mac-command-modifier 'meta
      mac-option-modifier 'none)

;; Set up killing / yanking to work with the system clipboard.
(setq x-select-enable-clipboard t
      save-interprogram-paste-before-kill t
      mouse-yank-at-point t)

;; Ensure we are using the right path for terminal shells.
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-envs
   '("PATH")))

