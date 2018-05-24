(defun gito-sync ()
  (shell-command "gito sync"))

(defun gito-enable ()
  (global-auto-revert-mode 1)
  (setq auto-revert-interval 0.5)
  (add-hook 'after-save-hook 'gito-sync))

(defun gito-disable ()
  (global-auto-revert-mode -1)
  (setq auto-revert-interval 5)
  (remove-hook 'after-save-hook 'gito-sync))
