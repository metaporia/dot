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

(provide 'init-org)
