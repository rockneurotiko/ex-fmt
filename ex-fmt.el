(defvar ex-fmt-version "0.1.0", "Elixir Formatter Version")

(defvar ex-fmt-elixir nil "Path of elixir bin")

(defvar ex-fmt-mix nil "Path of mix bin")

(defun ex-fmt--execute (command)
  (shell-command-to-string command))

(defun ex-fmt--format-code (codepath)
  (ex-fmt--execute (format "%s %s format %s" ex-fmt-elixir ex-fmt-mix codepath)))

(defun ex-fmt--format-current-buffer ()
  (ex-fmt--format-code buffer-file-name))

;;;###autoload
(defun ex-fmt-before-save ()
  (interactive)
  (when (eq major-mode 'elixir-mode) (ex-fmt--format-current-buffer)))

;; (add-hook 'before-save-hook #'ex-fmt-before-save)

(provide 'ex-fmt)
