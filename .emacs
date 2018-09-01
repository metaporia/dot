;; # Package Management
(require 'package)
(setq package-archives
      (append '(("melpa" . "https://melpa.org/packages/")
                ("gnu" . "https://elpa.gnu.org/packages/"))
	      package-archives))
;; ## List of packages to always have installed after startup.
(setq package-list '(company
                     ;;flycheck
                     magit
                     evil
                     evil-escape
                     evil-leader
                     evil-magit
                     linum-relative
                     company
                     rust-mode ;; rust major-mode
                     racer
                     org
                     ;company-mode
                     ;; consider 'avy for vimfx-like jumps
                     ))
;; see chris whosomebody's dotfiles
;; https://github.com/bitemyapp/dotfiles/blob/master/.emacs
(package-initialize)
;; rm -rf ~/.emacs.d/elpa to trigger (I think)
 (when (not package-archive-contents)
   (package-refresh-contents))

(dolist (package package-list)
  (when (not (package-installed-p package))
    (package-install package)))

(require 'magit)
(require 'evil-magit)
(require 'evil)
(require 'evil-escape)
(require 'evil-leader)
(global-evil-leader-mode)
(evil-leader/set-leader ",")
(evil-leader/set-key
  "w" 'save-buffer)

(define-key evil-insert-state-map (kbd "C-u")
(lambda ()
    (interactive)
    (if (looking-back "^" 0)
	(backward-delete-char 1)
    (if (looking-back "^\s*" 0)
	(delete-region (point) (line-beginning-position))
	(evil-delete (+ (line-beginning-position) (current-indentation)) (point))))))


(evil-mode 1)
(evil-escape-mode)
(setq-default evil-escape-key-sequence "jk")


(require 'linum-relative)
(linum-relative-mode)

(require 'rust-mode)
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))

(require 'company)
(define-key company-active-map(kbd "C-n") 'company-select-next-or-abort)
(define-key company-active-map (kbd "C-p") 'company-select-previous-or-abort)

(require 'racer)
(add-hook 'after-init-hook 'global-company-mode)
;;(require 'company-mode)
(add-hook 'rust-mode-hook #'company-mode)
(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'company-mode)
(define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common)
(setq company-tooltip-align-annotations t)

;;;; Org mode
(require 'org)
;; (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(setq org-todo-keywords
      ;; The "|" classifies workflow states. To its left lie unfinished states, and to
      ;; its right, finished states.
      ;;
      ;; "/" enables dependency enforcement.
      ;;
  '((sequence "TODO(t!)" "WAIT(w/!)" "|" "DONE(d!)" "CANCELLED(c@!)"))) 
(setq org-enforce-todo-dependencies t)
(setq org-log-done 'time)
(setq org-log-into-drawer t)

;; agenda bindings
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-switchb)



;; # general settings
(setq vc-follow-symlinks nil)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files (quote ("~/school/todo.org")))
 '(package-selected-packages (quote (magit intero))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
