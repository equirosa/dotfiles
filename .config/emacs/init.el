(require 'iso-transl) ;; allow some keys (mainly accents in spanish)
(set-face-attribute 'default nil :height 120)
(load-theme 'doom-gruvbox t) ;; load preferred theme
(global-visual-line-mode t) ;; add visual line wrapping
(setq gc-cons-threshold 100000000) ; increase gc threshold
(setq read-process-output-max (* 1024 1024)) ;; 1mb
(setq lsp-completion-provider :capf)
(setq lsp-idle-delay 0.500)

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

(all-the-icons-dired-mode)
(doom-modeline-mode)
(show-paren-mode)
(electric-pair-mode)
(rainbow-delimiters-mode)
(global-fira-code-mode)
