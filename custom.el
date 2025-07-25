;;; config.el -*- lexical-binding: t ; eval: (view-mode -1) -*-

(let ((file-name-handler-alist nil))




  (modify-frame-parameters nil '((wait-for-wm . nil)))
  (setq visible-bell t)
  (fset 'yes-or-no-p 'y-or-n-p)


  ;; alias qrr for interactiv regexp replace
  (defalias 'qrr 'query-replace-regexp)

  ;; hide toolbar
  ;; (tool-bar-mode -1)

  (tool-bar-mode 0)
  (menu-bar-mode 0)
  (scroll-bar-mode 0)

  (tooltip-mode nil)
  (setq tooltip-use-echo-area t)


  (defun toggle-bars-view()
    (interactive)
    (if tool-bar-mode (tool-bar-mode 0) (tool-bar-mode 1))
    (if menu-bar-mode (menu-bar-mode 0) (menu-bar-mode 1)))
  (global-set-key [f12] 'toggle-bars-view)


  ;; zone: screensaver 10min
  ;; (setq zone-timer (run-with-idle-timer 600 t 'zone))

  ;; opened buffer name in window name
  (setq-default frame-title-format '("%f"))

  ;;show in which function we are (tends to freeze with python)
  (which-function-mode t)

  ;; fix dead keys?
  ;; (use-package iso-transl
  ;;   :demand t
  ;;   )

  ;; line number at left?
  ;; (global-linum-mode t) ;;deprecated...
  (global-display-line-numbers-mode 1)

  ;; delete the selection when DEL of C-y
  (delete-selection-mode 1)

  ;; stupid shit for when a mode is too slow
  (global-so-long-mode 1)

  ;; just remove the trailing whitespaces when saving
  (add-hook 'before-save-hook 'delete-trailing-whitespace)

  ;; (defconst *project-dir* (expand-file-name "~/git"))
  (defconst *project-dir* (expand-file-name "~/Project"))

  (use-package better-defaults
    :straight (better-defaults :type git :host nil :repo "https://git.sr.ht/~technomancy/better-defaults")
    :demand t)

  (setq default-directory "~/"
	;; always follow symlinks when opening files
	vc-follow-symlinks t
	;; overwrite text when selected, like we expect.
	delete-seleciton-mode t
	;; quiet startup
	inhibit-startup-message t
	initial-scratch-message nil
	;; hopefully all themes we install are safe
	custom-safe-themes t
	;; simple lock/backup file management
	create-lockfiles nil
	backup-by-copying t
	delete-old-versions t
	;; when quiting emacs, just kill processes
	confirm-kill-processes nil
	;; ask if local variables are safe once.
	enable-local-variables t
	;; life is too short to type yes or no
	use-short-answers t

	;; clean up dired buffers
	dired-kill-when-opening-new-dired-buffer t)

  ;; use human-readable sizes in dired
  (setq-default dired-listing-switches "-alh")

  ;; always highlight code
  (global-font-lock-mode 1)
  ;; refresh a buffer if changed on disk
  (global-auto-revert-mode 1)

  ;; save window layout & buffers
  ;; (setq desktop-restore-eager 5)
  ;; (desktop-save-mode 1)

  (setq user-full-name "Steve NGUYEN")
  (setq user-mail-address "steve.nguyen.000@gmail.com")

  (setq selection-coding-system 'compound-text-with-extensions)

  (setq x-super-keysym 'super)  ;;windows key is super (default)


  (prefer-coding-system 'utf-8)
  (set-default-coding-systems 'utf-8)
  (set-terminal-coding-system 'utf-8)
  (set-keyboard-coding-system 'utf-8)
  (set-selection-coding-system 'utf-8)
  (set-file-name-coding-system 'utf-8)
  (set-clipboard-coding-system 'utf-8)
  (set-buffer-file-coding-system 'utf-8)

  (use-package no-littering
    :demand t
    :config
    (setq
     auto-save-file-name-transforms
     `((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))
    (setq custom-file (no-littering-expand-etc-file-name "custom.el"))
    (when (file-exists-p custom-file)
      (load custom-file)))

  (use-package which-key
    :demand t
    ;;  :after evil
    :custom
    ;;  (which-key-allow-evil-operators t)
    (which-key-show-remaining-keys t)
    (which-key-sort-order 'which-key-prefix-then-key-order)
    :config
    (which-key-mode 1)
    (which-key-setup-minibuffer)
    (set-face-attribute
     'which-key-local-map-description-face nil :weight 'bold))


  (add-hook 'compilation-filter-hook 'ansi-color-compilation-filter)

  (setq ring-bell-function 'ignore ; no bell
	;; better scrolling
	scroll-conservatively 101
	scroll-preserve-screen-position 1
	mouse-wheel-follow-mouse t
	pixel-scroll-precision-use-momentum t)
  (setq-default line-spacing 1)

  ;; highlight the current line
  (global-hl-line-mode t)

  ;; Add padding inside buffer windows
  (setq-default left-margin-width 2
		right-margin-width 2)
  (set-window-buffer nil (current-buffer)) ; Use them now.

  ;; Add padding inside frames (windows)
  (add-to-list 'default-frame-alist '(internal-border-width . 8))
  (set-frame-parameter nil 'internal-border-width 8) ; Use them now

  ;; fix color display when loading emacs in terminal
  (defun enable-256color-term ()
    (interactive)
    (load-library "term/xterm")
    (terminal-init-xterm))

  (unless (display-graphic-p)
    (if (string-suffix-p "256color" (getenv "TERM"))
	(enable-256color-term)))


  					; # Mise en Couleur
  (global-font-lock-mode t)

					; # Décoration rélgée au maximum
  (setq font-lock-maximum-decoration t)

					; # Font taille maximale
  (setq font-lock-maximum-size nil)

					; # Zone séléctionnée en surbrillance
  (transient-mark-mode t)

  ;;why?? seems to break the delete-selection behavior

  (setq x-select-enable-primary t) ; handle x primary (mouse select)
  (setq x-select-enable-clipboard t); (standard clipboard)
  (setq mouse-yank-at-point t)



  ;; highlight some operation (yank)
  (use-package volatile-highlights
    :demand t)
  (volatile-highlights-mode t)
  ;;-----------------------------------------------------------------------------
  ;; Supporting undo-tree.
  ;;-----------------------------------------------------------------------------
  (vhl/define-extension 'undo-tree 'undo-tree-yank 'undo-tree-move)
  (vhl/install-extension 'undo-tree)


  (use-package all-the-icons
    :demand t)

  ;; doom-theme color
  (use-package doom-themes
    :demand t)

  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
	doom-themes-enable-italic t
	doom-molokai-brighter-comments nil
	) ; if nil, italics is universally disabled

  ;; Load the theme (doom-one, doom-molokai, etc); keep in mind that each theme
  ;; may have their own settings.
  ;; (load-theme 'doom-one t)
  (load-theme 'doom-molokai t)


  ;; (add-to-list 'custom-theme-load-path "~/.emacs.d/site-lisp/themes")
  ;; (load-theme 'molokai-overrides t) ;; Steve modif

  ;; ;; Enable flashing mode-line on errors
  ;; (doom-themes-visual-bell-config)

  ;; ;; Enable custom neotree theme
  ;; (doom-themes-neotree-config)  ; all-the-icons fonts must be installed!

  ;; ;; Corrects (and improves) org-mode's native fontification.
  ;; (doom-themes-org-config)
  ;; ;; (doom-org-default-settings)

  ;; ;; (global-set-key [f5] (lambda () (interactive) (load-theme 'doom-opera-light t)))
  ;; (global-set-key [f5] (lambda () (interactive) (load-theme 'sanityinc-tomorrow-day t) ;;in sunlight conditions
  ;; 			       (set-face-background 'hl-line "#BBB")
  ;; 			       (set-face-background 'linum "white")
  ;; 			       (set-face-foreground 'linum "black")

  ;; 			       ))
  ;; (global-set-key [f6] (lambda () (interactive) (load-theme 'doom-molokai t)
  ;; 			       (set-face-background 'hl-line "#333")
  ;; 			       (set-face-background 'linum "black")
  ;; 			       (set-face-foreground 'linum "gray80")
  ;; 			       ))

  ;; ;; highlight current line (fucked in terminal???)
  ;; (if window-system (global-hl-line-mode 1))
  ;; (if window-system (set-face-background 'hl-line "#333"))







  ;; Show line-number in the mode line
  (line-number-mode 1)

  (global-set-key [home] 'beginning-of-buffer)
  (global-set-key [end] 'end-of-buffer)

  ;; Show column-number in the mode line
  (column-number-mode 1)

  (use-package paren
    :demand t)
  (show-paren-mode 1)
  (setq-default hilight-paren-expression t)
  ;; (set-face-background 'show-paren-match (face-background 'default))
  (set-face-background 'show-paren-match "magenta")
  (set-face-foreground 'show-paren-match "#def")
  (set-face-attribute 'show-paren-match nil :weight 'extra-bold)

  ;; (setq blink-matching-paren t)
  ;; (defadvice show-paren-function (after blink activate)
  ;;   (when (= ?\) (char-before (point)))
  ;;     (blink-matching-open)))

  ;; fancy powerline
  ;; (require 'powerline)
  (use-package powerline)
  (powerline-default-theme)
  ;; (powerline-center-theme)
  ;; (setq powerline-default-separator
  ;;       'slant)
  (setq powerline-arrow-shape 'curve)
  (setq powerline-default-separator-dir '(right . left))


  ;; smart-mode-line
  ;; (setq sml/no-confirm-load-theme t)
  ;; (setq sml/theme 'powerline)
  ;; (sml/setup)

					;(electric-indent-mode +1) ;a little annoying
  (when (fboundp 'electric-indent-mode) (electric-indent-mode -1))
  (electric-pair-mode +1)




					; # Affichage Européen
					;(standard-display-european 1)

					; #  Binding des touches

					; # Touche 'Delete' définit pour supprimer le caractère placé après le
					; # curseur. Ne marche que sous console.
					; # (global-set-key [DEL] 'delete-char)

					; # Va en début de ligne (au lieu du début du fichier)
					; # (global-set-key [home] 'beginning-of-line)

					; # Va en fin de ligne (au lieu de la fin du fichier)
					; # (global-set-key [end] 'end-of-line)

					; # Permet d'atteindre la ligne x
					; (global-set-key (read-kbd-macro "C-c l") goto-line)
					;(define-key global-map "\C-xg"  'goto-line)

					;(setq gnus-select-method '(nntp "127.0.0.1"))

					; # css-mode
					; # (autoload 'css-mode "css-mode")
					; # (setq auto-mode-alist
					; #	(cons '("\\.css\\'" . css-mode) auto-mode-alist))

					; # retour a la ligne auto
  (setq default-major-mode 'text-mode)
  (add-hook 'text-mode-hook 'turn-off-auto-fill)

					; # Scrolling verticale
					;(setq-default scroll-conservatively 5)
					;(setq-default scroll-step 1)




					; affichage caractere sur 8bit
					; (standard-display-european t)
					; iso-latin1
					; (require 'iso-syntax)
					; c-x 8 comme touche compose
					; (require 'iso-insert)  ;ou iso-transl

					; # Mode php
					; # (autoload 'php-mode "php-mode" "PHP editing mode" t)
					; # (add-to-list 'auto-mode-alist '("\\.php3$" . php-mode ))

					; # Pour éviter la sauvegarde automatique
					; # (auto-save-mode 0)
					; # (setq make-backup-files nil)

					; EOF

					;(require 'tex-site)




  (put 'downcase-region 'disabled nil)

  (put 'upcase-region 'disabled nil)

  (defun word-count nil "Count words in buffer" (interactive)
	 (shell-command-on-region (point-min) (point-max) "wc -w"))






  ;; Comment/uncomment block
  (defun comment-or-uncomment-region-or-line ()
    "Comments or uncomments the region or the current line if there's no active region."
    (interactive)
    (let (beg end)
      (if (region-active-p)
	  (setq beg (region-beginning) end (region-end))
	(setq beg (line-beginning-position) end (line-end-position)))
      (comment-or-uncomment-region beg end)))

  ;; (global-set-key (kbd "C-c c") 'comment-or-uncomment-region)
  ;; (global-set-key (kbd "C-c u") 'uncomment-region)

  (global-set-key (kbd "C-c c") 'comment-or-uncomment-region-or-line)
  (global-set-key (kbd "C-c u") 'uncomment-region)


  ;; move cursor by camelCase
  (subword-mode 1)

  ;; Cycle between snake case, camel case, etc.
  (use-package string-inflection
    :demand t
    )
  (global-set-key (kbd "C-c p") 'string-inflection-cycle)
  (global-set-key (kbd "C-c O") 'string-inflection-camelcase)        ;; Force to CamelCase
  (global-set-key (kbd "C-c o") 'string-inflection-lower-camelcase)  ;; Force to lowerCamelCase
  (global-set-key (kbd "C-c P") 'string-inflection-underscore-function)  ;; Force to underscore


  ;;quick and simple local bookmarks
  (use-package bm
    :demand t
    )
  (global-set-key (kbd "C-b") 'bm-toggle)
  (global-set-key (kbd "S-<down>")   'bm-next)
  (global-set-key (kbd "S-<up>") 'bm-previous)


  ;; visuel seach and replace
  (use-package visual-regexp
    :demand t
    )
  (define-key global-map (kbd "C-x r") 'vr/replace)
  (define-key global-map (kbd "C-x q") 'vr/query-replace)
  ;; mark for multiple cursor
  (define-key global-map (kbd "C-x m") 'vr/mc-mark)

  ;; seach symbol at point
  (global-set-key (kbd "C-S-s") 'isearch-forward-symbol-at-point)

  ;; search the selected text
  (defun search-selection (beg end)
    "search for selected text"
    (interactive "r")
    (let (
          (selection (buffer-substring-no-properties beg end))
          )
      (deactivate-mark)
      (isearch-mode t nil nil nil)
      (isearch-yank-string selection)
      )
    )
  (define-key global-map (kbd "C-S-M-s") 'search-selection)

  ;; Copy The current line
  (defun copy-line (arg)
    "Copy lines (as many as prefix argument) in the kill ring.
      Ease of use features:
      - Move to start of next line.
      - Appends the copy on sequential calls.
      - Use newline as last char even on the last line of the buffer.
      - If region is active, copy its lines."
    (interactive "p")
    (let ((beg (line-beginning-position))
	  (end (line-end-position arg)))
      (when mark-active
	(if (> (point) (mark))
	    (setq beg (save-excursion (goto-char (mark)) (line-beginning-position)))
	  (setq end (save-excursion (goto-char (mark)) (line-end-position)))))
      (if (eq last-command 'copy-line)
	  (kill-append (buffer-substring beg end) (< end beg))
	(kill-ring-save beg end)))
    (kill-append "\n" nil)
    (beginning-of-line (or (and arg (1+ arg)) 2))
    (if (and arg (not (= 1 arg))) (message "%d lines copied" arg)))

  ;; set key binding
  (global-set-key (kbd "C-c C-k") 'copy-line)


  (use-package browse-kill-ring
    :demand t
    )
  (global-set-key (kbd "C-x C-y") 'browse-kill-ring)



  ;; iedit, simultaneous editing different regions
  (use-package iedit
    :demand t
    )
  (define-key global-map (kbd "C-;") 'iedit-mode)


  ;; undo tree
  (use-package undo-tree
    :demand t
    )
  (global-undo-tree-mode)
  (defalias 'redo 'undo-tree-redo)
  (global-set-key (kbd "C-8") 'redo)


  ;; tabbar
  (use-package tabbar
    :demand t
    )

  (global-set-key [s-left] 'tabbar-backward-tab)
  (global-set-key [s-right] 'tabbar-forward-tab)

  (setq tabbar-buffer-groups-function
	(lambda ()
	  (list "All Buffers")))

  (setq *tabbar-ignore-buffers* '("flymake:."))

  (setq tabbar-buffer-list-function
	(lambda ()
	  (remove-if
	   (or (lambda(buffer)
		 (find (aref (buffer-name buffer) 0) " *")
		 ;; (string-match "^ *" (aref (buffer-name buffer) 0))
		 )


	       (loop for name in *tabbar-ignore-buffers* ;remove buffer name in this list.
		     thereis (string-match name (buffer-name buffer))) ;;; WHY THE FUCK IT DOESN'T WORK? TODO

	       ;; (lambda(buffer)
	       ;;   (find (aref (buffer-name buffer) 0) " flymake")
	       ;;   ;; (string-match "^ *" (aref (buffer-name buffer) 0))
	       ;;   )

	       )
	   (buffer-list))
	  )
	)

  ;; Add a buffer modification state indicator in the tab label, and place a
  ;; space around the label to make it looks less crowd.
  (defadvice tabbar-buffer-tab-label (after fixup_tab_label_space_and_flag activate)
    (setq ad-return-value
	  (if (and (buffer-modified-p (tabbar-tab-value tab))
		   (buffer-file-name (tabbar-tab-value tab)))
	      (concat " + " (concat ad-return-value " "))
	      (concat " " (concat ad-return-value " ")))))

  ;; Called each time the modification state of the buffer changed.
  (defun ztl-modification-state-change ()
    (tabbar-set-template tabbar-current-tabset nil)
    (tabbar-display-update))

  ;; First-change-hook is called BEFORE the change is made.
  (defun ztl-on-buffer-modification ()
    (set-buffer-modified-p t)
    (ztl-modification-state-change))
  (add-hook 'after-save-hook 'ztl-modification-state-change)

  ;; This doesn't work for revert, I don't know.
  ;;(add-hook 'after-revert-hook 'ztl-modification-state-change)
  (add-hook 'first-change-hook 'ztl-on-buffer-modification)



  (setq tabbar-background-color "gray80") ;; the color of the tabbar background
  (custom-set-faces
   ;; custom-set-faces was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   '(org-level-1 ((t (:inherit org-level-1 :height 1.75))))
   '(org-level-2 ((t (:inherit org-level-2 :height 1.5))))
   '(org-level-3 ((t (:inherit org-level-3 :height 1.25))))
   '(org-level-4 ((t (:inherit org-level-4 :height 1.1))))
   '(org-level-5 ((t (:inherit org-level-5 :height 1.0))))
   '(tabbar-button ((t (:inherit tabbar-default :foreground "gray80"))))
   '(tabbar-button-highlight ((t (:inherit tabbar-default))))
   '(tabbar-default ((t (:inherit variable-pitch :background "gray60" :foreground "white" :weight bold))))
   '(tabbar-highlight ((t (:underline t))))
   '(tabbar-selected ((t (:background "white" :foreground "black" :weight bold))))
   '(tabbar-separator ((t (:inherit tabbar-default :background "gray90"))))
   '(tabbar-unselected ((t (:inherit tabbar-default :foreground "white")))))

  (use-package tabbar-ruler
    :demand t
    )


  ;; neotree (files in the left)
  (use-package neotree
    :demand t
    )
  (global-set-key [f8] 'neotree-toggle)

  ;; disable smartparens propagation in modes
  ;; (setq smartparens-global-mode -1)


  ;; move through windows
					;Enable winner-mode
  (winner-mode t)

  ;; ace window to switch between windows
  (global-set-key (kbd "M-p") 'ace-window)
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))

  ;; prevent new window frame
  ;; (setq pop-up-frames nil)
  ;; (setq pop-up-windows nil)
  (setq use-dialog-box nil)
					;Enable windmove
  ;; (windmove-default-keybindings)
  (windmove-default-keybindings 'meta)


  ;; tab completion. Sometimes...
  (setq tab-always-indent 'complete)
  (add-to-list 'completion-styles 'initials t)



  ;; Save point position between sessions
  (use-package saveplace
    :demand t
    )
  (setq-default save-place t)
  (setq save-place-file (expand-file-name ".places" user-emacs-directory))

  ;; ==== Save command histories ====

  ;; See
  ;; http://stackoverflow.com/questions/1229142/how-can-i-save-my-mini-buffer-history-in-emacs
  (setq savehist-additional-variables
	'(kill-ring search-ring regexp-search-ring))
  (setq savehist-file "~/.emacs.d/savehist")
  (savehist-mode 1)



  (use-package ace-jump-mode
    :demand t
    )

  (autoload
    'ace-jump-mode
    "ace-jump-mode"
    "Emacs quick move minor mode"
    t)
  ;; you can select the key you prefer to
  ;; (define-key global-map (kbd "C-c SPC") 'ace-jump-mode)
  (global-set-key (kbd "C-c C-SPC") 'ace-jump-mode)

  (autoload
    'ace-jump-mode-pop-mark
    "ace-jump-mode"
    "Ace jump back:-)"
    t)
  (eval-after-load "ace-jump-mode"
    '(ace-jump-mode-enable-mark-sync))
  (global-set-key (kbd "C-x C-SPC") 'ace-jump-mode-pop-mark)

  (defun smart-open-line ()
    "Insert an empty line after the current line.
Position the cursor at its beginning, according to the current mode."
    (interactive)
    (move-end-of-line nil)
    (newline-and-indent))

  (defun smart-open-line-above ()
    "Insert an empty line above the current line.
Position the cursor at it's beginning, according to the current mode."
    (interactive)
    (move-beginning-of-line nil)
    (newline-and-indent)
    (forward-line -1)
    (indent-according-to-mode))

  (global-set-key [(control shift return)] 'smart-open-line-above)
  (global-set-key [(shift return)] 'smart-open-line)



  ;; (add-hook 'text-mode-hook 'turn-on-auto-fill)
  ;; nope
  ;; (afp-setup-recommended-hooks)
  ;; better
  ;;  (add-to-list 'load-path "~/.emacs.d/site-lisp/filladapt")
  (use-package filladapt
    :demand t
    )
  (add-hook 'text-mode-hook 'turn-on-filladapt-mode)




  (defun kill-compile-buffer (buffer string)
    (kill-buffer-and-window)
    )

  (add-hook 'compilation-finish-functions 'kill-compile-buffer)

  (global-set-key (kbd "C-c m") 'compile)


  ;; Hippie expand

  ;; (add-to-list 'load-path "~/.emacs.d/site-lisp/hippie-expand")
  ;; (global-set-key (kbd "C-!") 'hippie-expand)
  ;; (global-set-key (kbd "C-:") 'hippie-expand-no-case-fold)
  ;; (global-set-key (kbd "C-;") 'hippie-expand-lines)

  ;; google translate
  (use-package google-translate
    :demand t
    )
  (global-set-key (kbd "C-c T") 'google-translate-at-point)
  (global-set-key (kbd "C-c t") 'google-translate-query-translate)
  (global-set-key (kbd "C-c R") 'google-translate-at-point-reverse)
  (global-set-key (kbd "C-c r") 'google-translate-query-translate-reverse)

  (setq google-translate-default-target-language "en")
  (setq google-translate-default-source-language "fr")
  (setq google-translate-enable-ido-completion t)


  ;; indent

  (defun indent-buffer ()
    "Indent the currently visited buffer."
    (interactive)
    (indent-region (point-min) (point-max)))

  (defun indent-region-or-buffer ()
    "Indent a region if selected, otherwise the whole buffer."
    (interactive)
    (save-excursion
      (if (region-active-p)
	  (progn
	    (indent-region (region-beginning) (region-end))
	    (message "Indented selected region."))
	(progn
	  (indent-buffer)
	  (message "Indented buffer.")))))

  (global-set-key (kbd "C-c i") 'indent-region-or-buffer)

  ;; ibuffer, can be usefull
  (use-package ibuffer
    :demand t
    )

  (global-set-key (kbd "C-x C-b") 'ibuffer-other-window)
  (setq ibuffer-default-sorting-mode 'major-mode)

  ;; multiple-cursors
  (add-to-list 'load-path "~/.emacs.d/site-lisp/multiple-cursors")
  (use-package multiple-cursors
    :demand t
    )
  (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
  (global-set-key (kbd "C->") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
  (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)



  ;; ido completion. Much better
  (use-package ido
    :demand t
    )
  (setq ido-enable-flex-matching t)
  (setq ido-everywhere t)
  (ido-mode 1)

  (defvar ido-enable-replace-completing-read t
    "If t, use ido-completing-read instead of completing-read if possible.

Set it to nil using let in around-advice for functions where the
original completing-read is required.  For example, if a function
foo absolutely must use the original completing-read, define some
advice lik this:

(defadvice foo (around original-completing-read-only activate)
  (let (ido-enable-replace-completing-read) ad-do-it))")

  ;; Replace completing-read wherever possible, unless directed otherwise
  (defadvice completing-read
      (around use-ido-when-possible activate)
    (if (or (not ido-enable-replace-completing-read) ; Manual override disable ido
	    (and (boundp 'ido-cur-list)
		 ido-cur-list)) ; Avoid infinite loop from ido calling this
	ad-do-it
      (let ((allcomp (all-completions "" collection predicate)))
	(if allcomp
	    (setq ad-return-value
		  (ido-completing-read prompt
				       allcomp
				       nil require-match initial-input hist def))
	  ad-do-it))))


  ;;and smex (goes with ido)
  (use-package smex
    :demand t) ; Not needed if you use package.el
  (smex-initialize) ; Can be omitted. This might cause a (minimal) delay
					; when Smex is auto-initialized on its first run. ; ;
  (global-set-key (kbd "M-x") 'smex)
  (global-set-key (kbd "M-X") 'smex-major-mode-commands)
  ;; This is your old M-x.
  (global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)



  ;; other minimap (sublimity)
  (use-package sublimity
    :demand t)
  ;; (use-package sublimity-scroll
  ;;   :demand t)
  ;; (use-package sublimity-map
  ;;   :demand t)
  ;; ;; (require 'sublimity-attractive)
  ;; (sublimity-map-set-delay nil)
  ;; (setq sublimity-scroll-weight 10
  ;;       sublimity-scroll-drift-length 5)


  ;; expend-region
  (use-package expand-region
    :demand t)
  (global-set-key (kbd "C-=") 'er/expand-region)





  ;;;;;;;;;;;;;;;;;; PROG

  ;; (define-key c-mode-base-map "\C-m" 'newline-and-indent)
  ;; (define-key c-mode-base-map [ret] 'newline-and-indent)

  (setq auto-mode-alist
	'(
	  ("\\.txt$" . text-mode)
	  ("\\.sgml$" . sgml-mode)
          ("\\.C$"  . c++-mode)
          ("\\.cc$" . c++-mode)
	  ("\\.hh$" . c++-mode)
	  ("\\.cpp$" . c++-mode)
	  ("\\.cxx$" . c++-mode)
	  ("\\.hpp$" . c++-mode)
          ("\\.c$"  . c-mode)
          ("\\.h$"  . c++-mode)
	  ("\\.py$" . python-mode)
          ("\\.el$" . emacs-lisp-mode)
          ("\\.emacs$" . emacs-lisp-mode)
          ("\\.gnus$" . emacs-lisp-mode)
          ("\\.scm$" . scheme-mode)
          ("\\.l$" . lisp-mode)
          ("\\.lisp$" . lisp-mode)
          ("\\.f$" . fortran-mode)
          ("\\.awk$" . awk-mode )
	  ("\\.pl$" . perl-mode )
          ("\\.tex$" . latex-mode )
          ("\\.sh$" . sh-mode )
          ("\\.html$" . web-mode)
          ("\\.shtml$" . web-mode)
	  ("\\.php3$" . web-mode)
	  ("\\.phtml$" . web-mode)
	  ("\\.css$" . web-mode)
	  ("\\.js$" . web-mode)
	  ("\\.vhdl$" . vhdl-mode)
	  ("\\.vhd$" . vhdl-mode)
          ("M?[Mm]akefile$" . makefile-mode)
          ("\\.mk$" . makefile-mode)
	  ("\\.org$" . org-mode)
	  ("\\.bib$" . bibtex-mode)
	  ("\\.json$" . json-mode)
	  ("\\.xml$" . xml-mode)
	  ("\\.launch$" . xml-mode)
	  ("\\.rs$" . rustic-mode)
	  ("\\.toml". toml-mode)
	  ("\\.yaml". yaml-mode)
	  )
	)

  (use-package rainbow-delimiters
    :defer 1
    :hook (prog-mode . rainbow-delimiters-mode)
    :config
    (set-face-attribute 'rainbow-delimiters-unmatched-face nil
			:foreground "red"
			:inherit 'error
			:box t))

  ;; change SMERGE prefix to "CTRL-c v"
  (setq smerge-command-prefix "\C-cv")

  (use-package highlight-indent-guides
    :demand t)
    (setq highlight-indent-guides-method 'character) ;;fine lines
    (setq highlight-indent-guides-auto-character-face-perc 20)
    (add-hook 'c-mode-common-hook 'highlight-indent-guides-mode)
    (add-hook 'python-mode-hook 'highlight-indent-guides-mode)


    ;; AGRESSIVE INDENT
    (use-package aggressive-indent
      :demand t)
    (global-aggressive-indent-mode 0)


  ;;;;;; python
    (use-package flycheck-mypy
      :demand t)
    (add-hook 'python-mode-hook 'flycheck-mode)

    ;; disable the slow ones
    (add-to-list 'flycheck-disabled-checkers 'python-flake8)
    (add-to-list 'flycheck-disabled-checkers 'python-pylint)

    ;; python formatter
    (use-package python-black
      :demand t
      :after python
      :hook (python-mode . python-black-on-save-mode-enable-dwim))


    ;; python isort
    (use-package python-isort
      :demand t)
    (add-hook 'python-mode-hook 'python-isort-on-save-mode)


  ;;;;; web


    ;; web mode
    (use-package web-mode
      :demand t)
    ;; (add-to-list 'ac-modes 'web-mode)


  ;;;;;;;; c/c++

    (setq c-default-style "linux")
    (setq c-basic-offset 4)
    (use-package cc-mode
      :demand t)

    ;; well, this does the job (just modified the basic-offset)
    ;; (add-to-list 'load-path "~/.emacs.d/site-lisp/google-c-style")
    ;; (require 'google-c-style)
    ;; (add-hook 'c-mode-common-hook 'google-set-c-style)
    ;; (add-hook 'c-mode-common-hook 'google-make-newline-indent)

    (use-package clang-format
      :demand t)
    (global-set-key [C-tab] 'clang-format-region)

    ;; coloring the delimiters () {} [] differently by depth
    (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

    ;; prepare the adaptive text fill for c-mode
    (add-hook 'c-mode-common-hook
	      (lambda ()
		(when (featurep 'filladapt)
		  (c-setup-filladapt))))






    ;;; RUST

  ;;; toml
  (use-package toml-mode
    :demand t)

;;; yaml

  (use-package yaml-mode
    :demand t)
  (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
  (add-hook 'yaml-mode-hook
	    '(lambda ()
	      (define-key yaml-mode-map "\C-m" 'newline-and-indent)))


  ;;;;;;;;;;;;;;;;;; RUST

  (use-package rustic
      :ensure
    :bind (:map rustic-mode-map
		("M-j" . lsp-ui-imenu)
		("M-?" . lsp-find-references)
		("C-c C-c l" . flycheck-list-errors)
		("C-c C-c a" . lsp-execute-code-action)
		("C-c C-c r" . lsp-rename)
		("C-c C-c q" . lsp-workspace-restart)
		("C-c C-c Q" . lsp-workspace-shutdown)
		("C-c C-c s" . lsp-rust-analyzer-status)
		("C-c C-c e" . lsp-rust-analyzer-expand-macro)
		("C-c C-c d" . dap-hydra)
		("C-c C-c h" . lsp-ui-doc-glance))
    :config
    ;; uncomment for less flashiness
    ;; (setq lsp-eldoc-hook nil)
    ;; (setq lsp-enable-symbol-highlighting nil)
    ;; (setq lsp-signature-auto-activate nil)

    ;; comment to disable rustfmt on save
    (setq rustic-rustfmt-args "+nightly")
    ;; (setq rustic-rustfmt-config-alist '((hard_tabs . t) (skip_children . nil)))
    (setq rustic-format-on-save t) ;;rustfmt OR clippy
    ;; (setq rustic-cargo-clippy-trigger-fix 'on-save) ;; Clippy change files without showing...

    ;; (setq rustic-flycheck-clippy-params "--message-format=json")
    (add-hook 'rustic-mode-hook 'rk/rustic-mode-hook))

  (defun rk/rustic-mode-hook ()
    ;; so that run C-c C-c C-r works without having to confirm, but don't try to
    ;; save rust buffers that are not file visiting. Once
    ;; https://github.com/brotzeit/rustic/issues/253 has been resolved this should
    ;; no longer be necessary.
    (when buffer-file-name
      (setq-local buffer-save-without-query t)))


  ;;;;;;;;;;;;;;;;;;

  (use-package lsp-pyright
      :hook (python-mode . (lambda () (require 'lsp-pyright)))
      :init (when (executable-find "python3")
              (setq lsp-pyright-python-executable-cmd "python3")))

  (use-package lsp-mode
      :hook ((c++-mode c-mode python-mode) . lsp-deferred)
      :commands lsp
      :custom
      ;; what to use when checking on-save. "check" is default, I prefer clippy
      (lsp-rust-analyzer-cargo-watch-command "clippy")
      (lsp-eldoc-render-all t)
      (lsp-idle-delay 0.6)
      ;; hints
      (lsp-inlay-hint-enable t)
      (lsp-inlay-hints-mode)
      ;; This controls the overlays that display type and other hints inline. Enable
      ;; / disable as you prefer. Well require a `lsp-workspace-restart' to have an
      ;; effect on open projects.
      ;; (lsp-rust-analyzer-inlay-hints-mode "block")
      (lsp-rust-analyzer-inlay-hints-mode t)
      (lsp-rust-analyzer-server-display-inlay-hints t)
      (lsp-rust-analyzer-display-lifetime-elision-hints-enable "skip_trivial")
      (lsp-rust-analyzer-display-chaining-hints t)
      (lsp-rust-analyzer-display-lifetime-elision-hints-use-parameter-names nil)
      (lsp-rust-analyzer-display-closure-return-type-hints t)
      (lsp-rust-analyzer-display-parameter-hints nil)
      (lsp-rust-analyzer-display-reborrow-hints nil)
      :config
      (add-hook 'lsp-mode-hook 'lsp-ui-mode)
      )

  (use-package lsp-ui
      :ensure
    :commands lsp-ui-mode
    :custom
    (lsp-ui-peek-always-show t)
    (lsp-ui-sideline-show-hover nil)
    (lsp-ui-sideline-show-diagnostics t)
    (lsp-ui-sideline-show-code-actions t)
    (lsp-ui-doc-enable nil))

  (with-eval-after-load 'lsp-mode
    (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration))

  (setq lsp-completion-provider :capf)
  (setq lsp-idle-delay 0.500)
  (setq lsp-log-io nil)

  ;; Annoying stuff
  (setq lsp-enable-links nil)
  ;; (setq lsp-signature-render-documentation nil)
  (setq lsp-headerline-breadcrumb-enable nil)
  ;; (setq lsp-ui-doc-enable nil)
  (setq lsp-completion-enable-additional-text-edit nil)
  (setq lsp-enable-folding nil)
  (setq lsp-enable-imenu nil)
  (setq lsp-enable-snippet nil)
  (setq lsp-inlay-hint-enable t)


  ;; (use-package lsp-mode
  ;;   :hook ((c-mode          ; clangd
  ;;           c++-mode        ; clangd
  ;;           c-or-c++-mode   ; clangd
  ;;           python-mode     ; pyright
  ;;           ) . lsp-deferred)
  ;;   :commands lsp
  ;;   :config
  ;;   (setq lsp-auto-guess-root t)
  ;;   (setq lsp-log-io nil)
  ;;   (setq lsp-restart 'auto-restart)
  ;;   (setq lsp-enable-symbol-highlighting nil)
  ;;   (setq lsp-enable-on-type-formatting nil)
  ;;   (setq lsp-signature-auto-activate nil)
  ;;   (setq lsp-signature-render-documentation nil)
  ;;   (setq lsp-eldoc-hook nil)
  ;;   (setq lsp-modeline-code-actions-enable nil)
  ;;   (setq lsp-modeline-diagnostics-enable nil)
  ;;   (setq lsp-headerline-breadcrumb-enable nil)
  ;;   (setq lsp-semantic-tokens-enable nil)
  ;;   (setq lsp-enable-folding nil)
  ;;   (setq lsp-enable-imenu nil)
  ;;   (setq lsp-enable-snippet nil)
  ;;   (setq read-process-output-max (* 1024 1024)) ;; 1MB
  ;;   (setq lsp-idle-delay 0.5))


  ;; lsp-mode TODO

  ;; (use-package lsp-mode :commands lsp :ensure t)
  (use-package lsp-ui :commands lsp-ui-mode :ensure t)



  ;;;;;company
  ;; company-mode auto completion

(use-package company
  :hook (prog-mode . company-mode))

(use-package company
  :commands company-mode
  :init
  (add-hook 'prog-mode-hook #'company-mode))

  ;; (use-package company:
  ;;   :demand t)
  (add-hook 'after-init-hook 'global-company-mode)
  ;; different frontend for the company completinn list
  ;; FIXME
  (use-package company-box
      :hook (company-mode . company-box-mode))





;;; COPILOT

  (defun rk/copilot-tab ()
    "Tab command that will complet with copilot if a completion is
available. Otherwise will try company, yasnippet or normal
tab-indent."
    (interactive)
    (or (copilot-accept-completion)
	(company-yasnippet-or-completion)
	(indent-for-tab-command)))

  (defun rk/copilot-complete-or-accept ()
    "Command that either triggers a completion or accepts one if one
is available. Useful if you tend to hammer your keys like I do."
    (interactive)
    (if (copilot--overlay-visible)
	(progn
          (copilot-accept-completion)
          (open-line 1)
          (next-line))
	(copilot-complete)))

  (defun rk/copilot-quit ()
    "Run `copilot-clear-overlay' or `keyboard-quit'. If copilot is
cleared, make sure the overlay doesn't come back too soon."
    (interactive)
    (condition-case err
	(when copilot--overlay
          (lexical-let ((pre-copilot-disable-predicates copilot-disable-predicates))
            (setq copilot-disable-predicates (list (lambda () t)))
            (copilot-clear-overlay)
            (run-with-idle-timer
             1.0
             nil
             (lambda ()
               (setq copilot-disable-predicates pre-copilot-disable-predicates)))))
      (error handler)))

  (defun rk/copilot-complete-if-active (next-func n)
    (let ((completed (when copilot-mode (copilot-accept-completion))))
      (unless completed (funcall next-func n))))

  (defun rk/no-copilot-mode ()
    "Helper for `rk/no-copilot-modes'."
    (copilot-mode -1))

  (defvar rk/no-copilot-modes '(shell-mode
				inferior-python-mode
				eshell-mode
				term-mode
				vterm-mode
				comint-mode
				compilation-mode
				debugger-mode
				dired-mode-hook
				compilation-mode-hook
				flutter-mode-hook
				minibuffer-mode-hook)
    "Modes in which copilot is inconvenient.")

  (defvar rk/copilot-manual-mode nil
    "When `t' will only show completions when manually triggered, e.g. via M-C-<return>.")

  (defvar rk/copilot-enable-for-org nil
    "Should copilot be enabled for org-mode buffers?")


  (defun rk/copilot-enable-predicate ()
    ""
    (and
     (eq (get-buffer-window) (selected-window))))

  (defun rk/copilot-disable-predicate ()
    "When copilot should not automatically show completions."
    (or rk/copilot-manual-mode
	(member major-mode rk/no-copilot-modes)
	(and (not rk/copilot-enable-for-org) (eq major-mode 'org-mode))
	(company--active-p)))

  (defun rk/copilot-change-activation ()
    "Switch between three activation modes:
- automatic: copilot will automatically overlay completions
- manual: you need to press a key (M-C-<return>) to trigger completions
- off: copilot is completely disabled."
    (interactive)
    (if (and copilot-mode rk/copilot-manual-mode)
	(progn
          (message "deactivating copilot")
          (global-copilot-mode -1)
          (setq rk/copilot-manual-mode nil))
	(if copilot-mode
            (progn
              (message "activating copilot manual mode")
              (setq rk/copilot-manual-mode t))
	    (message "activating copilot mode")
	    (global-copilot-mode))))

  (defun rk/copilot-toggle-for-org ()
    "Toggle copilot activation in org mode. It can sometimes be
annoying, sometimes be useful, that's why this can be handly."
    (interactive)
    (setq rk/copilot-enable-for-org (not rk/copilot-enable-for-org))
    (message "copilot for org is %s" (if rk/copilot-enable-for-org "enabled" "disabled")))

(use-package copilot
  :straight (:host github :repo "copilot-emacs/copilot.el" :files ("*.el"))
  :ensure t
      ;; ;; :diminish ;; don't show in mode line (we don't wanna get caught cheating, right? ;)

      :config
      ;; keybindings that are active when copilot shows completions
      (define-key copilot-mode-map (kbd "M-C-<next>") #'copilot-next-completion)
      (define-key copilot-mode-map (kbd "M-C-<prior>") #'copilot-previous-completion)
      (define-key copilot-mode-map (kbd "M-C-S-<right>") #'copilot-accept-completion-by-word)
      (define-key copilot-mode-map (kbd "M-C-S-<down>") #'copilot-accept-completion-by-line)

      ;; global keybindings
      (define-key global-map (kbd "M-C-<tab>") #'rk/copilot-complete-or-accept)
      (define-key global-map (kbd "M-C-<escape>") #'rk/copilot-change-activation)

      ;; Do copilot-quit when pressing C-g
      (advice-add 'keyboard-quit :before #'rk/copilot-quit)

      ;; complete by pressing right or tab but only when copilot completions are
      ;; shown. This means we leave the normal functionality intact.
      ;; (advice-add 'right-char :around #'rk/copilot-complete-if-active)
      ;; (advice-add 'indent-for-tab-command :around #'rk/copilot-complete-if-active)

      ;; deactivate copilot for certain modes
      (add-to-list 'copilot-enable-predicates #'rk/copilot-enable-predicate)
      (add-to-list 'copilot-disable-predicates #'rk/copilot-disable-predicate)

)

(defun copilot-turn-on-unless-buffer-read-only ()
  "Turn on `copilot-mode' if the buffer is writable."
  (unless (or buffer-read-only (not (buffer-file-name (current-buffer))))
    (copilot-mode 1)))




  (eval-after-load 'copilot
    '(progn
      ;; Note company is optional but given we use some company commands above
      ;; we'll require it here. If you don't use it, you can remove all company
      ;; related code from this file, copilot does not need it.
      (require 'company)
      ;; (global-copilot-mode)
      )
    )


    )
