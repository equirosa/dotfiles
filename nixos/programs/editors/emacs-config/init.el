;;; package -- Summary
;;; Commentary:
;;; This is my init file
;;; Code:
;; Define and initialise package repositories
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
;; use-package to simplify the config file
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(custom-set-variables '(use-package-always-ensure 't))
;; TODO: sort these later...
(recentf-mode 1)
(custom-set-variables
 '(history-length 25)
 '(save-interprogram-paste-before-kill t))
(savehist-mode)
(save-place-mode)
;; Move custom file
(custom-set-variables '(custom-file (locate-user-emacs-file "custom-vars.el")))
(load custom-file 'noerror 'nomessage)
;; Keyboard-centric user interface
(custom-set-variables
 '(cursor-type 'bar)
 '(inhibit-startup-message t)
 '(visible-bell t))
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(defalias 'yes-or-no-p 'y-or-n-p)
(use-package volatile-highlights
  :config
  (volatile-highlights-mode t))
(use-package bool-flip
  :bind ("C-c b" . bool-flip-do-flip))
(use-package hl-todo
  :custom
  (hl-todo-keyword-faces
	 '(("TODO"   . "#FF0000")
		 ("FIXME"  . "#FF0000")
		 ("DEBUG"  . "#A020F0")
		 ("GOTCHA" . "#FF4500")
		 ("HACK"   . "#D79921")
		 ("STUB"   . "#1E90FF")
		 ("DONE"   . "#00FF00")))
  :hook (prog-mode))
;; Keybinds (for comfort)
(defun kiri/kill-this-buffer ()
  "Kill the currently focused buffer."
  (interactive)
  (kill-buffer (current-buffer)))
(global-set-key (kbd "C-x k") 'kiri/kill-this-buffer)
(global-set-key (kbd "C-x w") 'delete-frame)
(global-set-key (kbd "C-c s s") 'replace-string)
(global-set-key (kbd "C-c s r") 'replace-regexp)
(global-set-key [remap eval-last-sexp] 'pp-eval-last-sexp)
;; Auto-pairs
(electric-pair-mode)
;; Prioritise UTF-8
(set-charset-priority 'unicode)
(custom-set-variables
 '(default-process-coding-system '(utf-8-unix . utf-8-unix))
 '(locale-coding-system 'utf-8))
(set-terminal-coding-system 'utf-8)
(set-language-environment 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(require 'iso-transl) ; Allow special keys (for accents in Spanish, like this: ñ é ü)
;; Prevent littering
(use-package no-littering
  :config
  (add-to-list 'recentf-exclude '(no-littering-etc-directory no-littering-var-directory)))
;; Sane backups
(custom-set-variables
 '(vc-make-backup-files t)
 '(version-control t)
 '(kept-new-versions 10)
 '(kept-old-versions 0)
 '(delete-old-versions t)
 '(backup-by-copying t)
 '(backup-directory-alist '(("." . "~/.local/share/emacs/per-save"))))
;; Ligatures
(use-package fira-code-mode
	:if window-system
  :hook prog-mode)
;; Helm config
(use-package helm
  :init
  (helm-mode 1)
  :bind
  (("M-x"     . helm-M-x) ;; Evaluate functions
   ("C-x C-f" . helm-find-files) ;; Open or create files
   ("C-x b"   . helm-mini) ;; Select buffers
   ("C-x r b" . helm-filtered-bookmarks)
   ("C-x C-r" . helm-recentf) ;; Select recently saved files
   ("C-c i"   . helm-imenu) ;; Select document heading
   ("C-h a"   . helm-apropos)
   ("M-y"     . helm-show-kill-ring) ;; Show the kill ring
    :map helm-map
   ("C-z" . helm-select-action)
   ("<tab>" . helm-execute-persistent-action))
  :custom
  (helm-mini-default-sources
   '(helm-source-buffers-list
     helm-source-recentf
     helm-source-bookmarks
     helm-source-bookmark-set
     helm-source-buffer-not-found)
   helm-ff-skip-boring-files t))
(use-package helm-flyspell
  :after (helm)
  :hook (text-mode . flyspell-mode)
  :bind ("C-;" . helm-flyspell-correct)
  :custom (ispell-program-name "hunspell"))
(use-package helm-icons
  :after (helm)
  :config (helm-icons-enable))
(use-package helm-rg
  :after (helm))
;; Which-key
(use-package which-key
  :init (which-key-mode)
  :custom
  (which-key-idle-delay 0.5)
  (which-key-idle-secondary-delay 0.5)
  :config (which-key-setup-side-window-bottom))
;; Theme
(use-package beacon
  :config (beacon-mode 1))
(use-package doom-themes
  :custom
  (doom-themes-enable-bold t)
  (doom-themes-enable-italic t)
  :init
  (load-theme 'doom-gruvbox)
  (doom-themes-visual-bell-config)
  (doom-themes-org-config))
(use-package rainbow-delimiters
  :hook prog-mode)
;; Tree-sitter
(custom-set-variables '(treesit-auto-install 'prompt))
(use-package treesit-auto
  :config (global-treesit-auto-mode))
(use-package tree-sitter-langs)
(use-package tree-sitter-indent
  :hook rust-mode)
;; Autocompletion
(use-package corfu
  :custom
  (corfu-cycle t)
  (corfu-auto t)
  (corfu-auto-prefix 2)
  (corfu-auto-delay 0.0)
  (corfu-quit-at-boundary 'separator)
  (corfu-echo-documentation 0.25)
  (corfu-preview-current 'insert)
  (corfu-preselect-first nil)
  :bind (:map corfu-map
	      ("M-SPC" . corfu-insert-separator)
	      ("RET" . nil)
	      ("TAB" . corfu-next)
	      ([tab] . corfu-next)
	      ("S-TAB" . corfu-previous)
	      ([backtab] . corfu-previous)
	      ("S-<return>" . corfu-insert))
  :init
  (global-corfu-mode)
  (corfu-history-mode))
(use-package cape
  :defer 10
  :init
  (dolist
			(backends
			 '( cape-file
	      cape-dabbrev
	      cape-keyword
	      cape-ispell
	      cape-symbol))
		(add-to-list 'completion-at-point-functions backends))
  (advice-add 'pcomplete-completions-at-point :around #'cape-wrap-silent)
  (advice-add 'pcomplete-completions-at-point :around #'cape-wrap-purify))
;; Sensible line breaking
(add-hook 'text-mode-hook 'visual-line-mode)
;; Overwrite selected text
(delete-selection-mode t)
;; Scroll to the first and last line of the buffer
(custom-set-variables '(scroll-error-top-bottom t))
;; Set default, fixed and variable pitch fonts
;; Use M-x menu-set-font to view available fonts
(defvar kiri/default-font-size 130)
(custom-set-variables
 '(tab-width 2)
 '(x-stretch-cursor t))
(use-package mixed-pitch
  :hook text-mode
  :init
  (set-face-attribute 'default nil :font "Fira Code" :height kiri/default-font-size)
  (set-face-attribute 'fixed-pitch nil :font "Fira Code" :height kiri/default-font-size)
  (set-face-attribute 'variable-pitch nil :font "DejaVu Sans" :height kiri/default-font-size))
;; Required for proportional font
(use-package org-appear
  :hook org-mode)
;; Tangle
(use-package org-auto-tangle
  :hook org-mode)
;; Modernize Orgmode
(use-package gnuplot)
(use-package org-modern
  :hook org-mode
  :custom
  (org-element-use-cache t)
  (org-hide-emphasis-markers t)
  (org-src-fontify-natively t)
  (org-highlight-latex-and-related '(latex script entities))
  (org-image-actual-width '(300))
  (org-insert-heading-respect-content t)
  (org-pretty-entities t)
  (org-pretty-entities-include-sub-superscripts t)
  (org-startup-indented t)
  (org-startup-with-inline-images "inlineimages")
  (org-startup-with-inline-images t)
  (org-ellipsis "  ")
  :config
  (add-hook 'org-agenda-finalize-hook #'org-modern-agenda))
(use-package org-link-beautify ; Pretty links
  :hook org-mode)
(use-package org
  :config
  (add-to-list 'org-structure-template-alist '("jv" . "src java"))
  (add-to-list 'org-structure-template-alist '("js" . "src javascript"))
  (add-to-list 'org-structure-template-alist '("g" . "src go"))
  (add-to-list 'org-structure-template-alist '("r" . "src rust"))
  (add-to-list 'org-structure-template-alist '("ex" . "example"))
  :custom
  ;; Org Export
  (org-latex-toc-command "\\tableofcontents \\clearpage")
  (org-latex-compiler "tectonic -X compile")
  ;; Org Agenda
  (org-agenda-files '("~/Documents/org/agenda.org")))
;; Org-Roam basic configuration
(custom-set-variables '(org-directory (concat (getenv "HOME") "/Documents/org-roam/")))
(use-package org-roam
  :after (org)
  :custom
  (org-roam-directory (file-truename org-directory))
  (org-roam-capture-templates
   '(("d" "default" plain "%?"
      :if-new
      (file+head "${slug}.org"
		 "#+title: ${title}\n#+date: %u\n#+lastmod: %u\n\n")
      :immediate-finish t)))
  :config
  (org-roam-db-autosync-enable)
  :bind (("C-c n f" . org-roam-node-find)
	 ("C-c n r" . org-roam-node-random)
	 (:map org-mode-map
	       (("C-c n i" . org-roam-node-insert)
		("C-c n o" . org-id-get-create)
		("C-c n t" . org-roam-tag-add)
		("C-c n a" . org-roam-alias-add)
		("C-c n l" . org-roam-buffer-toggle)))))
;; Search stuff with Deft
(use-package deft
  :custom
  (deft-directory org-directory)
  (deft-recursive t)
  (deft-strip-summary-regexp ":PROPERTIES:\n\\(.+\n\\)+:END:\n")
  (deft-use-filename-as-title t)
  :bind
  ("C-c n d" . deft))
;; Spell checking for bibtex
(add-hook 'bibtex-mode-hook 'flyspell-mode)
;; Change Fields and format
(custom-set-variables
 '(bibtex-user-optional-fields
	 '(("keywords" "Keywords to describe the entry" ""))
	 ("file" "Link to document file." ":"))
 '(bibtex-align-at-equal-sign t))
;; BibLaTeX settings
;; bibtex-mode
(custom-set-variables '(bibtex-dialect 'biblatex))
(defvar bib-files-directory (directory-files
			     (concat (getenv "HOME") "/Documents/bibliography") t
			     "^[A-Z|a-z].+.bib$"))
(defvar pdf-files-directory (concat (getenv "HOME") "/Documents/bibliography/pdf"))
;; Helm + BibTeX
(use-package helm-bibtex
  :custom
  (bibtex-completion-bibliography bib-files-directory)
  (bibtex-completion-library-path pdf-files-directory)
  (bibtex-completion-pdf-field "File")
  (bibtex-completion-notes-path org-directory)
  (bibtex-completion-additional-search-fields '(keywords))
  :bind
  (("C-c n B" . helm-bibtex)))
;; Org-Roam + BibTeX
(use-package org-roam-bibtex
  :after (org-roam helm-bibtex)
  :bind (:map org-mode-map ("C-c n b" . orb-note-actions))
  :config
  (require 'org-ref))
(org-roam-bibtex-mode)
;; Org-ref
(use-package org-ref
  :init
  (require 'org-ref-helm)
  :custom
  (org-ref-insert-link-function 'org-ref-insert-link-hydra/body)
  (org-ref-insert-cite-function 'org-ref-cite-insert-helm)
  (org-ref-insert-label-function 'org-ref-insert-label-link)
  (org-ref-insert-ref-function 'org-ref-insert-ref-link)
  (org-ref-cite-onclick-function (lambda (_) (org-ref-citation-hydra/body)))
  (org-latex-pdf-process
   '("pdflatex -interaction nonstopmode -output-directory %o %f"
     "bibtex %b"
     "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
     "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))
  :bind (:map org-mode-map
              ("C-c ]" . org-ref-insert-link)
              ("M-[" . org-ref-insert-link-hydra/body)))
;; Undo Tree
(use-package undo-tree
  :init (global-undo-tree-mode)
  :custom
  (undo-tree-visualizer-diff t)
  (undo-tree-history-directory-alist '(("." . "~/.local/share/emacs/undo-tree/"))))
;; Magit
(use-package magit)
(use-package magit-delta
  :after (magit)
  :hook magit-mode)
(use-package diff-hl
  :config
  (global-diff-hl-mode)
  (diff-hl-flydiff-mode))
;; Direnv Stuff
(use-package envrc
  :init (envrc-global-mode))
;; Keychain
(use-package keychain-environment)
;; LSP
(use-package eglot
  :hook
  (prog-mode . eglot-ensure)
  (before-save . eglot-format)
  :bind (:map eglot-mode-map
	      ("C-c d" . 'xref-find-definitions)
	      ("C-c a" . 'eglot-code-actions)
	      ("C-c f" . 'eglot-format)
	      ("C-c h" . 'eldoc)
	      ("C-c o" . 'eglot-code-action-organize-imports)
	      ("C-c r" . 'eglot-rename)))
;; Language modes
(use-package elm-mode)
(use-package fish-mode)
(use-package nix-mode)
(use-package rust-mode)
(use-package rustic
  :hook rust-mode
  :custom
  (rustic-lsp-client 'eglot))
;; Nix-specific stuff
(use-package nix-update
  :after (nix-mode))
(use-package nix-modeline)
;; Vterm
(use-package vterm
  :bind ("C-c C-v" . vterm))
;; Snippets
(use-package yasnippet)
;; Markdown
(use-package markdown-mode
  :mode ("README\\.md\\'" . gfm-mode)
  :custom (markdown-command "pandoc --from=markdown --to=html5")
  :custom-face (markdown-code-face ((t (:inherit 'org-block)))))
;; Modeline
(use-package doom-modeline
  :config (doom-modeline-mode))
;; PDFs
(use-package pdf-tools)
;; Reading
(use-package nov)
;; Dired
(custom-set-variables '(delete-by-moving-to-trash t))
(add-hook 'dired-mode-hook 'auto-revert-mode)
(use-package all-the-icons-dired
  :hook dired-mode
  :diminish)
(provide 'init)
;;; init.el ends here
