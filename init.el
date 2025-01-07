(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'noirblaze t)

(require `package)
(add-to-list 'package-archives '("gnu"   . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(tool-bar-mode             0)  ;; Remove toolbar
(scroll-bar-mode           0)  ;; Remove scrollbars
(menu-bar-mode             0)  ;; Remove menu bar
(blink-cursor-mode         0)  ;; Cursor, not blinking
(column-number-mode        t)  ;; Show column numbers
(global-auto-revert-mode   t)  ;; Automatically update buffers


(setq inhibit-splash-screen     t)  ;; Disable splash screen


;; creates file where customization variables will be loaded
(setq custom-file (locate-user-emacs-file "custom-variables.el"))
(load custom-file 'noerror 'nomessage)

;; use packages
(use-package zig-mode :ensure t)
(use-package vterm    :ensure t)

(use-package company-mode
  :init
  (global-company-mode))

(use-package emacs
  :hook (zig-mode . eglot-ensure))
