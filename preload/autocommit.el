;; Automatically add, commit, and push when files change.
 
(defvar autocommit-dir-set '()
  "Set of directories for which there is a pending timer job")
 
(defun autocommit-schedule-commit (dn)
  "Schedule an autocommit (and push) if one is not already scheduled for the given dir."
  (if (null (member dn autocommit-dir-set))
      (progn
       (run-with-idle-timer
        10 nil
        (lambda (dn)
          (setq autocommit-dir-set (remove dn autocommit-dir-set))
          (message (concat "Committing org files in " dn))
          (shell-command (concat "cd " dn " && git commit -m 'Updated org files.'"))
          (shell-command (concat "cd " dn " && nohup git push & /usr/bin/true")))
        dn)
       (setq autocommit-dir-set (cons dn autocommit-dir-set)))))
 
(defun autocommit-after-save-hook ()
  "After-save-hook to 'git add' the modified file and schedule a commit and push in the idle loop."
  (let ((fn (buffer-file-name)))
    (message "git adding %s" fn)
    (shell-command (concat "git add " fn))
    (shell-command (concat "git add " fn "_archive"))
    (autocommit-schedule-commit (file-name-directory fn))))
 
(defun autocommit-setup-save-hook ()
  "Set up the autocommit save hook for the current file."
  (interactive)
  (message "Set up autocommit save hook for this buffer.")
  (add-hook 'after-save-hook 'autocommit-after-save-hook nil t))

(add-hook 'after-save-hook 'autocommit-after-save-hook nil t)
