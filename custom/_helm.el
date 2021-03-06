(require 'helm)
(require 'helm-grep)
(require 'helm-files)
(require 'helm-descbinds)
(require 'helm-eshell)
(require 'helm-config)
(require 'helm-projectile)


(setq helm-command-prefix-key "C-c h")
(global-set-key (kbd "M-p") 'helm-projectile-find-file)
(global-set-key (kbd "M-P") 'helm-M-x)
(global-set-key (kbd "M-x") 'kill-region)
(global-set-key (kbd "M-R") 'helm-etags-select)

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

;; See https://github.com/bbatsov/prelude/pull/670 for a detailed
;; discussion of these options.
(setq helm-quick-update t
      helm-split-window-in-side-p t
      helm-buffers-fuzzy-matching t
      helm-M-x-fuzzy-match t
      helm-apropos-fuzzy-match t
      helm-file-cache-fuzzy-match t
      helm-locate-fuzzy-match t
      helm-projectile-fuzzy-match t
      helm-recentf-fuzzy-match t
      helm-move-to-line-cycle-in-source t
      helm-ff-search-library-in-sexp t
      helm-exit-idle-delay 0
      helm-ff-file-name-history-use-recentf t)

;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.

(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

(define-key helm-command-map (kbd "o") 'helm-occur)
(define-key helm-command-map (kbd "g") 'helm-do-grep)
(define-key helm-command-map (kbd "C-c w") 'helm-wikipedia-suggest)
(define-key helm-command-map (kbd "SPC") 'helm-all-mark-rings)
(define-key helm-grep-mode-map (kbd "RET") 'helm-grep-mode-jump-other-window)
(define-key helm-grep-mode-map (kbd "n") 'helm-grep-mode-jump-other-window-forward)
(define-key helm-grep-mode-map (kbd "p") 'helm-grep-mode-jump-other-window-backward)

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-x C-f") 'helm-find-files)

(define-key minibuffer-local-map (kbd "C-c C-l") 'helm-minibuffer-history)

;; shell history.
(define-key shell-mode-map (kbd "C-c C-l") 'helm-comint-input-ring)

;; use helm to list eshell history
(add-hook 'eshell-mode-hook
          #'(lambda ()
              (substitute-key-definition 'eshell-list-history 'helm-eshell-history eshell-mode-map)))

(substitute-key-definition 'find-tag 'helm-etags-select global-map)
(setq projectile-completion-system 'helm)
(helm-descbinds-mode)
(helm-mode 1)
