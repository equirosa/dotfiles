(setq use-package-always-ensure t
      use-package-always-defer t
      use-package-expand-minimally t)
(use-package emacs
  :preface
  (defvar ian/indent-width 4) ; change this value to your preferred width
  (defun kiri/kill-this-buffer ()
    "Kill the currently focused buffer."
    (interactive)
    (kill-buffer (current-buffer)))
  :custom
  (delete-by-moving-to-trash t)
  (ring-bell-function 'ignore)       ; minimize distraction
  (frame-resize-pixelwise t)
  (default-directory "~/")
  ;; Omit default startup screen
  (inhibit-startup-screen t)
  ;; better scrolling experience
  (scroll-margin 0)
  (scroll-conservatively 101) ; > 100
  (scroll-preserve-screen-position t)
  (auto-window-vscroll nil)
  (use-dialog-box nil)
  (history-length 25)
  :config
  (tool-bar-mode -1)
  (menu-bar-mode -1)
  (recentf-mode 1)
  (savehist-mode 1)

  (add-hook 'text-mode-hook 'visual-line-mode)

  (global-set-key (kbd "C-x k") 'kiri/kill-this-buffer)
  (global-set-key (kbd "C-x w") 'delete-frame)
  (global-set-key (kbd "C-c s s") 'replace-string)
  (global-set-key (kbd "C-c s r") 'replace-regexp)
  (global-set-key [remap eval-last-sexp] 'pp-eval-last-sexp)

  ;; Always use spaces for indentation
  (setq-default indent-tabs-mode nil
                tab-width ian/indent-width))

;; The Emacs default split doesn't seem too intuitive for most users.
(use-package emacs
  :ensure nil
  :preface
  (defun ian/split-and-follow-horizontally ()
    "Split window below."
    (interactive)
    (split-window-below)
    (other-window 1))
  (defun ian/split-and-follow-vertically ()
    "Split window right."
    (interactive)
    (split-window-right)
    (other-window 1))
  :config
  (global-set-key (kbd "C-x 2") #'ian/split-and-follow-horizontally)
  (global-set-key (kbd "C-x 3") #'ian/split-and-follow-vertically))
;; Built-ins
(use-package scroll-bar
  :ensure nil
  :config (scroll-bar-mode -1))
(use-package simple
  :ensure nil
  :config (column-number-mode 1))
(use-package files
  :ensure nil
  :custom
  (confirm-kill-processes nil)
  (create-lockfiles nil) ; don't create .# files (crashes 'npm start')
  (make-backup-files nil))
(use-package select
  :ensure nil
  :config (x-select-enable-clipboart t))
(use-package autorevert
  :ensure nil
  :custom
  (auto-revert-interval 2)
  (auto-revert-check-vc-info t)
  (global-auto-revert-non-file-buffers t)
  (auto-revert-verbose nil)
  :config
  (global-auto-revert-mode 1))
(use-package eldoc
  :ensure nil
  :diminish eldoc-mode
  :custom
  (eldoc-idle-delay 0.4))

;; Diminish
(use-package diminish)

;; Bool flip
(use-package bool-flip
  :bind ("C-c b" . bool-flip-do-flip))

;; C, C++, and Java
(use-package cc-vars
  :ensure nil
  :config
  (setq-default c-basic-offset ian/indent-width)
  (setq c-default-style '((java-mode . "java")
                          (awk-mode . "awk")
                          (other . "k&r"))))

;; Python (both v2 and v3)
(use-package python
  :ensure nil
  :custom (python-indent-offset ian/indent-width))

(use-package mwheel
  :ensure nil
  :custom
  (mouse-wheel-scroll-amount '(2 ((shift) . 1)))
  (mouse-wheel-progressive-speed nil))
(use-package paren
  :ensure nil
  :init (setq show-paren-delay 0)
  :config (show-paren-mode +1))
(use-package frame
  :preface
  (defun ian/set-default-font ()
    (interactive)
    (when (member "Iosevka Comfy Duo" (font-family-list))
      (set-face-attribute 'default nil :family "Iosevka Comfy Duo"))
    (set-face-attribute 'default nil
                        :height 120
                        :weight 'normal))
  :ensure nil
  :config
  (setq initial-frame-alist '((fullscreen . maximized)))
  (ian/set-default-font))
(use-package ediff
  :ensure nil
  :config
  (setq ediff-window-setup-function #'ediff-setup-windows-plain)
  (setq ediff-split-window-function #'split-window-horizontally))
(use-package elec-pair
  :ensure nil
  :hook (prog-mode . electric-pair-mode))
(use-package whitespace
  :ensure nil
  :hook (before-save . whitespace-cleanup))
(use-package dired ; Delete intermediate buffers when navigating through dired.
  :ensure nil
  :custom
  (delete-by-moving-to-trash t)
  :config
  (eval-after-load "dired"
    #'(lambda ()
        (put 'dired-find-alternate-file 'disabled nil)
        (define-key dired-mode-map (kbd "RET") #'dired-find-alternate-file))))

;; Beacon
(use-package beacon
  :config (beacon-mode 1))

;; cool syntax highlighting
(use-package rainbow-delimiters
  :config (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))
(use-package highlight-numbers
  :hook (prog-mode . highlight-numbers-mode))
(use-package highlight-escape-sequences
  :hook (prog-mode . hes-mode))
;; VI keybindings
(use-package evil
  :diminish undo-tree-mode
  :init
  (setq evil-want-C-u-scroll t
        evil-want-keybinding nil
        evil-shift-width ian/indent-width)
  :hook (after-init . evil-mode)
  :preface
  (defun ian/save-and-kill-this-buffer ()
    (interactive)
    (save-buffer)
    (kill-this-buffer))
  :config
  (with-eval-after-load 'evil-maps ; avoid conflict with company tooltip selection
    (define-key evil-insert-state-map (kbd "C-n") nil)
    (define-key evil-insert-state-map (kbd "C-p") nil))
  (evil-ex-define-cmd "q" #'kill-this-buffer)
  (evil-ex-define-cmd "wq" #'ian/save-and-kill-this-buffer))
(use-package evil-collection
  :after evil
  :custom
  (evil-collection-company-use-tng nil)
  :config
  (evil-collection-init))
(use-package evil-commentary
  :after evil
  :diminish
  :config (evil-commentary-mode +1))
(use-package evil-org
  :after org
  :hook (org-mode . (lambda () evil-org-mode))
  :config
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))
;; Git
(use-package magit
  :bind ("C-x g" . magit-status)
  :config (add-hook 'with-editor-mode-hook #'evil-insert-state))

;; Searching/sorting enhancements & project management
;; Ido, ido-vertical, ido-ubiquitous and fuzzy matching
(use-package ido
  :ensure nil
  :config
  (ido-mode +1)
  (setq ido-everywhere t
        ido-enable-flex-matching t))

(use-package ido-vertical-mode
  :config
  (ido-vertical-mode +1)
  (setq ido-vertical-define-keys 'C-n-C-p-up-and-down))

(use-package ido-completing-read+ :config (ido-ubiquitous-mode +1))

(use-package flx-ido :config (flx-ido-mode +1))

;; Company for auto-completion
(use-package company
  :diminish company-mode
  :hook (prog-mode . company-mode)
  :config
  (setq company-minimum-prefix-length 1
        company-idle-delay 0.1
        company-selection-wrap-around t
        company-tooltip-align-annotations t
        company-frontends
        '(company-pseudo-tooltip-frontend ; show tooltip even for single candidate
          company-echo-metadata-frontend))
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous))

(use-package company-org-block
  :custom (company-org-block-edit-style 'auto)
  :hook ((org-mode . (lambda ()
                       (setq-local company-backends '(company-org-block))
                       (company-mode 1)))))

;; ;; Flycheck
;; (use-package flycheck :config (global-flycheck-mode +1))

;; Theme
(use-package catppuccin-theme
  :custom (catppuccin-flavor 'mocha)
  :config (load-theme 'catppuccin))

(use-package doom-modeline
  :init (doom-modeline-mode 1))

;; Org Mode
(use-package org
  :custom
  (org-list-allow-alphabetical t)
  :hook ((org-mode . org-indent-mode)))

(use-package org-bullets :hook org-mode)

;; Markdown
(use-package markdown-mode
  :mode ("README\\.md\\'" . gfm-mode)
  :custom (markdown-command "multimarkdown"))

;; Which-key
(use-package which-key
  :diminish which-key-mode
  :config
  (which-key-mode +1)
  (setq which-key-idle-delay 0.4
        which-key-idle-secondary-delay 0.4))

(use-package keychain-environment
  :config(keychain-refresh-environment))

;; Syntax
(use-package treesit-auto
  :config
  (global-treesit-auto-mode))
(use-package tree-sitter-langs)

;; Vterm
(use-package multi-vterm
  :bind (("C-c C-v v" . multi-vterm)
         ("C-c C-v n" . multi-vterm-next)
         ("C-c C-v p" . multi-vterm-prev)))

;; Programming
(use-package eglot
  :hook
  (prog-mode . eglot-ensure)
  (before-save . eglot-format-buffer)
  :config
  (add-to-list 'eglot-server-programs '(nix-mode . ("nixd"))))
(use-package elm-mode)
(use-package lua-mode)
(use-package nix-mode)
(use-package rust-mode)
(use-package envrc
  :diminish
  :config (envrc-global-mode))
(provide 'init)
;;; init.el ends here
