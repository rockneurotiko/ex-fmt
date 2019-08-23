# Elixir Formatter on Emacs

Right now the library is not on MELPA, so you can do something like this:

- Clone this repository where you want

- Add this to your configuration
``` elisp
(defun ex-fmt-load ()
    (add-to-list 'load-path "~/path/ex-fmt")
    (load-file "/full/path/ex-fmt/ex-fmt.el")
    (require 'ex-fmt)

    ;; Optional, if you want to use always an specific mix version
    (setq ex-fmt-mix "/path/to/your/elixir/1.7/bin/mix")

    (add-hook 'after-save-hook #'ex-fmt-after-save))

(ex-fmt-load)
```

Now when you save some elixir file it will be auto formatted.
