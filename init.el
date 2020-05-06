;; Set up package.el to work with MELPA
(require 'package)
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")
			 ("org" . "http://orgmode.org/elpa")))
(package-initialize)
;; (package-refresh-contents)


;; Looks setup

(set-frame-font "JetBrains Mono 10" nil t)

;; Set tabs
;;(setq-default indent-tabs-mode t)
;;(setq-default tab-width 4)
;;(defvaralias 'c-basic-offset 'tab-width)

;; Disabling the menu bar
(menu-bar-mode -1) 

;; Disabling the toolbar
(tool-bar-mode -1) 

;; Disabling the scrollbar
(toggle-scroll-bar -1)

;; Turn off the beep
(setq visible-bell 1)

;; Startup Buffer Setup

(setq inhibit-startup-screen t)

;; Theme init

(require 'zenburn-theme)

;; use variable-pitch fonts for some headings and titles
(setq zenburn-use-variable-pitch t)

;; scale headings in org-mode
(setq zenburn-scale-org-headlines t)

;; scale headings in outline-mode
(setq zenburn-scale-outline-headlines t)
;; Set Theme
(load-theme 'zenburn t)


;; Evil

;; Enable Evil
(unless (package-installed-p 'evil)
  (package-install 'evil))
(require 'evil)
(evil-mode 1)

;; Enable Ivy
(unless (package-installed-p 'ivy)
  (package-install 'ivy))
(require 'ivy)
(ivy-mode 1)

;; Enable Projectile

(unless (package-installed-p 'projectile)
  (package-install 'projectile))
(require 'projectile)
(projectile-mode +1)
(setq projectile-project-search-path '("/Users/LazyF/Documents"))
(setq projectile-completion-system 'ivy)

;; Enable Treemacs

(unless (package-installed-p 'treemacs)
  (package-install 'treemacs))
(unless (package-installed-p 'treemacs-evil)
  (package-install 'treemacs-evil))
(unless (package-installed-p 'treemacs-projectile)
  (package-install 'treemacs-projectile))
(require 'treemacs)
(require 'treemacs-evil)
(require 'treemacs-projectile)

;; Company mode

(unless (package-installed-p 'company)
  (package-install 'company))
(add-hook 'after-init-hook 'global-company-mode)
(require 'company)

;; CMake

(unless (package-installed-p 'cmake-mode)
  (package-install 'cmake-mode))
(require 'cmake-mode)

;; EditorConfig
(unless (package-installed-p 'editorconfig)
  (package-install 'editorconfig))
(require 'editorconfig)
(editorconfig-mode 1)

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
    (cmake-mode bind-key projectile company ivy ## zenburn-theme evil))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
