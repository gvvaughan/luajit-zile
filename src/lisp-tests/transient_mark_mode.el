(transient-mark-mode)
(set-mark (point))
(forward-line)
(forward-line)
(insert "this")
(kill-region (point) (mark))
(insert "that")
(save-buffer)
(save-buffers-kill-emacs)
