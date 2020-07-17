;;; Package --- Summary:
;;; GNU Emacs init config

;;; Commentary:
;;; It sure is messy

;;; Code:

;; Personal Info
(setq user-full-name "Lev Polyakov"
      user-mail-address "SunGrow@tuta.io")

;; Set up package.el to work with MELPA
(require 'package)
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")
			 ("melpa-stable" . "https://stable.melpa.org/packages/")
			 ("org" . "http://orgmode.org/elpa")))
(package-initialize)
(unless package-archive-contents (package-refresh-contents))

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

;; Startup Buffer to blanc buffer screen
(setq inhibit-startup-screen t)

;; Theme init
(unless (package-installed-p 'zenburn-theme)
  (package-install 'zenburn-theme))
(require 'zenburn-theme)

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
      	("zenburn-bg+1"     . "#3D3D3A") ; Left and Right borders
    	("zenburn-yellow"   . "#F1E0AF") ; Status line curr file name and Menu Highlight
    	("zenburn-green-2"  . "#8F7B3F") ; Comment semicolumn
    	("zenburn-green"    . "#8F8B3B") ; Comment text
    	("zenburn-green+1"  . "#0F0F0F") ; Status line Side text
       	))
;; Set Theme
(load-theme 'zenburn t)

;; General Keybindings
(global-set-key (kbd "C-x C-b") 'buffer-menu)

;; Evil

;; Enable Evil
(unless (package-installed-p 'evil)
  (package-install 'evil))
(unless (package-installed-p 'evil-leader)
  (package-install 'evil-leader))

(require 'evil)
(require 'evil-leader)

(evil-leader/set-leader "<SPC>")
(global-evil-leader-mode t)
(evil-mode 1)

;; Enable Ivy
(unless (package-installed-p 'ivy)
  (package-install 'ivy))
(require 'ivy)
(ivy-mode 1) ; Because I don't like helm

;; Ivy keybindings
(define-key ivy-minibuffer-map (kbd "C-k") #'ivy-previous-line)
(define-key ivy-minibuffer-map (kbd "C-j") #'ivy-next-line)
(define-key ivy-minibuffer-map (kbd "C-l") #'ivy-alt-done)

(define-key ivy-minibuffer-map (kbd "C-h") #'ivy-kill-line)
(define-key ivy-switch-buffer-map (kbd "C-h") #'ivy-switch-buffer-kill)
(define-key ivy-switch-buffer-map (kbd "C-k") #'ivy-previous-line)

;;; General Project Development

;; Enable Projectile
(unless (package-installed-p 'projectile)
  (package-install 'projectile))
(require 'projectile)
(projectile-mode +1)

(setq projectile-project-search-path '("~/Documents/" "/Users/LazyF/Documents" "~/Projects/"))
(setq projectile-completion-system 'ivy)

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

(unless (package-installed-p 'auto-complete-clang)
  (package-install 'auto-complete-clang))

;; MaGit
;; Too slow on Windows to use.


;; CMake

(require 'cmake-mode)

;; Irony

(unless (package-installed-p 'irony)
  (package-install 'irony))
(unless (package-installed-p 'company-irony)
  (package-install 'company-irony))
(unless (package-installed-p 'company-irony-c-headers)
  (package-install 'company-irony-c-headers))
(unless (package-installed-p 'flycheck-irony)
  (package-install 'flycheck-irony))
(require 'irony)
(require 'company-irony)
(require 'company-irony-c-headers)
(require 'flycheck-irony)

(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)

(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))

(eval-after-load 'company
  '(add-to-list 'company-backends 'company-irony))

;; Windows performance tweaks

(when (boundp 'w32-pipe-read-delay)
  (setq w32-pipe-read-delay 0))

;; Set the buffer size to 64K on Windows (from the original 4K)
(when (boundp 'w32-pipe-buffer-size)
  (setq irony-server-w32-pipe-buffer-size (* 64 1024)))


;; Company mode

(add-hook 'after-init-hook 'global-company-mode)
(require 'company)
(setq company-minimum-prefix-length 1
      company-idle-delay 0.0) ;; default is 0.2

(eval-after-load 'company
  '(add-to-list 'company-backends 'company-irony-c-headers))

;; RTags

(unless (package-installed-p 'rtags)
  (package-install 'rtags))
(unless (package-installed-p 'ivy-rtags)
  (package-install 'ivy-rtags))
(unless (package-installed-p 'flycheck-rtags)
  (package-install 'flycheck-rtags))
(unless (package-installed-p 'company-rtags)
  (package-install 'company-rtags))

(require 'rtags)
(require 'ivy-rtags)
(require 'flycheck-rtags)
(require 'company-rtags)

(add-hook 'c-mode-hook 'rtags-start-process-unless-running)
(add-hook 'c++-mode-hook 'rtags-start-process-unless-running)
(add-hook 'objc-mode-hook 'rtags-start-process-unless-running)

(setq rtags-display-result-backend 'ivy)
(push 'company-rtags company-backends)

;; CMake-IDE

(unless (package-installed-p 'cmake-ide)
  (package-install 'cmake-ide))
(require 'cmake-ide)
(cmake-ide-setup)

(setq cmake-ide-build-dir (concat cmake-ide-project-dir "build"))
;; Disassemble

(unless (package-installed-p 'disaster)
  (package-install 'disaster))
(require 'disaster)

;; Company keybindings

(define-key company-active-map (kbd "C-j") #'company-select-next)
(define-key company-active-map (kbd "C-k") #'company-select-previous)


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
   "v" 'vc-prefix-map
   ;; lsp keybindings
   "l l" 'lsp
   "l r" 'lsp-rename
   "g d" 'lsp-find-definition
   ;; rtags keybindings
   "r h" 'rtags-location-stack-back
   "r l" 'rtags-location-stack-forward
   "r p" 'rtags-previous-match
   "r n" 'rtags-next-match
   "r r" 'rtags-rename-symbol
   "r ." 'rtags-find-symbol-at-point
   "r ," 'rtags-find-references-at-point
   "r /" 'rtags-find-all-references-at-point
   "r >" 'rtags-find-symbol
   "r <" 'rtags-find-references
   "r c" 'rtags-compile-file
   "r i" 'rtags-symbol-info
   ;; cmake-ide keybindings
   "i i" 'cmake-ide-maybe-start-rdm
   "i r" 'cmake-ide-maybe-run-cmake
   "i c" 'cmake-ide-compile
   ;; flycheck keybindings
   "f h" 'flycheck-previous-error
   "f l" 'flycheck-next-error
   ;; disassemble keybindings
   "d d" 'disaster
   )


(define-key vc-prefix-map (kbd "p") #'vc-pull)

;; Debug
(setq gdb-show-main t)
(setq gdb-many-windows 1)



;; Python

(require 'elpy)
(elpy-enable)


(add-hook 'python-mode-hook
      (lambda ()
        (setq indent-tabs-mode t)
        (setq tab-width 4)
        (setq python-indent-offset 4)))



;; FlyCheck

(require 'flycheck)
(global-flycheck-mode)

;; CMake-utils
(unless (package-installed-p 'cpputils-cmake)
  (package-install 'cpputils-cmake))
(require 'cpputils-cmake)

(add-hook 'c-mode-common-hook
		  (lambda ()
			(if (derived-mode-p 'c-mode 'c++-mode)
				(cppcm-reload-all)
			  )))
;; OPTIONAL, avoid typing full path when starting gdb
(global-set-key (kbd "C-c C-g")
				'(lambda ()(interactive) (gud-gdb (concat "gdb -i=mi --fullname " (cppcm-get-exe-path-current-buffer)))))
(evil-leader/set-key(kbd "g g")
				'(lambda ()(interactive) (gdb (concat "gdb -i=mi " (cppcm-get-exe-path-current-buffer) ))))
;; OPTIONAL, some users need specify extra flags forwarded to compiler
(setq cppcm-extra-preprocss-flags-from-user '("-I/usr/src/linux/include" "-DNDEBUG"))
;; Avoid system files scan
(add-hook 'c-mode-common-hook
          (lambda ()
            (if (derived-mode-p 'c-mode 'c++-mode)
                (if  (not (or (string-match "^/usr/local/include/.*" buffer-file-name)
                              (string-match "^/usr/src/linux/include/.*" buffer-file-name)))
                    (cppcm-reload-all))
              )))

;; LSP mode

(setq gc-cons-threshold 100000000)

(setq read-process-output-max (* 1024 1024)) ; 1mb


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
	(cpputils-cmake glsl-mode markdown-mode lsp-mode evil-leader cmake-mode bind-key projectile company ivy ## zenburn-theme evil))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(provide 'init)

;;; Init ends here
