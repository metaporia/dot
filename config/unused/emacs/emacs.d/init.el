;;;; Package Management

;; Enable package management with ='package=. By default do /not/
;; activate installed packages at startup.
(require 'package)
(setq package-enable-at-startup nil)

;; Declare intent to manually control package loading with
;; =use-package=.
(package-initialize)

;; Add package registries.
(setq package-archives
      (append '(("melpa" . "https://melpa.org/packages/")
		("gnu"   . "https://elpa.gnu.org/packages/"))
	      package-archives))

;; If ='use-package= is not present, update package archives and
;; install ='use-package=.
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(use-package org :ensure t)

;; Load org config 
(org-babel-load-file (expand-file-name "configuration.org" user-emacs-directory))



;;;; General Configuration

(add-to-list 'load-path (concat user-emacs-directory "config"))
;; Enable to manually install themes
;; (add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
	     
;;;; Evil
;;(require 'init-evil)

;;;; Company

;;(use-package company-ghc
;;  :ensure t
;;  :config
;;  (add-to-list 'company-backends 'company-ghc)
;;  (autoload 'ghc-init "ghc" nil t)
;;  (autoload 'ghc-debug "ghc" nil t)
;;  (add-hook 'haskell-mode-hook (lambda () (ghc-init)))
;;
;;  ;(add-hook
;;  )

;;;; Remainder of General Settings

;; idk what this was for
;; (put 'erase-buffer 'disabled nil)

