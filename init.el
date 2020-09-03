;;; Package --- Summary:
;;; GNU Emacs init config

;;; Commentary:
;;; It sure is messy

;;; Code:

(setq comp-deferred-compilation t)
;; Personal Info
(setq user-full-name "Lev Polyakov"
      user-mail-address "SunGrow@tuta.io")
(let ((file-name-handler-alist nil)) "init.el") ; speed up the load

;; Set up package.el to work with MELPA
(require 'package)
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")
			 ("melpa-stable" . "https://stable.melpa.org/packages/")
			 ("org" . "http://orgmode.org/elpa")))
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(unless package-archive-contents (package-refresh-contents))
(eval-when-compile
  (require 'use-package))
(require 'bind-key)

(use-package benchmark-init
  :ensure t
  :config
  ;; To disable collection of benchmark data after init is done.
  (add-hook 'after-init-hook 'benchmark-init/deactivate))


;; Startup Buffer to blanc buffer screen
(setq inhibit-startup-screen t)
(setq gc-cons-threshold 100000000)
(setq read-process-output-max (* 1024 1024)) ; 1mb

;;; Look and Feel

;; Font
(set-frame-font "JetBrains Mono 11" nil t) ; Font

;; Set tabs
(setq-default indent-tabs-mode t
	      tab-width 4
	      c-basic-offset 4)
(setq-default tab-always-indent 'complete)
(defun my-insert-tab-char ()
  "Insert a tab char. (ASCII 9, \t)."
  (interactive)
  (insert "\t"))

(global-set-key (kbd "TAB") 'my-insert-tab-char)

;; Disabling the menu bar
(menu-bar-mode -1)

;; Disabling the toolbar
(tool-bar-mode -1)

;; Disabling the scrollbar
(toggle-scroll-bar -1)

;; Turn off the beep
(setq visible-bell 1)

;; Theme init
(use-package zenburn-theme
  :ensure t
  :init
  ;; use variable-pitch fonts for some headings and titles
  (setq zenburn-use-variable-pitch t)
  
  ;; scale headings in org-mode
  (setq zenburn-scale-org-headlines t)
  
  ;; scale headings in outline-mode
  (setq zenburn-scale-outline-headlines t)
  
  (setq zenburn-override-colors-alist
        '(
      	("zenburn-fg"       . "#DCDCCC") ; Menu text
        ("zenburn-fg+1"     . "#FFFFCF") ; Cursor
  
        ("zenburn-bg-1"     . "#7F7460") ; Status line + Selection
        ("zenburn-bg"       . "#31312D") ; Main BG
        ("zenburn-bg+1"     . "#31312D") ; Left and Right borders
      	("zenburn-yellow"   . "#F1E0AF") ; Status line curr file name and Menu Highlight
      	("zenburn-green-2"  . "#8F7B3F") ; Comment semicolumn
      	("zenburn-green"    . "#8F8B3B") ; Comment text
      	("zenburn-green+1"  . "#0F0F0F") ; Status line Side text
        ))
  ;; Set Theme
  (load-theme 'zenburn t)
  )


;; Transparency/Opacity

(set-frame-parameter (selected-frame) 'alpha '(97 90))
(add-to-list 'default-frame-alist '(alpha 97 90))

;; General Keybindings
(global-set-key (kbd "C-x C-b") 'buffer-menu)
(define-key vc-prefix-map (kbd "p") #'vc-pull)

;; Feel

;; Set move the backups to a separate directory
(setq backup-directory-alist `(("." . "~/.saves")))
(setq auto-save-file-name-transforms `((".*" "~/.saves/" t)))
(setq backup-by-copying t)
(global-auto-revert-mode t)

(use-package evil-leader
  :ensure t
  :init
  (global-evil-leader-mode t)
  (evil-leader/set-leader "<SPC>")
  (evil-leader/set-key
   "d b s" 'gud-break
   "d b r" 'gud-remove
   "d a" 'gdb-display-disassembly-buffer
   "d s" 'gud-step
   "d S" 'gud-stepi
   "d n" 'gud-next
   "d N" 'gud-nexti
   "d c" 'gud-cont
   "d r" 'gud-run
   "e" 'find-file
   "b" 'switch-to-buffer
   "k" 'kill-buffer
   "w" 'evil-window-map
   "v" 'vc-prefix-map
   )
  )

;; Enable Evil
(use-package evil
  :ensure t
  :init
  (evil-mode 1)
  )

;; Enable which key
(use-package which-key
  :ensure t
  :init
  (setq which-key-popup-type 'minibuffer)
  (setq which-key-idle-delay 2)
  (setq which-key-idle-secondary-delay 1.25)
  (which-key-mode)
  )

;; Enable Ivy
(use-package ivy
  :ensure t
  :config
  (define-key ivy-minibuffer-map (kbd "C-k") #'ivy-previous-line)
  (define-key ivy-minibuffer-map (kbd "C-j") #'ivy-next-line)
  (define-key ivy-minibuffer-map (kbd "C-l") #'ivy-alt-done)
  
  (define-key ivy-minibuffer-map (kbd "C-h") #'ivy-kill-line)
  (define-key ivy-switch-buffer-map (kbd "C-h") #'ivy-switch-buffer-kill)
  (define-key ivy-switch-buffer-map (kbd "C-k") #'ivy-previous-line)
  (ivy-mode 1) ; Because I don't like helm
  )

(use-package ivy-xref
  :ensure t
  :after (ivy)
  :init
  (when (>= emacs-major-version 27)
	(setq xref-show-definitions-function #'ivy-xref-show-defs)
	)
  (setq xref-show-xrefs-function #'ivy-xref-show-xrefs)
  )


;;; General Project Development

;; Enable Projectile
(use-package projectile
  :ensure t
  :init
  (evil-leader/set-key
   "p" 'projectile-command-map
   "d d" 'projectile-run-gdb
   "c" 'projectile-compile-project
   )
  (setq projectile-completion-system 'ivy)
  (setq projectile-project-search-path '("~/Documents/" "~/Projects/"))
  (projectile-mode +1)
  :config
  (define-key projectile-mode-map (kbd "C-p") 'projectile-command-map)
)

;; Company mode
(use-package company
  :ensure t
  :init
  (setq company-minimum-prefix-length 1
    company-idle-delay 0.0) ;; default is 0.2
  :config
  (define-key company-active-map (kbd "C-j") #'company-select-next)
  (define-key company-active-map (kbd "C-k") #'company-select-previous)
  (add-hook 'after-init-hook 'global-company-mode)
  )

(use-package elpy
  :ensure t
  :init
  (add-hook 'python-mode-hook
      (lambda ()
        (setq indent-tabs-mode t)
        (setq tab-width 4)
        (setq python-indent-offset 4)))
  (elpy-enable)
  )

(use-package flycheck
  :ensure t
  :init
  (evil-leader/set-key
   "f h" 'flycheck-previous-error
   "f l" 'flycheck-next-error
   )
  (setq flycheck-checker-error-threshold 50)
  (global-flycheck-mode)
  )

(use-package markdown-mode
  :ensure t
  :defer t
  )

;; GLSL
(use-package glsl-mode
  :ensure t
  :init
  (add-to-list 'auto-mode-alist '("\\.vert\\'" . glsl-mode))
  (add-to-list 'auto-mode-alist '("\\.frag\\'" . glsl-mode))
  )

;; CMake

(use-package cmake-mode
  :ensure t
  )

;; Go

(use-package go-mode
  :ensure t
  )

;; LSP mode
(use-package lsp-mode
  :after (projectile flycheck)
  :ensure t
  :init
  (evil-leader/set-key
   "l l" 'lsp
   "l r" 'lsp-rename
   "g d" 'lsp-find-definition
   "g D" 'lsp-find-references
   )

  (defvar lsp-language-id-congiguration
    '(
  	(python-mode . "python")
	(c-mode . "c")
	(c++-mode . "c++")
	(go-mode . "go")
  	))
  :config
  (lsp-enable-which-key-integration)

  (lsp-register-client
   (make-lsp-client
  	:new-connection (lsp-stdio-connection "pyls")
  	:major-modes '(python-mode)
  	:server-id 'pyls)
   )

  (lsp-register-client
   (make-lsp-client
	:new-connection (lsp-stdio-connection "clangd")
	:major-modes '(c-mode c++-mode cc-mode objc-mode)
	:priority 1
	:server-id 'clangd
	)
   )

  (setq lsp-clients-clangd-args '("--cross-file-rename" "--clang-tidy" "--compile-commands-dir=build" "--background-index" "-j=8"))
  (use-package lsp-ivy
   	:after (lsp ivy)
    :ensure t
  	:init
    (evil-leader/set-key
   	"l s" 'lsp-ivy-workspace-symbol
   	)
   )

  :hook
  (python-mode . lsp)
  (c-mode . lsp)
  (c++-mode . lsp)
  (go-mode . lsp)
  )


;;(use-package auto-complete-clang
;;  :ensure t
;;  )


;; MaGit
;; Too slow on Windows to use.



;; Irony

;;(use-package irony
;;  :ensure t
;;  :init
;;  ;; Set the buffer size to 64K on Windows (from the original 4K)
;;  (when (boundp 'w32-pipe-buffer-size)
;;    (setq irony-server-w32-pipe-buffer-size (* 64 1024)))
;;  (when (boundp 'w32-pipe-read-delay)
;;    (setq w32-pipe-read-delay 0))
;;  :config
;;
;;  (use-package company-irony
;;    :after (company irony)
;;    :ensure t
;;    :config
;;    (add-to-list 'company-backends 'company-irony)
;;    )
;;  (use-package company-irony-c-headers
;;    :after (company-irony)
;;    :ensure t
;;    :config
;;    (add-to-list 'company-backends 'company-irony-c-headers)
;;    )
;;  (use-package flycheck-irony
;;    :after (flycheck irony)
;;    :ensure t
;;    :config
;;    (add-hook 'flycheck-mode-hook #'flycheck-irony-setup)
;;    )
;;
;;  :hook
;;  (c++-mode . irony-mode)
;;  (c-mode . irony-mode)
;;  (objc-mode . irony-mode)
;;  (irony-mode . irony-cdb-autosetup-compile-options)
;;  )
;;
;;
;;
;;

;; RTags
;;
;;(use-package rtags
;;  :ensure t
;;  :init
;;  (evil-leader/set-key
;;   "r h" 'rtags-location-stack-back
;;   "r l" 'rtags-location-stack-forward
;;   "r p" 'rtags-previous-match
;;   "r n" 'rtags-next-match
;;   "r r" 'rtags-rename-symbol
;;   "r ." 'rtags-find-symbol-at-point
;;   "r ," 'rtags-find-references-at-point
;;   "r /" 'rtags-find-all-references-at-point
;;   "r >" 'rtags-find-symbol
;;   "r <" 'rtags-find-references
;;   "r i" 'rtags-symbol-info
;;   )
;;  :config
;;  (use-package ivy-rtags
;;    :ensure t
;;    :after (ivy rtags)
;;    :config
;;    (setq rtags-display-result-backend 'ivy)
;;  
;;    )
;;  (use-package flycheck-rtags
;;    :ensure t
;;    :after (flycheck rtags)
;;    )
;;  (use-package company-rtags
;;    :ensure t
;;    :after (company rtags)
;;    :config
;;    (push 'company-rtags company-backends)
;;    )
;;  )
;;
;;
;;;; CMake-IDE
;;
;;(use-package cmake-ide
;;  :ensure t
;;  :after (rtags flycheck auto-complete-clang company-clang irony)
;;  :init
;;  (evil-leader/set-key
;;   	;; cmake-ide keybindings
;;   	"i i" 'cmake-ide-maybe-start-rdm
;;   	"i r" 'cmake-ide-maybe-run-cmake
;;   	"i c" 'cmake-ide-compile
;;   	"i m d" '(lambda () (interactive) (setq cmake-ide-cmake-opts "-DCMAKE_BUILD_TYPE=Debug") (message "CMake build mode set to: Debug"))
;;   	"i m r" '(lambda () (interactive) (setq cmake-ide-cmake-opts "-DCMAKE_BUILD_TYPE=Release") (message "CMake build mode set to: Release"))
;;   	"i m i" '(lambda () (interactive) (setq cmake-ide-cmake-opts "-DCMAKE_BUILD_TYPE=RelWithDebInfo") (message "CMake build mode set to: RelWithDebInfo"))
;;	)
;;  :config
;;  (setq cmake-ide-build-dir (concat cmake-ide-project-dir "build"))
;;  (cmake-ide-setup)
;;
;;  )





;; Debug
(setq gdb-show-main t)
(setq gdb-many-windows nil)


;; SO copypaste: https://stackoverflow.com/questions/3860028/customizing-emacs-gdb
(defun set-gdb-layout(&optional c-buffer)
  (if (not c-buffer)
      (setq c-buffer (window-buffer (selected-window)))) ;; save current buffer

  ;; from http://stackoverflow.com/q/39762833/846686
  (set-window-dedicated-p (selected-window) nil) ;; unset dedicate state if needed
  (switch-to-buffer gud-comint-buffer)
  (delete-other-windows) ;; clean all

  (let* (
         (w-source (selected-window)) ;; left top
         (w-gdb (split-window w-source nil 'right)) ;; right bottom
         (w-locals (split-window w-gdb nil 'above)) ;; right middle bottom
         (w-stack (split-window w-locals nil 'above)) ;; right middle top
         (w-breakpoints (split-window w-stack nil 'above)) ;; right top
         (w-io (split-window w-source (floor(* 0.9 (window-body-height)))
                             'below)) ;; left bottom
		 ;;(w-disassembly (split-window w-gdb nil 'right))
         )
    (set-window-buffer w-io (gdb-get-buffer-create 'gdb-inferior-io))
    (set-window-dedicated-p w-io t)
    (set-window-buffer w-breakpoints (gdb-get-buffer-create 'gdb-breakpoints-buffer))
    (set-window-dedicated-p w-breakpoints t)
    (set-window-buffer w-locals (gdb-get-buffer-create 'gdb-locals-buffer))
    (set-window-dedicated-p w-locals t)
    (set-window-buffer w-stack (gdb-get-buffer-create 'gdb-stack-buffer))
    (set-window-dedicated-p w-stack t)
	;;(set-window-buffer w-disassembly (gdb-get-buffer-create 'gdb-disassembly-buffer))

    (set-window-buffer w-gdb gud-comint-buffer)

    (select-window w-source)
    (set-window-buffer w-source c-buffer)
    ))

(defadvice gdb (around args activate)
  "Change the way to gdb works."
  (setq global-config-editing (current-window-configuration)) ;; to restore: (set-window-configuration c-editing)
  (let (
        (c-buffer (window-buffer (selected-window))) ;; save current buffer
        )
    ad-do-it
    (set-gdb-layout c-buffer))
  )

(defadvice gdb-reset (around args activate)
  "Change the way to gdb exit."
  ad-do-it
  (set-window-configuration global-config-editing))








(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("76c5b2592c62f6b48923c00f97f74bcb7ddb741618283bdb2be35f3c0e1030e3" default))
 '(flycheck-checker-error-threshold 1024)
 '(package-selected-packages
   '(go-mode benchmark-init glsl-mode markdown-mode lsp-mode evil-leader cmake-mode bind-key projectile company ivy ## zenburn-theme evil))
 '(send-mail-function 'mailclient-send-it))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(provide 'init)

;;; Init ends here

