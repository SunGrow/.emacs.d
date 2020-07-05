
;; Set up package.el to work with MELPA
;;; Code:
(require 'package)
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")
			 ("melpa-stable" . "https://stable.melpa.org/packages/")
			 ("org" . "http://orgmode.org/elpa")))
(package-initialize)
(unless package-archive-contents (package-refresh-contents))
;; Package Download
(unless (package-installed-p 'zenburn-theme)
  (package-install 'zenburn-theme))

(unless (package-installed-p 'evil)
  (package-install 'evil))
(unless (package-installed-p 'evil-leader)
  (package-install 'evil-leader))

(unless (package-installed-p 'ivy)
  (package-install 'ivy))

(unless (package-installed-p 'git)
  (package-install 'git))

(unless (package-installed-p 'projectile)
  (package-install 'projectile))

(unless (package-installed-p 'treemacs)
  (package-install 'treemacs))
(unless (package-installed-p 'treemacs-evil)
  (package-install 'treemacs-evil))
(unless (package-installed-p 'treemacs-projectile)
  (package-install 'treemacs-projectile))

(unless (package-installed-p 'company)
  (package-install 'company))

(unless (package-installed-p 'cmake-mode)
  (package-install 'cmake-mode))

(unless (package-installed-p 'elpy)
  (package-install 'elpy))

(unless (package-installed-p 'flycheck)
  (package-install 'flycheck))

(unless (package-installed-p 'markdown-mode)
  (package-install 'markdown-mode))

(unless (package-installed-p 'lsp-mode)
  (package-install 'lsp-mode))

(unless (package-installed-p 'glsl-mode)
  (package-install 'glsl-mode))


;; Looks setup

(set-frame-font "JetBrains Mono 10" nil t)

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

;; Startup Buffer Sivyetup

(setq inhibit-startup-screen t)

;; Theme init

(require 'zenburn-theme)

;; use variable-pitch fonts for some headings and titles
(setq zenburn-use-variable-pitch t)

;; scale headings in org-mode
(setq zenburn-scale-org-headlines t)

;; scale headings in outline-mode
(setq zenburn-scale-outline-headlines t)

(setq zenburn-override-colors-alist
      '(
    	("zenburn-fg"       . "#DCDCCC") ;; Menu text
      	("zenburn-fg+1"     . "#FFFFCF") ;; Cursor

      	("zenburn-bg-1"     . "#7F7460") ;; Status line + Selection
      	("zenburn-bg"       . "#31312D") ;; Main BG
      	("zenburn-bg+1"     . "#3D3D3A") ;; Left and Right borders
    	("zenburn-yellow"   . "#F1E0AF") ;; Status line curr file name and Menu Highlight
    	("zenburn-green-2"  . "#8F7B3F") ;; Comment semicolumn
    	("zenburn-green"    . "#8F8B3B") ;; Comment text
    	("zenburn-green+1"  . "#0F0F0F") ;; Status line Side text
       	))
;; Set Theme
(load-theme 'zenburn t)


;; Evil

;; Enable Evil
(require 'evil)
(require 'evil-leader)
(evil-leader/set-leader "<SPC>")
(global-evil-leader-mode t)
(evil-mode 1)

;; Enable Ivy
(require 'ivy)
(ivy-mode 1)

;; MaGit
;; Too slow on Windows to use.

;; Git
;; (require 'git) is built in VC already.
;; C-x v v for commit info C-c C-c for commit
;; C-x v P for push


;; Enable Projectile

(require 'projectile)
(projectile-mode +1)
(setq projectile-project-search-path '("~/Documents/" "/Users/LazyF/Documents"))
(setq projectile-completion-system 'ivy)

;; Enable Treemacs

(require 'treemacs)
(require 'treemacs-evil)
(require 'treemacs-projectile)

;; Company mode

(add-hook 'after-init-hook 'global-company-mode)
(require 'company)
(setq company-minimum-prefix-length 1
      company-idle-delay 0.0) ;; default is 0.2

;; CMake

(require 'cmake-mode)

;; Irony

;;(require 'irony)
;;(require 'company-irony)
;;
;;(add-hook 'c++-mode-hook 'irony-mode)
;;(add-hook 'c-mode-hook 'irony-mode)
;;(add-hook 'objc-mode-hook 'irony-mode)
;;
;;(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
;;
;;(eval-after-load 'company
;;  '(add-to-list 'company-backends 'company-irony))

;; Windows performance tweaks
;;
;;(when (boundp 'w32-pipe-read-delay)
;;  (setq w32-pipe-read-delay 0))
;;;; Set the buffer size to 64K on Windows (from the original 4K)
;;(when (boundp 'w32-pipe-buffer-size)
;;  (setq irony-server-w32-pipe-buffer-size (* 64 1024)))


;; Keybindings

(global-set-key (kbd "C-x C-b") 'buffer-menu)
 
;; Company keybindings

(define-key company-active-map (kbd "C-j") #'company-select-next)
(define-key company-active-map (kbd "C-k") #'company-select-previous)

;; Ivy keybindings

(define-key ivy-minibuffer-map (kbd "C-k") #'ivy-previous-line)

(define-key ivy-minibuffer-map (kbd "C-j") #'ivy-next-line)

(define-key ivy-minibuffer-map (kbd "C-l") #'ivy-alt-done)

;; C-h -> (kbd "DEL")
(define-key ivy-minibuffer-map (kbd "C-h") #'ivy-kill-line)
(define-key ivy-switch-buffer-map (kbd "C-h") #'ivy-switch-buffer-kill)
(define-key ivy-switch-buffer-map (kbd "C-k") #'ivy-previous-line)

;; Projectile keybindings

(global-unset-key (kbd "C-p"))
(define-key evil-normal-state-map (kbd "C-p") nil)
(define-key projectile-mode-map (kbd "C-p") 'projectile-command-map)

;; Recursive resize map
;;(defun evil-window-r-decrease-width ()
;;  "Decrease width of a window and return to a resize window map."
;;	(interactive)
;;  '(progn #'evil-window-decrease-width 'evil-window-r-resize-map))
;;
;;(defvar evil-window-resize-r-map (make-sparse-keymap)
;;  "Keymap for resize related commands.")
;;(fset 'evil-window-resize-r-map evil-window-resize-r-map)
;;(define-key evil-window-resize-r-map (kbd "h") #'evil-window-r-decrease-width)

(evil-leader/set-key
   "p" 'projectile-command-map
   "e" 'find-file
   "b" 'switch-to-buffer
   "k" 'kill-buffer
   "w" 'evil-window-map
   "o p" 'treemacs
   "v" 'vc-prefix-map
   "l l" 'lsp
   "l r" 'lsp-rename
   "R" 'evil-window-r-resize-map
   "g d" 'lsp-find-definition
   "h" 'helm-swoop)


(define-key vc-prefix-map (kbd "p") #'vc-pull)

;; Treemacs keybindings

(define-key evil-normal-state-map (kbd "C-o") nil)
(define-key evil-normal-state-map (kbd "C-o p") #'treemacs)

;; Project compile
(defun c-project-configure (&optional ConfigMode)
  "Configure projectile cmake c project."
  (interactive)
  (shell-command
   (format "cmake --no-warn-unused-cli -DCMAKE_EXPORT_COMPILE_COMMANDS:BOOL=TRUE -DCMAKE_BUILD_TYPE:STRING=%s -H%s -B%sbuild -G Ninja"
   (if ConfigMode ConfigMode "Debug")
   (projectile-project-root)
   (projectile-project-root)
  )
  )
  )
(defun c-project-compile (&optional CompileMode)
  "Configure projectile cmake c project."
  (interactive)
  (shell-command
   (format "cmake --build %sbuild --config %s -- -j 10"
   ; --target EsperEngineTest //Because it is too much of a hassle to implement a target to build menu
   (projectile-project-root)
   (if CompileMode CompileMode "Debug")
  )
  )
)

;; Debug
(setq gdb-show-main t)
(setq gdb-many-windows 1)

;;(require 'quelpa)
;;(require 'quelpa-use-package)
;;;;;;;;;;;;;;;;(unless (package-installed-p 'quelpa)
;;;;;;;;;;;;;;;;  (package-install 'quelpa))
;;;;;;;;;;;;;;;;(unless (package-installed-p 'quelpa-use-package)
;;;;;;;;;;;;;;;;  (package-install 'quelpa-use-package))
;;(use-package gdb-mi :quelpa (gdb-mi :fetcher git
;;                                  :url "https://github.com/weirdNox/emacs-gdb.git"
;;                                  :files ("*.el" "*.c" "*.h" "Makefile"))
;;;;:init
;;;;(fmakunbound 'gdb)
;;;;(fmakunbound 'gdb-enable-debug) 
;;)



;; Python

(require 'elpy)
(elpy-enable)


(add-hook 'python-mode-hook
      (lambda ()
        (setq indent-tabs-mode t)
        (setq tab-width 4)
        (setq python-indent-offset 4)))



;; FlyCheck

(global-flycheck-mode)



;; LSP mode

(setq gc-cons-threshold 100000000)

(setq read-process-output-max (* 1024 1024)) ;; 1mb


(require 'lsp-mode)

(defvar lsp-language-id-congiguration
  '(
	(python-mode . "python")
  	(c-mode . "c")
  	(c++-mode . "c++")
	))
  

(lsp-register-client
 (make-lsp-client
	:new-connection (lsp-stdio-connection "pyls")
	:major-modes '(python-mode)
	:server-id 'pyls))

(lsp-register-client
 (make-lsp-client
	:new-connection (lsp-stdio-connection "clangd")
	:major-modes '(c-mode)
	:server-id 'clangd))

(lsp-register-client
 (make-lsp-client
	:new-connection (lsp-stdio-connection "clangd")
	:major-modes '(c++-mode)
	:server-id 'clangd))

(add-hook 'python-mode-hook 'lsp)
(add-hook 'c-mode-hook 'lsp)
(add-hook 'c++-mode-hook 'lsp)

;; GLSL

(require 'glsl-mode)
(add-to-list 'auto-mode-alist '("\\.vert\\'" . glsl-mode))
(add-to-list 'auto-mode-alist '("\\.frag\\'" . glsl-mode))

(setq backup-directory-alist `(("." . "~/.saves")))

(setq backup-by-copying t)

(global-auto-revert-mode t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
	("76c5b2592c62f6b48923c00f97f74bcb7ddb741618283bdb2be35f3c0e1030e3" default)))
 '(flycheck-checker-error-threshold 1024)
 '(package-selected-packages
   (quote
	(glsl-mode markdown-mode lsp-mode evil-leader cmake-mode bind-key projectile company ivy ## zenburn-theme evil))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(provide 'init)

;;; Init ends here
