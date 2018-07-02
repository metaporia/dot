;; # Package Management
(require 'package)
(setq package-archives
      (append '(("melpa" . "http://stable.melpa.org/packages/"))
	      package-archives))
;; ## List of packages to always have installed after startup.
(setq package-list '(company
                     ;;flycheck
                     company
                     magit
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

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (magit intero))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
