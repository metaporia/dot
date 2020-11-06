(setq-default custom-file "~/.emacs.d/custom.el")
(when (file-exists-p custom-file)
    (load custom-file))

(setq ring-bell-function 'ignore 
      inhibit-startup-screen t
      inhibit-startup-message t
      inhibit-startup-echo-area-message t)

(when (display-graphic-p)
      (blink-cursor-mode -1)
      (scroll-bar-mode -1)
      (tool-bar-mode -1))

(menu-bar-mode -1)
(visual-line-mode t)

(set-face-attribute 'default nil :height 83)

(set-frame-font "-CYEL-Iosevka-normal-normal-normal-*-*-*-*-*-d-0-iso10646-1")

(use-package elisp-slime-nav
  :ensure t
  :config
  (defun my-hook ()
    (elisp-slime-nav-mode)
    (turn-on-eldoc-mode))
  (add-hook 'emacs-lisp-mode-hook 'my-hook))

(use-package ido
  :config
  (ido-mode t)
  (setq ido-everywhere t)
  (setq ido-enable-flex-matching t)
  ; Use the current window when visiting files and buffers with ido
  (setq ido-default-file-method 'selected-window)
  (setq ido-default-buffer-method 'selected-window)
  ; Use the current window for indirect buffer display
  ;(setq org-indirect-buffer-display 'current-window)
  (require 'ido-completing-read+)
  (ido-ubiquitous-mode 1))

(defun define-word-wrapped (word)
  "Read a word and pass it to dico(1)."
  (with-output-to-temp-buffer "*dico-define*"
    (shell-command (concat "d " word) "*dico-define*" "*Messages*")
  (pop-to-buffer "*dico-define*")))

(defun define-word ()
  (interactive)
  (define-word-wrapped (thing-at-point 'word () )))

(use-package company
  :ensure t
  :commands global-company-mode
  :config
  (add-hook 'after-init-hook 'global-company-mode)
  (define-key company-active-map(kbd "C-n") 'company-select-next-or-abort)
  (define-key company-active-map (kbd "C-p") 'company-select-previous-or-abort))

(setq initial-buffer-choice "~/org/todo.org")

(defun paren-debug-mode ()
  (show-paren-mode t)
  (setq show-paren-style 'expression))

(setq vc-follow-symlinks t)

(use-package color-theme-sanityinc-tomorrow
  :ensure t
  :config
  (color-theme-sanityinc-tomorrow-bright))

(use-package smart-mode-line
  :ensure t
  :config
  (setq sml/theme 'dark)
  (sml/setup)
  ;(load-theme 'deeper-blue) ; uncomment to set dark blue theme
  )

(use-package undo-tree :ensure t)

(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  :config
  (evil-mode t)

  (setq evil-want-C-i-jump t)

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
	  "d" 'define-word)
	)
    (global-evil-leader-mode))
  
  (use-package evil-surround
    :ensure t
    :config
    (global-evil-surround-mode))

  (use-package evil-magit
    :ensure t)
  )

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package haskell-mode
  :ensure t
  :config
  ;; bindings
  ;;(define-key haskell-mode-map (kbd "C-c C-t") 'haskell-process-do-type)
  ;;(define-key haskell-mode-map (kbd "C-c C-i") 'haskell-do-info)
  ;; (define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-or-reload)

  ;; tags
  (setq haskell-tags-on-save t)
  )

;; intero
(use-package intero
  :ensure t
  :config
  (define-key intero-mode-map (kbd "M-.") 'intero-goto-definition)
  (define-key intero-mode-map (kbd "<f8>") 'haskell-navigate-imports)
  ;(define-key intero-repl-mode-map (kbd "C-l") 'intero-repl-clear-buffer)
  (define-key intero-repl-mode-map (kbd "C-l") 'recenter-top-bottom)

  (defun codex-update ()
    (when (eq major-mode 'intero-mode)
      (async-shell-command  "codex update")
      ))

  (add-hook 'haskell-mode-hook 'intero-mode)
  (add-hook 'after-save-hook 'codex-update)
  (add-hook 'haskell-mode-hook 'linum-relative-mode)
  )

;; hoogle
(defun hoogle-search (term)
  "Search for given string in hoogle."
  (with-output-to-temp-buffer "*hoogle-search*"
    (shell-command (concat "stack hoogle search -- " term) "*hoogle-search*" "*Messages*")
  (pop-to-buffer "*hoogle-search*")))

(defun hoogle-info (term)
  "Search for given string in hoogle. Return documentation of first match."
  (with-output-to-temp-buffer "*hoogle-info*"
    (shell-command (concat "stack hoogle search -- -i " term) "*hoogle-info*" "*Messages*")
  (pop-to-buffer "*hoogle-info*")))

(defun hoogle-search-interactive ()
  (interactive)
  (hoogle-search (thing-at-point 'word () )))



(defun hoogle-info-interactive ()
  (interactive)
  (hoogle-info (thing-at-point 'word () )))

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

(use-package magit :ensure t)

(setq org-agenda-files '("~/org" "~/.emacs.d/configuration.org"))
(setq org-directory "~/org")
(setq org-agenda-dim-blocked-tasks nil)

; enable org-indent-mode by default
(setq org-startup-indented t)
(setq org-cycle-separator-lines 0)
(setq org-deadline-warning-days 20)
(setq org-alphabetical-lists t)

(setq org-list-allow-alphabetical t)
(setq org-fast-tag-selection-single-key t)

(setq org-tag-alist '(("code" . ?c)
		      ("meta" . ?m)
		      ("note" . ?n)
		      ("personal" . ?p)
		      ("school" . ?s)
                  ("music" . ?u)
                  ))

(setq org-todo-keywords
    ;; The "|" classifies workflow states. To its left lie unfinished states, and to
    ;; its right, finished states.
    ;;
    ;; "/" enables dependency enforcement.
    ;;
    (quote ((sequence "TODO(t!)" "NEXT(n!)" "|" "DONE(d!)")
	    (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@!)"))))

(setq org-enforce-todo-dependencies t)
(setq org-enforce-todo-checkbox-dependencies t)
(setq org-log-done 'time)
(setq org-log-into-drawer t)

(setq org-todo-state-tags-triggers
    (quote (("CANCELLED" ("CANCELLED" . t))
            ("WAITING" ("WAITING" . t))
            ("HOLD" ("WAITING") ("HOLD" . t))
            (done ("WAITING") ("HOLD"))
            ("TODO" ("WAITING") ("CANCELLED") ("HOLD"))
            ("NEXT" ("WAITING") ("CANCELLED") ("HOLD"))
            ("DONE" ("WAITING") ("CANCELLED") ("HOLD")))))

;; Capture templates for: TODO tasks, Notes, appointments, phone calls, meetings, and org-protocol
(setq org-capture-templates
    (quote (("t" "todo" entry (file "~/org/refile.org")
             "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)
            ("r" "respond" entry (file "~/org/refile.org")
             "* NEXT Respond to %:from on %:subject\nSCHEDULED: %t\n%U\n%a\n" :clock-in t :clock-resume t :immediate-finish t)
            ("n" "note" entry (file "~/org/refile.org")
             "* %? :NOTE:\n%U\n%a\n" :clock-in t :clock-resume t)
            ("j" "journal" entry (file+datetree "~/org/diary.org")
             "* %?\n%U\n" :clock-in t :clock-resume t)
            ("w" "org-protocol" entry (file "~/org/refile.org")
             "* TODO Review %c\n%U\n" :immediate-finish t)
            ;;("m" "Meeting" entry (file "~/org/refile.org")
            ;; "* MEETING with %? :MEETING:\n%U" :clock-in t :clock-resume t)
            ("h" "habit" entry (file "~/org/refile.org")
             "* NEXT %?\n%U\n%a\nSCHEDULED: %(format-time-string \"%<<%Y-%m-%d %a .+1d/3d>>\")\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: NEXT\n:END:\n"))))

;; refile setup



;; targets include agenda files up to depth=9
(setq org-refile-targets (quote ((nil :maxlevel . 9)
			       (org-agenda-files :maxlevel . 9))))

(setq org-refile-use-outline-path 'file)
(setq org-outline-path-complete-in-steps nil)

;; allow parent creation
(setq org-refile-allow-creating-parent-nodes (quote confirm))

;; ido
;;(setq org-completion-use-ido t)

; Exclude DONE state tasks from refile targets
(defun bh/verify-refile-target ()
    "Exclude todo keywords with a done state from refile targets"
    (not (member (nth 2 (org-heading-components)) org-done-keywords)))

(setq org-refile-target-verify-function 'bh/verify-refile-target)

;; agenda bindings
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-switchb)

(use-package evil-org
  :ensure t
  :after org
  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook
	    (lambda ()
	      (evil-org-set-key-theme)))
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

(setq org-format-options (plist-put org-format-latex-options :scale 2.0))
(setq org-latex-create-formula-image-program 'dvisvgm)

(setq doc-view-resolution 300)
;; shrink high-res image to appropriate size

;; FIXME these are interactive functions, dummy. The resolution fix
;;is unaffected by there abscence however

;;(doc-view-fit-page-to-window)
;;(doc-view-fit-height-to-window) (doc-view-fit-width-to-window)
