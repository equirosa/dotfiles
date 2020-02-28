(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("5f27195e3f4b85ac50c1e2fac080f0dd6535440891c54fcfa62cdcefedf56b1b" "a2cde79e4cc8dc9a03e7d9a42fabf8928720d420034b66aecc5b665bbf05d4e9" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;; Handle package stuff
(require 'package)
;;;; Make unpure packages unavailable
(setq package-archives nil)
(setq package-enable-at-startup nil)
(package-initialize)
;; Locale stuff
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

;; Set some shortcuts
(local-set-key (kbd "C-c C-v") #'comment-line)

(electric-pair-mode 1) ;; Auto-pairs
(evil-mode 1) ;; Automatically use EVIL

(setq delete-by-moving-to-trash t) ;; Make dired send to trash instead of deleting the files

(setq make-backup-files nil) ; stop creating ~ files
(load-theme 'monokai) ;; auto-load themes

;; Rust Mode stuff
(add-hook 'rust-mode-hook
	  (lambda ()
	    (local-set-key (kbd "C-c <tab>") #'rust-format-buffer)))
(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'racer-mode-hook #'company-mode)
(add-hook 'flycheck-mode-hook #'flycheck-rust-setup)
(add-hook 'rust-mode-hook #'whitespace-mode)

;; Nix Mode stuff
(add-hook 'nix-mode-hook
	  (lambda ()
	    (local-set-key (kbd "C-c <tab>") #'nix-format-buffer)))
(add-hook 'nix-mode-hook #'whitespace-mode)
