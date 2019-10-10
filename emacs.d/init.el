;;;; Managed Settings
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "ef98b560dcbd6af86fbe7fd15d56454f3e6046a3a0abd25314cfaaefd3744a9e" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "84d2f9eeb3f82d619ca4bfffe5f157282f4779732f48a5ac1484d94d5ff5b279" "62c81ae32320ceff5228edceeaa6895c029cc8f43c8c98a023f91b5b339d633f" "f27c3fcfb19bf38892bc6e72d0046af7a1ded81f54435f9d4d09b3bff9c52fc1" default)))
 '(haskell-process-type (quote stack-ghci))
 '(package-selected-packages
   (quote
    (ido-completing-read+ evil-collection intero ghc company-ghc haskell-mode solarized-theme smart-mode-line ## gruvbox-theme which-key helm elisp-slime-nav evil-indent-textobject evil-surround use-package evil-visual-mark-mode racer linum-relative evil-magit evil-leader evil-escape company)))
 '(sml/pre-modes-separator (propertize " " (quote face) (quote sml/modes))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(italic ((t (:slant italic)))))





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

;;;; Slime (lisp quality of life conf)
(use-package elisp-slime-nav
  :ensure t
  :config
  (defun my-hook ()
    (elisp-slime-nav-mode)
    (turn-on-eldoc-mode))
  (add-hook 'emacs-lisp-mode-hook 'my-hook))

;;;; Ido
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
  (ido-ubiquitous-mode 1)
  )

;;;; Helm
;;(use-package helm
;;  :ensure t
;;  :config
;;  (global-set-key (kbd "M-x") 'helm-M-x)
;;  )

;;;; Magit
(use-package magit
  :ensure t)


;; Dico wrapper
;; NB: ~/.emacs.d/config/init-evil.el depends on this.
(defun define-word-wrapped (word)
  "Read a word and pass it to dico(1)."
  (with-output-to-temp-buffer "*dico-define*"
    (shell-command (concat "d " word) "*dico-define*" "*Messages*")
  (pop-to-buffer "*dico-define*")))

(defun define-word ()
  (interactive)
  (define-word-wrapped (thing-at-point 'word () )))



;;;; Evil
;; NB: the below _must proceed_ magit, elisp-slime-nav.
(require 'init-evil)
(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

;;;; Company
(use-package company
  :ensure t
  :commands global-company-mode
  :config
  (add-hook 'after-init-hook 'global-company-mode)
  (define-key company-active-map(kbd "C-n") 'company-select-next-or-abort)
  (define-key company-active-map (kbd "C-p") 'company-select-previous-or-abort))

(use-package company-ghc
  :ensure t
  :config
  (add-to-list 'company-backends 'company-ghc)
  (autoload 'ghc-init "ghc" nil t)
  (autoload 'ghc-debug "ghc" nil t)
  (add-hook 'haskell-mode-hook (lambda () (ghc-init)))

  ;(add-hook
  )

;;;; Org
(require 'init-org)
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


;;;; which-key
;; TODO: Remove when sufficiently comfortable with emacs bindings.
;; Alternatively, leave it (as long as it bloats negligibly) and increase the
;; delay, so that it shows key-chord paths when the user delays (and therefore
;; probably wants assistance) and remains untriggered when chords are entered quickly.
(use-package which-key
  :ensure t
  :config
  (which-key-mode))

;;;; smart-mode-line

(use-package smart-mode-line
  :ensure t
  :config
  (setq sml/theme 'light)
  (sml/setup)
  (load-theme 'deeper-blue)
  )

;;(use-package solarized-theme
;;  :ensure t
;;  :config
;;  (setq sml/theme 'solarized)
;;  (sml/setup)
;;  )


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

(set-face-attribute 'default nil :height 80) ; 10pt

;;;; Miscellany

;; Helpful when facing the classic "end of file during parsing" error.
(defun paren-debug-mode ()
  (show-paren-mode t)
  (setq show-paren-style 'expression))


;;; Languages

;;;; Haskell

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


(put 'erase-buffer 'disabled nil)

;;(defun eshell-clear-buffer ()
;;  "Clear terminal"
;;  (interactive)
;;  (let ((inhibit-read-only t))
;;    (erase-buffer)
;;    (eshell-send-input)))
;;
;;(add-hook 'eshell-mode-hook
;;	  '(lambda()
;;	     (local-set-key (kbd "C-l") 'eshell-clear-buffer)))

