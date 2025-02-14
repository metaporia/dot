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

(set-face-attribute 'default nil :height 140)
(set-face-attribute 'mode-line nil :height 140)



(savehist-mode) ;; save command history

(defun tangle-and-reload ()
  "Tangle org config and reload init.el"
  (interactive)
  (org-babel-tangle-file "~/.emacs.d/configuration.org")
  (load-file user-init-file)
  )

(evil-leader/set-key "xr" 'tangle-and-reload)

(use-package helpful :ensure t
  :bind (
         ("C-h v" . helpful-variable)
         ("C-h k" . helpful-key)
         ("C-h x" . helpful-command)
         ("C-h f" . helpful-callable)
         )
  )

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
  (setq ido-ignore-buffers '("^ " "*Completions*" "*Shell Command Output*"
                             "*Messages*" "Async Shell Command"))
  (setq ido-everywhere t)
  (setq ido-enable-flex-matching t)
                                        ; Use the current window when visiting files and buffers with ido
  (setq ido-default-file-method 'selected-window)
  (setq ido-virtual-buffers t)
  (setq ido-default-buffer-method 'selected-window)
                                        ; Use the current window for indirect buffer display
                                        ;(setq org-indirect-buffer-display 'current-window)
  )
(use-package ido-completing-read+ :ensure t :requires ido
  :init
  (ido-ubiquitous-mode t)
  )
;;(use-package ido-ubiquitous :ensure t :requires ido :config (ido-ubiquitous-mode 1))

(defun define-word-wrapped (word)
  "Read a word and pass it to dico(1)."
  (with-output-to-temp-buffer "*dico-define*"
    (shell-command (concat "d " word) "*dico-define*" "*Messages*")
  (pop-to-buffer "*dico-define*")))

(defun define-word ()
  (interactive)
  (define-word-wrapped (thing-at-point 'word () )))

(use-package evil-leader
  :ensure t
  :init
  (setq evil-want-keybinding nil)
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

(use-package evil
  :after evil-leader

  :ensure t
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-delete t)
  (setq evil-want-C-u-scroll t)
  (setq evil-undo-system 'undo-redo)
  (setq evil-want-C-i-jump t)
  :config
  (evil-mode t)

  ;;(setq evil-emacs-state-modes (delq 'ibuffer-mode evil-emacs-state-modes))

  ;;(setq evil-emacs-state-modes (delq 'completion-list-mode evil-emacs-state-modes))


  ;; (define-key evil-insert-state-map (kbd "C-u")
  ;;             (lambda ()
  ;;               (interactive)
  ;;               (if (looking-back "^" 0)
  ;;                   (backward-delete-char 1)
  ;;                 (if (looking-back "^\s*" 0)
  ;;                     (delete-region (point) (line-beginning-position))
  ;;                   (evil-delete (+ (line-beginning-position) (current-indentation)) (point))))))

  (define-key evil-normal-state-map (kbd "C-k") 'evil-delete-buffer)
  ;;(define-key evil-org-mode-map (kbd "TAB") 'evil-delete-buffer)

  ;; slime-nav documentation lookup
  (evil-define-key 'normal emacs-lisp-mode-map (kbd "K")
    'elisp-slime-nav-describe-elisp-thing-at-point)
  )

(use-package evil-escape
  :after evil
  :ensure t
  :config
  (evil-escape-mode)
  (setq-default evil-escape-key-sequence "jk"))



(use-package evil-surround
  :after evil
  :ensure t
  :config
  (global-evil-surround-mode))

(use-package evil-collection
  :after evil
  :init
  (setq evil-want-keybinding nil)
  ;;(setq evil-collection-want-company-extended-keybindings t)
  :ensure t
  :config
  (evil-collection-init))

(use-package corfu
  :after evil
  :ensure t
  :custom
  ;; Enable cycling for `corfu-next/previous'
  (corfu-cycle t)
  (corfu-count 14)
  (corfu-scroll-margin 4)
  (corfu-preselect-first t)
  ;; (corfu-preview-current t)
  :init
  ;;(corfu-popupinfo-mode) ;; show doc previews
  (global-corfu-mode)


  ;; unbind org tab
  :config
  (evil-define-key 'insert 'org-mode-map (kbd "TAB") nil)
  (evil-define-key nil 'evil-insert-state-map (kbd "TAB") nil)
  (evil-define-key 'insert 'evil-org-mode (kbd "TAB") #'completion-at-point)
  (define-key evil-insert-state-map (kbd "C-n")  #'completion-at-point)
  (define-key evil-insert-state-map (kbd "C-e")  #'corfu-complete)
  )

;; Enable Corfu completion UI
;; See the Corfu README for more configuration tips.
(use-package corfu
  :init
  (global-corfu-mode))


;; A few more useful configurations...
(use-package emacs
  :custom
  ;; TAB cycle if there are only few candidates
  ;; (completion-cycle-threshold 3)

  ;; Enable indentation+completion using the TAB key.
  ;; `completion-at-point' is often bound to M-TAB.
  (tab-always-indent 'complete)

  ;; Emacs 30 and newer: Disable Ispell completion function.
  ;; Try `cape-dict' as an alternative.
  (text-mode-ispell-word-completion nil)


  ;; Hide commands in M-x which do not apply to the current mode.  Corfu
  ;; commands are hidden, since they are not used via M-x. This setting is
  ;; useful beyond Corfu.
  (read-extended-command-predicate #'command-completion-default-include-p))

;; Add extensions
(use-package cape
  :ensure t
  ;; Bind prefix keymap providing all Cape commands under a mnemonic key.
  ;; Press C-c p ? to for help.
  :bind ("C-c p" . cape-prefix-map) ;; Alternative keys: M-p, M-+, ...
  ;; Alternatively bind Cape commands individually.
  ;; :bind (("C-c p d" . cape-dabbrev)
  ;;        ("C-c p h" . cape-history)
  ;;        ("C-c p f" . cape-file)
  ;;        ...)
  :init
  ;; Add to the global default value of `completion-at-point-functions' which is
  ;; used by `completion-at-point'.  The order of the functions matters, the
  ;; first function returning a result wins.  Note that the list of buffer-local
  ;; completion functions takes precedence over the global list.
  (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'cape-elisp-block)
  ;; (add-hook 'completion-at-point-functions #'cape-history)
  ;; ...
  )

(use-package kind-icon
  :ensure t
  :after corfu
  :custom
  (kind-icon-blend-background t)
  (kind-icon-default-face 'corfu-default) ; only needed with blend-background
  :config
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

(setq initial-buffer-choice "~/org/todo.org")

(defun paren-debug-mode ()
  (show-paren-mode t)
  (setq show-paren-style 'expression))

(setq vc-follow-symlinks t)

(display-line-numbers-mode)
(setq display-line-numbers 'relative)

;; (se-package linum-relative :ensure t
 ;;  :init
 ;;  ;; Use `display-line-number-mode` as linum-mode's backend for smooth performance
 ;;  (setq linum-relative-backend 'display-line-numbers-mode)
 ;;  :config
 ;;  (linum-relative-mode)
 ;;  )

(use-package color-theme-sanityinc-tomorrow
  :ensure t
  :config
  (load-theme 'sanityinc-tomorrow-night t))

(use-package smart-mode-line
  :ensure t
  :config
  (setq sml/theme 'dark)
  (sml/setup)
  ;(load-theme 'deeper-blue) ; uncomment to set dark blue theme
  )

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

;; display remote inline images
(setq org-display-remote-inline-images 'download)

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

(use-package xenops
  :ensure t
  :config 
  (setq xenops-math-image-scale-factor 1.8)
  :hook
  ((latex-mode . xenops-mode)
   (LaTeX-mode . xenops-mode))
  )

(use-package org-download :ensure t
  :after evil-leader
  :init
  (evil-leader/set-key "ld" 'org-download-yank)
  )

(use-package pandoc-mode
  ;; init (add-hook 'markdown-mode-hook 'pandoc-mode)
  :ensure t
  )

(use-package pdf-tools
  :ensure t
  :init
  (pdf-loader-install)
  )

(org-babel-do-load-languages 'org-babel-load-languages '( (shell . t)))

(use-package yasnippet
  :ensure t
  ;; :hook (
  ;;        ( text-mode
  ;;          progmode
  ;;          conf-mode
  ;;          snippet-mode) . yas-minor-mode-on
  ;;        )
:init 
(setq yas-snippet-dir "~/.emacs.d/snippets")
(setq yas-prompt-functions '(yas-ido-prompt))
:config
(yas-reload-all)
(yas-global-mode 1))

;; (yas-reload-all)
;; (add-hook 'after-init-hook #'yas-minor-mode)
(use-package  yasnippet-snippets :ensure t)
