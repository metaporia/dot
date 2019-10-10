(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  :config
  (evil-mode t)

  (setq evil-want-C-i-jump t)
  (setq evil-want-C-u-scroll t)

  (setq evil-emacs-state-modes (delq 'ibuffer-mode
				     ;; from:
				     evil-emacs-state-modes))
  
  (setq evil-emacs-state-modes (delq 'completion-list-mode
				     ;; from:
				     evil-emacs-state-modes))
				     
  (define-key evil-insert-state-map (kbd "C-u")
    (lambda ()
      (interactive)
      (if (looking-back "^" 0)
	  (backward-delete-char 1)
      (if (looking-back "^\s*" 0)
	  (delete-region (point) (line-beginning-position))
          (evil-delete (+ (line-beginning-position) (current-indentation)) (point))))))
  (define-key evil-normal-state-map (kbd "C-k") 'evil-delete-buffer)

  ; slime-nav documentation lookup
  (evil-define-key 'normal emacs-lisp-mode-map (kbd "K")
    'elisp-slime-nav-describe-elisp-thing-at-point)

  (use-package evil-escape
    :ensure t
    :config
    (evil-escape-mode)
    (setq-default evil-escape-key-sequence "jk"))
  
  (use-package evil-leader
    :ensure t
    
    :config
    (progn
	(evil-leader/set-leader ",")
	;; other leader bindings (?)
	(evil-leader/set-key
	  "w" 'save-buffer
	  "," 'other-window
	  "h" 'dired-jump ;; tentative
	  "e" 'pp-eval-last-sexp
	  "b" 'ibuffer ;; tentative
	  "d" 'define-word
	  "x" 'helm-M-x)
	)
    (global-evil-leader-mode))
  
  (use-package evil-surround
    :ensure t
    :config
    (global-evil-surround-mode))

  (use-package evil-magit
    :ensure t)
  )

(provide 'init-evil)
