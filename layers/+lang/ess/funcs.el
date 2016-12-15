(defun spacemacs/ess-start-repl ()
  "Start a REPL corresponding to the ess-language of the current buffer."
  (interactive)
  (cond
   ((string= "S" ess-language) (call-interactively 'R))
   ((string= "julia" ess-language) (call-interactively 'julia))
   ((string= "STA" ess-language) (call-interactively 'stata))
   ((string= "SAS" ess-language) (call-interactively 'SAS))))


;; lets shim this the right way...
;; shim ess-fundamental mode
(defvar ess-fundamental-mode-map
  (let ((ess-fundamental-mode-map (make-sparse-keymap)))
    (define-key ess-fundamental-mode-map (kbd "q")
      'ess-fundamental-kill-return)
    ess-fundamental-mode-map)

  "Keymap for shim ess mode")

;; initialize this variable just in case
(defvar ess-fundamental-source-buffer "")
(defvar ess-fundamental-mode-hook nil)
(defun ess-fundamental-mode ()
  "Shim mode just so we can hit 'q' to bail from ess-fundamental buffers"
  (interactive)
  (setq major-mode 'ess-fundamental-mode)
  (setq mode-name "ESS[Fundamental]")
  (run-hooks 'ess-fundamental-mode-hook)
  (use-local-map ess-fundamental-mode-map))


(defun ess-fundamental-kill-return ()
  (interactive)
  (let ((buf (current-buffer)))
    (kill-buffer buf)
    (set-window-configuration ess-fundamental-source-buffer)))

(defun ess-fundamental-set-source-buffer (&rest args)
  (setq ess-fundamental-source-buffer (current-window-configuration)))

