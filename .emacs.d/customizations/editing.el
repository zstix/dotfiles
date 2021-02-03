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
