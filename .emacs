;; emacs specific. don't need use-package 
(setq-default indent-tabs-mode nil) ; spaces on tab
(setq js-indent-level 2) ; indent level 2 spaces in .js
(tool-bar-mode -1) ; disable toolbar
(toggle-scroll-bar -1) ; disable scrollbar
(menu-bar-mode -1)  ; disable menu bar
(electric-pair-mode 1) ; electric pair for all buffers

(setq org-agenda-files '("~/.org_files"))
(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default nil) ; stop creating #autosave# files

(global-prettify-symbols-mode 1) ;; display “lambda” as “λ”

;; Add remote package archives
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(package-initialize)

;; use-package can't install itself, this will take care of that for us
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))


;; Ensures use-package will install if not already (same as :ensure t on all use-package)
(setq use-package-always-ensure t)

(use-package emmet-mode)

(use-package undo-tree)

(use-package avy
  :bind (("C-;" . avy-goto-char)))

(use-package ace-jump-mode
  :bind ("C-:" . ace-window))

(use-package js2-mode
  :mode "\\.js\\'"
  :interpreter "javascript")

(use-package expand-region
  :bind ("C-=" . er/expand-region))


(use-package rainbow-delimiters
  :init (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
  )

(use-package naquadah-theme
  :defer t
  :init (load-theme 'naquadah t))

(use-package dashboard
    :diminish dashboard-mode
    :config
    (setq dashboard-banner-logo-title "Leave the Wired better than you found it")
    (setq dashboard-image-banner-max-height 600)
    (setq dashboard-startup-banner (concat (getenv "HOME") "/Pictures/emacs_defaults/sicp.png"))
    (setq dashboard-items '((recents  . 10)
                            (agenda . 5)))
    (dashboard-setup-startup-hook))


;; These are emacs packages for command line tools. So if these 'arent working' make sure
;;  you have installed relevant tools (preferably globally)

(use-package magit) ;; this one's nasty. if you don't have git installed it won't let you into this file (potentiall all dot files)

(use-package prettier-js
  :after js2-mode
  :init
  (add-hook 'js2-mode-hook #'prettier-js-mode)
  (add-hook 'web-mode-hook #'prettier-js-mode))

(use-package xref-js2                   
  :ensure t
  :after js2-mode
  :init
  (defun add-xref-js2-backend ()
    (add-hook 'xref-backend-functions
              #'xref-js2-xref-backend nil t))

  (add-hook 'js2-mode-hook #'add-xref-js2-backend))


(use-package company
  :diminish company-mode
  :init
  (add-hook 'after-init-hook 'global-company-mode)
  :config
  (use-package company-tern
    :after js2-mode
    :init
    (progn
      (add-to-list 'company-backends 'company-tern)
      (add-hook 'js2-mode-hook #'tern-mode))
    ))

;;; Slime. gonna need a lisp (go SBCL) installed on cmdline
(use-package slime
  :defer t
  :config
  (progn
    (use-package ac-slime :ensure t)
    (setq inferior-lisp-program "sbcl")
    (slime-setup)
    (add-hook 'slime-mode-hook 'set-up-slime-ac)
    (add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
    (setq slime-protocol-version 'ignore
          slime-net-coding-system 'utf-8-unix
          slime-complete-symbol*-fancy t
          slime-complete-symbol-function 'slime-fuzzy-complete-symbol))
  :ensure t)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (company-tern company xref-js2 use-package undo-tree rainbow-delimiters prettier-js magit emmet-mode dashboard avy ace-jump-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
