; Indentation issues.
(setq js-indent-level 2)
(setq-default c-basic-offset 2)
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)

; Python 2 space
(add-hook 'python-mode-hook '(lambda () 
  (setq python-indent 2)))

; Disable *~ backup files.
(setq make-backup-files nil) 

; Ensure sass is executable.
(setq exec-path (cons (expand-file-name "~/.gem/ruby/1.8/bin") exec-path))

; Configure additional modes.
(add-to-list 'load-path (expand-file-name "~/.emacs.d/modes"))
(autoload 'haml-mode "haml-mode")
(add-hook 'haml-mode-hook
	  '(lambda ()
	     (setq indent-tabs-mode nil)
	     (define-key haml-mode-map "\C-m" 'newline-and-indent)))
(add-to-list 'auto-mode-alist '("\\.haml\\'" . haml-mode))
(add-to-list 'auto-mode-alist '("\\.hamljs\\'" . haml-mode))
(autoload 'scss-mode "scss-mode")
(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))

; Copies the first goog.provide'd namespace to the 'i' register.
(defun init-goog-provide ()
  (interactive)
  (save-excursion
    (search-forward-regexp "goog\\.provide('\\([a-zA-Z.]+\\)')")
    (copy-to-register ?i  (match-beginning 1) (match-end 1))
  ; (message (concat (int-to-string (match-beginning 1)) " " (int-to-string (match-end 1))))
  )
)

(add-hook 'js-mode-hook 'init-goog-provide)
(add-hook 'python-mode-hook '(lambda () (highlight-lines-matching-regexp ".\\{81\\}" "hi-yellow")))
(add-hook 'js-mode-hook '(lambda () (highlight-lines-matching-regexp ".\\{81\\}" "hi-yellow")))
(add-hook 'java-mode-hook '(lambda () (highlight-lines-matching-regexp ".\\{101\\}" "hi-yellow")))

(global-set-key (kbd "C-c j") (lambda () (interactive) (insert "/**\n *\n */")))

; Redonkulous eshell prompt.
(defmacro with-face (str &rest properties)
  `(propertize ,str 'face (list ,@properties)))

(defun shk-eshell-prompt ()
  (let ((header-bg "#fff"))
    (concat
     (with-face (concat (eshell/pwd) " ") :background header-bg)
     (with-face (format-time-string "(%Y-%m-%d %H:%M) " (current-time)) :background header-bg :foreground "#888")
     (with-face
      (or (ignore-errors (format "(%s)" (vc-responsible-backend default-directory))) "")
      :background header-bg)
     (with-face "\n" :background header-bg)
     (with-face user-login-name :foreground "blue")
     "@"
     (with-face "localhost" :foreground "green")
     (if (= (user-uid) 0)
         (with-face " #" :foreground "red")
       " $")
     " ")))
(setq eshell-prompt-function 'shk-eshell-prompt)
(setq eshell-highlight-prompt nil)