(defvar ex-fmt-version "0.1.0", "Elixir Formatter Version")

(defvar ex-fmt-elixir nil "Path of elixir bin")

(defvar ex-fmt-mix nil "Path of mix bin")

(defun ex-fmt--execute (command)
  (shell-command-to-string command))

(defun ex-fmt--format-code (codepath)
  (let* ((cfgpath (ex-fmt--find-file-in-hierarchy "." ".formatter.exs"))
         (cmd (if cfgpath
                  (format "%s %s format --dot-formatter %s %s" ex-fmt-elixir ex-fmt-mix cfgpath codepath)
                (format "%s %s format %s" ex-fmt-elixir ex-fmt-mix codepath)))
         (cfg-directory (file-name-directory cfgpath))
         (previously-directory default-directory))

    (setq default-directory cfg-directory)
     (ex-fmt--execute cmd)
     (setq default-directory previously-directory)))

(defun ex-fmt--format-current-buffer ()
  (interactive)
  (when (and (not (eq nil ex-fmt-elixir)) (not (eq nil ex-fmt-mix)))
    (ex-fmt--format-code buffer-file-name)
    (revert-buffer :ignore-auto :noconfirm)))

;; From http://stackoverflow.com/questions/14095189/walk-up-the-directory-tree
(defun ex-fmt--parent-directory (dir)
  "Go to the parent directory of `DIR' unless it's /."
  (unless (equal "/" dir)
    (file-name-directory (directory-file-name dir))))

(defun ex-fmt--find-file-in-hierarchy (current-dir fname)
  "Starting from `CURRENT-DIR', search for a file named `FNAME' upwards through the directory hierarchy."
  (let ((file (concat current-dir fname))
        (parent (ex-fmt--parent-directory (expand-file-name current-dir))))
    (if (file-exists-p file)
        file
      (when parent
        (ex-fmt--find-file-in-hierarchy parent fname)))))

;;;###autoload
(defun ex-fmt-after-save ()
  (interactive)
  (when (eq major-mode 'elixir-mode)
    (ex-fmt--format-current-buffer)))

;; (add-hook 'after-save-hook #'ex-fmt-after-save)

(provide 'ex-fmt)
