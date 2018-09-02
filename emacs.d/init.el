;;;; Package Management
(require 'package)
(package-initialize)
(setq package-enable-at-startup nil)

(add-to-list 'load-path (concat user-emacs-directory "config"))
	     
(setq package-archives
      (append '(("melpa" . "https://melpa.org/packages/")
		("gnu"   . "https://elpa.gnu.org/packages/"))
	      package-archives))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

;;;; Slime (lisp quality of life conf)
(use-package elisp-slime-nav
  :ensure t
  :config
  (defun my-hook ()
    (elisp-slime-nav-mode)
    (turn-on-eldoc-mode))
  (add-hook 'emacs-lisp-mode-hook 'my-hook))

;;;; Helm
(use-package helm
  :ensure t)

;;;; Magit
(use-package magit
  :ensure t)

;;;; Evil
(use-package evil
  :ensure t
  :config
  (evil-mode t)

  (define-key evil-insert-state-map (kbd "C-u")
    (lambda ()
      (interactive)
      (if (looking-back "^" 0)
	  (backward-delete-char 1)
      (if (looking-back "^\s*" 0)
	  (delete-region (point) (line-beginning-position))
          (evil-delete (+ (line-beginning-position) (current-indentation)) (point))))))

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
  
  ;;(use-package evil-indent-textobject ;; ? cool idea; horrid to use
  ;;  :ensure t))
  
;;;; Company
(use-package company
  :ensure t
  :commands global-company-mode
  :init
  (add-hook 'after-init-hook 'global-company-mode)
  :config
  (define-key company-active-map(kbd "C-n") 'company-select-next-or-abort)
  (define-key company-active-map (kbd "C-p") 'company-select-previous-or-abort))


;;;; Org
(use-package org
  :ensure t
  :config
  (setq org-todo-keywords
      ;; The "|" classifies workflow states. To its left lie unfinished states, and to
      ;; its right, finished states.
      ;;
      ;; "/" enables dependency enforcement.
      ;;
      (quote ((sequence "TODO(t!)" "NEXT(n!)" "|" "DONE(d!)")
	      (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@!)"))))

  (setq org-enforce-todo-dependencies t)
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
              ("j" "Journal" entry (file+datetree "~/org/diary.org")
               "* %?\n%U\n" :clock-in t :clock-resume t)
              ("w" "org-protocol" entry (file "~/org/refile.org")
               "* TODO Review %c\n%U\n" :immediate-finish t)
              ;;("m" "Meeting" entry (file "~/org/refile.org")
              ;; "* MEETING with %? :MEETING:\n%U" :clock-in t :clock-resume t)
              ("h" "Habit" entry (file "~/org/refile.org")
               "* NEXT %?\n%U\n%a\nSCHEDULED: %(format-time-string \"%<<%Y-%m-%d %a .+1d/3d>>\")\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: NEXT\n:END:\n"))))

  ;; refile setup

  ;; targets include agenda files up to depth=9
  (setq org-refile-targets (quote ((nil :maxlevel . 9)
				 (org-agenda-files :maxlevel . 9))))

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
  )


;;;; General Settings (i.e., post-installation conf)

;; UI
(setq visible-bell t)
(setq inhibit-startup-screen t)

(visual-line-mode t)
(tool-bar-mode -1) 
(menu-bar-mode -1)

(set-face-attribute 'default nil :height 105) ; 10pt


;;;; Managed Settings
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files (quote ("~/org/todo.org" "~/org/refile.org")))
 '(package-selected-packages
   (quote
    (helm elisp-slime-nav evil-indent-textobject evil-surround use-package evil-visual-mark-mode racer linum-relative evil-magit evil-leader evil-escape company))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
