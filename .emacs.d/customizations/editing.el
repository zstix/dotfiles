;; Highlight matching parenthesis
(show-paren-mode 1)

;; Highlight current line.
(global-hl-line-mode 1)

;; Don't use hard tabs.
(setq-default indent-tabs-mode nil)

;; Put backup files in one location.
(setq backup-directory-alist `(("." . ,(concat user-emacs-directory
					       "backups"))))

;; Disable auto-saving.
(setq auto-save-default nil)

;; Comments
(defun toggle-comment-on-line ()
  "Comment or uncomment current line"
  (interactive)
  (comment-or-uncomment-region (line-beginning-position) (line-end-position)))

(global-set-key (kbd "C-;") 'toggle-comment-on-line)

;; Use 2 spaces for tabs, like a sane adult.
(defun die-tabs ()
  (interactive)
  (set-variable 'tab-width 2)
  (mark-whole-buffer)
  (untabify (region-begining) (region-end))
  (keyboard-quit))

(setq web-mode-markup-indent-offset 2
      web-mode-code-indent-offset 2
      web-mode-css-indent-offset 2
      indent-tabs-mode nil
      js-indent-level 2)

;; Completion in all buffers
(add-hook 'after-init-hook 'global-company-mode)

;; Typescript / JS
(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1))

;; aligns annotations to the right side
(setq company-tooltip-align-annotations t)

;; formats buffer before saving
(add-hook 'before-save-hook 'tide-format-before-save)

(add-hook 'js-mode-hook #'setup-tide-mode)
(add-hook 'js-mode-hook 'prettier-js-mode)


;;;;
;; Evil / Vim
;;;;

(require 'evil)
(evil-mode 1)

(require 'key-chord)
(setq key-chord-two-keys-delay 0.5)
(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
(key-chord-mode 1)
