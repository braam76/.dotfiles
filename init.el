(tool-bar-mode             0)  ;; Remove toolbar
(scroll-bar-mode           0)  ;; Remove scrollbars
(menu-bar-mode             0)  ;; Remove menu bar
(blink-cursor-mode         0)  ;; Cursor, not blinking
(column-number-mode        t)  ;; Show column numbers
(global-auto-revert-mode   t)  ;; Automatically update buffers

;; creates file where customization variables will be loaded
(setq custom-file (locate-user-emacs-file "custom-variables.el"))
(load custom-file 'noerror 'nomessage)

;; Unbind C-d for multiple-cursors
(global-unset-key (kbd "C-d"))

;; Load Elpaca setup
(load-file (expand-file-name "elpaca-setup.el" user-emacs-directory))

;; Enable use-package support for Elpaca
(elpaca elpaca-use-package
  (elpaca-use-package-mode))

;; Install and configure multiple-cursors via use-package
(use-package multiple-cursors
  :ensure t
  :bind (("C-d" . mc/mark-next-like-this)
         ("C-<f2>" . mc/mark-all-like-this)
	 ;; ("C-S-c C-S-c" . mc/edit-lines
	 ;; ("C-<" . mc/mark-previous-like-this)
	 ))
(use-package)

;; Load and apply the Noirblaze theme
(use-package noirblaze-theme
  :load-path "~/.emacs.d/themes/"
  :config
  (load-theme 'noirblaze t))
