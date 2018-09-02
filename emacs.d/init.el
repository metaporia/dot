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

;;;; General Settings (i.e., post-installation conf)

;; UI

;;(setq visible-bell t)
(setq ring-bell-function 'ignore)
(setq inhibit-startup-screen t
      inhibit-startup-message t
      inhibit-startup-echo-area-message t)
(when (boundp 'scroll-bar-mode)
  (scroll-bar-mode -1)

(setq vc-follow-symlinks t)
    

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
