(setq default-cursor-type 'bar)
(setq prelude-whitespace nil)
(set-default-font "Menlo 16")
(setq org-agenda-files (list "~/org/todo.org"))
(find-file "~/org/todo.org")
(setq org-agenda-overriding-columns-format "%TODO %3PRIORITY %5Effort(TIME){:} %80ITEM(Task)" )