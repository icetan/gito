(defun gito-sync ()
  (shell-command "gito sync"))

(defun gito-enable ()
  (interactive)
  (global-auto-revert-mode 1)
  (setq auto-revert-interval 0.5)
  (add-hook 'after-save-hook 'gito-sync))

(defun gito-disable ()
  (interactive)
  (global-auto-revert-mode -1)
  (setq auto-revert-interval 5) ;; default value
  (remove-hook 'after-save-hook 'gito-sync))
