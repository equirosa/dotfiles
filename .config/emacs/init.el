;; Sane defaults
(require 'iso-transl) ;; allow some keys (mainly accents in spanish)
(set-face-attribute 'default nil :height 120)
(load-theme 'doom-gruvbox t) ;; load preferred theme
(global-visual-line-mode t) ;; add visual line wrapping
(setq
 gc-cons-threshold 100000000
 read-process-output-max (* 1024 1024) ;; 1mb
 lsp-completion-provider :capf
 lsp-idle-delay 0.500) ; increase gc threshold

;; Prioritise UTF-8
(set-charset-priority 'unicode)
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(setq default-process-coding-system '(utf-8-unix . utf-8-unix))

;; Turn off autosave
(setq
 make-backup-files nil
 auto-save-default nil
 create-lockfiles nil)

;; Visuals
(ignore-errors (set-frame-font "Fira Code-12"))
(doom-modeline-mode)
(setq doom-challenger-deep-brighter-comments t
      doom-challenger-deep-brighter-modeline t)
(show-paren-mode)
(electric-pair-mode)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode) ;; Use rainbow delimiters in programming mode
(global-fira-code-mode)

;; All The Icons
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)

;; Org stuff
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

;; org-brain
(setq org-brain-path "/home/eduardo/Documents/org"
      org-id-track-globally t
      org-id-locations-file "~/.emacs.d/.org-id-locations"
      org-brain-visualize-default-choices 'all
      org-brain-title-max-length 12
      org-brain-include-file-entries nil
      org-brain-file-entries-use-title nil)


;; Window stuff
(when (window-system)
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (tooltip-mode -1))
