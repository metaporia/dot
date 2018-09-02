;;;; Package Management
(require 'package)
(package-initialize)
(setq package-enable-at-startup nil)

(add-to-list 'load-path (concat user-emacs-directory "config"))
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
	     
(setq package-archives
      (append '(("melpa" . "https://melpa.org/packages/")
		("gnu"   . "https://elpa.gnu.org/packages/"))
	      package-archives))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

;;;; Themes
(use-package gruvbox-theme
  :ensure t
  :config
  (load-theme 'gruvbox-dark-hard)
  )

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
  :ensure t
  :config
  (global-set-key (kbd "M-x") 'helm-M-x)
  )

;;;; Magit
(use-package magit
  :ensure t)


;; Dico wrapper
;; NB: ~/.emacs.d/config/init-evil.el depends on this.
(defun define-word-helper (word)
  "Read a word and pass it to dico(1)."
  (with-output-to-temp-buffer "*dico-define*"
    (shell-command (concat "d " word) "*dico-define*" "*Messages*")
  (pop-to-buffer "*dico-define*")))

(defun define-word ()
  (interactive)
  (define-word-helper (thing-at-point 'word () )))


;;;; Evil
;; NB: the below _must proceed_ magit, elisp-slime-nav.
(require 'init-evil)

;;;; Company
(use-package company
  :ensure t
  :commands global-company-mode
  :init
  (global-company-mode)
  :config
  (define-key company-active-map(kbd "C-n") 'company-select-next-or-abort)
  (define-key company-active-map (kbd "C-p") 'company-select-previous-or-abort))


;;;; Org
(require 'init-org)


;;;; which-key
;; TODO: Remove when sufficiently comfortable with emacs bindings.
;; Alternatively, leave it (as long as it bloats negligibly) and increase the
;; delay, so that it shows key-chord paths when the user delays (and therefore
;; probably wants assistance) and remains untriggered when chords are entered quickly.
(use-package which-key
  :ensure t
  :config
  (which-key-mode))

;;;; General Settings (i.e., post-installation conf)

;; UI

;;(setq visible-bell t)
(setq ring-bell-function 'ignore)
(setq inhibit-startup-screen t
      inhibit-startup-message t
      inhibit-startup-echo-area-message t)
(when (boundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

(setq vc-follow-symlinks t)
    

(visual-line-mode t)
(tool-bar-mode -1) 
(menu-bar-mode -1)

(set-face-attribute 'default nil :height 105) ; 10pt

;;;; Miscellany

;; Helpful when facing the classic "end of file during parsing" error.
(defun paren-debug-mode ()
  (show-paren-mode t)
  (setq show-paren-style 'expression))




;;;; Managed Settings
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("62c81ae32320ceff5228edceeaa6895c029cc8f43c8c98a023f91b5b339d633f" "f27c3fcfb19bf38892bc6e72d0046af7a1ded81f54435f9d4d09b3bff9c52fc1" default)))
 '(org-agenda-files (quote ("~/org/todo.org" "~/org/refile.org")))
 '(package-selected-packages
   (quote
    (gruvbox-theme which-key helm elisp-slime-nav evil-indent-textobject evil-surround use-package evil-visual-mark-mode racer linum-relative evil-magit evil-leader evil-escape company))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
