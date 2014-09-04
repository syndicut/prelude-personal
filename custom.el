(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(org-agenda-files (quote ("~/org/todo.org")))
 '(org-directory "~/org")
 '(org-mobile-directory "~/Яндекс.Диск/MobileOrg")
 '(org-mobile-force-id-on-agenda-items nil)
 '(org-mobile-inbox-for-pull "~/org/from-mobile.org")
 '(org-modules (quote (org-bbdb org-bibtex org-docview org-gnus org-info org-jsinfo org-habit org-irc org-mew org-mhe org-rmail org-vm org-wl org-w3m)))
 '(org-todo-keyword-faces (quote (("WAITING" . "orange") ("SOMEDAY" . "yellow") ("CANCELLED" . "blue"))))
 '(size-indication-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(add-to-list 'org-agenda-custom-commands
             '("u" "Unscheduled" todo ""
               ((org-agenda-todo-ignore-scheduled t))))
(add-to-list 'org-agenda-custom-commands
             '("I" "Import diary from iCal" agenda ""
                ((org-agenda-mode-hook
                  (lambda ()
                    (org-mac-iCal))))))
(add-to-list 'org-agenda-custom-commands
             '("W" "Weekly Review" agenda ""
               ((org-agenda-span 'week)
                (org-agenda-start-day "-7d")
                (org-agenda-tag-filter-preset '("+work" "-scheduled_routines")))))

;(add-hook 'org-after-todo-state-change-hook
;          '(lambda ()
             ;; remove the scheduled date/time if present as the activity is nolonger mine
             ;; based on a suggestion by Manish on the org-mode mailing list
;             (if (string= state "SOMEDAY") (org-schedule t))))

;; I use C-c c to start capture mode
(global-set-key (kbd "C-c c") 'org-capture)
;; Capture templates for: TODO tasks, Notes, appointments, phone calls, meetings, and org-protocol
(setq org-capture-templates
      (quote (("p" "personal" entry (file+olp "~/org/todo.org" "Личное")
               "* NEXT %?\nSCHEDULED: %t")
               ("w" "work" entry (file+olp "~/org/todo.org" "Работа")
               "* NEXT %?\nSCHEDULED: %t")
               ("b" "book" entry (file+olp "~/org/todo.org" "Личное")
               "* SOMEDAY %? :book:read:")
              )
      )
)

;; Always hilight the current agenda line
(add-hook 'org-agenda-mode-hook
          '(lambda () (hl-line-mode 1))
          'append)

(setq org-startup-indented t)

(setq org-reverse-note-order nil)
(setq org-treat-S-cursor-todo-selection-as-state-change nil)

; Targets include this file and any file contributing to the agenda - up to 9 levels deep
(setq org-refile-targets (quote ((nil :maxlevel . 9)
                                 (org-agenda-files :maxlevel . 9))))

; Use full outline paths for refile targets - we file directly with IDO
(setq org-refile-use-outline-path t)

; Targets complete directly with IDO
(setq org-outline-path-complete-in-steps nil)

; Allow refile to create parent tasks with confirmation
(setq org-refile-allow-creating-parent-nodes (quote confirm))

; Use IDO for both buffer and file completion and ido-everywhere to t
(setq org-completion-use-ido t)
(setq ido-everywhere t)
(setq ido-max-directory-size 100000)
(ido-mode (quote both))
; Use the current window when visiting files and buffers with ido
(setq ido-default-file-method 'selected-window)
(setq ido-default-buffer-method 'selected-window)
; Use the current window for indirect buffer display
(setq org-indirect-buffer-display 'current-window)

;;;; Refile settings
; Exclude DONE state tasks from refile targets
(defun bh/verify-refile-target ()
  "Exclude todo keywords with a done state from refile targets"
  (not (member (nth 2 (org-heading-components)) org-done-keywords)))

(setq org-refile-target-verify-function 'bh/verify-refile-target)

(setq org-show-following-heading t)
(setq org-show-hierarchy-above t)
(setq org-show-siblings (quote ((default))))

(setq org-special-ctrl-a/e t)
(setq org-special-ctrl-k t)
(setq org-yank-adjusted-subtrees t)

(setq org-use-speed-commands t)
(setq org-speed-commands-user (quote (("a" . ignore)
                                      ("d" . ignore)
                                      ("h" . bh/hide-other)
                                      ("i" progn
                                       (forward-char 1)
                                       (call-interactively 'org-insert-heading-respect-content))
                                      ("k" . org-kill-note-or-show-branches)
                                      ("l" . ignore)
                                      ("m" . ignore)
                                      ("q" . bh/show-org-agenda)
                                      ("r" . ignore)
                                      ("s" . org-save-all-org-buffers)
                                      ("w" . org-refile)
                                      ("x" . ignore)
                                      ("y" . ignore)
                                      ("z" . org-add-note)

                                      ("A" . ignore)
                                      ("B" . ignore)
                                      ("E" . ignore)
                                      ("F" . bh/restrict-to-file-or-follow)
                                      ("G" . ignore)
                                      ("H" . ignore)
                                      ("J" . org-clock-goto)
                                      ("K" . ignore)
                                      ("L" . ignore)
                                      ("M" . ignore)
                                      ("N" . bh/narrow-to-org-subtree)
                                      ("P" . bh/narrow-to-org-project)
                                      ("Q" . ignore)
                                      ("R" . ignore)
                                      ("S" . ignore)
                                      ("T" . bh/org-todo)
                                      ("U" . bh/narrow-up-one-org-level)
                                      ("V" . ignore)
                                      ("W" . bh/widen)
                                      ("X" . ignore)
                                      ("Y" . ignore)
                                      ("Z" . ignore))))

(defun bh/show-org-agenda ()
  (interactive)
  (if org-agenda-sticky
      (switch-to-buffer "*Org Agenda( )*")
    (switch-to-buffer "*Org Agenda*"))
  (delete-other-windows))

(global-set-key (kbd "M-s") 'bh/org-insert-sub-task)
(defun bh/org-insert-sub-task ()
  (interactive)
  (let ((parent-scheduled (org-get-scheduled-time nil)))
    (org-goto-sibling)
    (org-insert-todo-subheading t)
    (when parent-scheduled
      (org-schedule nil parent-scheduled))))

; Overwrite the current window with the agenda
(setq org-agenda-window-setup 'current-window)

(setq org-id-link-to-org-use-id 'create-if-interactive-and-no-custom-id)

(setq org-agenda-include-diary t)

 (add-hook 'org-agenda-cleanup-fancy-diary-hook
    (lambda ()
      (goto-char (point-min))
      (save-excursion
        (while (re-search-forward "^[a-z]" nil t)
    (goto-char (match-beginning 0))
    (insert "0:00-24:00 ")))
      (while (re-search-forward "^ [a-z]" nil t)
        (goto-char (match-beginning 0))
        (save-excursion
    (re-search-backward "^[0-9]+:[0-9]+-[0-9]+:[0-9]+ " nil t))
        (insert (match-string 0)))))

 (setq org-habit-graph-column 100)

 (defun org-todo-toggle-yesterday ()
  ;; this function is interactive, meaning a "command" that we call
  ;; as an emacs user (allows us to do "M-x org-todo-toggle-yesterday")
  (interactive)

  (let ((time-in-question (decode-time))) 
    ;; time-in-question is the current time, decoded into convenient fields

    ;; decrease the field by one which represents the day -- make it "yesterday"
    (decf (nth 3 time-in-question))

    ;; now, re-encode that time
    (setq time-in-question (apply 'encode-time time-in-question))

    (flet ((current-time () time-in-question))
      ;; flet temporarily binds current-time to this version, which
      ;; returns the time from yesterday 

      (org-todo)
      ;; toggles the todo heading
      )))
 
(setq org-agenda-span 'day)

(run-at-time "00:59" 3600 'org-save-all-org-buffers)

