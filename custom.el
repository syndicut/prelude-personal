(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(org-directory "~/org")
 '(org-mobile-directory "~/Яндекс.Диск/MobileOrg")
 '(org-mobile-force-id-on-agenda-items nil)
 '(org-mobile-inbox-for-pull "~/org/from-mobile.org")
 '(org-todo-keyword-faces (quote (("WAITING" . "orange") ("SOMEDAY" . "yellow"))))
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