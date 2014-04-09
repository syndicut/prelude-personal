    (add-hook 'calendar-load-hook
              (lambda ()
                (calendar-set-date-style 'european)))
   (setq
    calendar-week-start-day 1)
