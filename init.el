;; Set up package.el to work with MELPA
(require 'package)
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")
			 ("org" . "http://orgmode.org/elpa")))
(package-initialize)
;; (package-refresh-contents)

;; Package Download

(defun init-packages ()
	"Init config packages"
	( 
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
	)
	(interactive "r")
)

;; Looks setup

(set-frame-font "JetBrains Mono 10" nil t)

;; Set tabs
(setq indent-tabs-mode t)
(setq tab-width 2)
(defvaralias 'c-basic-offset 'tab-width)
(setq-default tab-always-indent 'complete)
(defun my-insert-tab-char ()
  "Insert a tab char. (ASCII 9, \t)"
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
;;(require 'git)


;; Enable Projectile

(require 'projectile)
(projectile-mode +1)
(setq projectile-project-search-path '("/Users/LazyF/Documents"))
(setq projectile-completion-system 'ivy)

;; Enable Treemacs

(require 'treemacs)
(require 'treemacs-evil)
(require 'treemacs-projectile)

;; Company mode

(add-hook 'after-init-hook 'global-company-mode)
(require 'company)

;; CMake

(require 'cmake-mode)

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

(evil-leader/set-key
   "p" 'projectile-command-map
   "e" 'find-file
   "b" 'switch-to-buffer
   "k" 'kill-buffer)

;; Treemacs keybindings

(define-key evil-normal-state-map (kbd "C-o") nil)
(define-key evil-normal-state-map (kbd "C-o p") #'treemacs)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("76c5b2592c62f6b48923c00f97f74bcb7ddb741618283bdb2be35f3c0e1030e3" default)))
 '(package-selected-packages
   (quote
    (evil-leader cmake-mode bind-key projectile company ivy ## zenburn-theme evil))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
