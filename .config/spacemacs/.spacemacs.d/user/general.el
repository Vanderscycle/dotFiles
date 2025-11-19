;;INFO: in macos, you can increase the repeat rate of keys
;; M-x nerd-icons-install-fonts to fix doom-emacs status line
(add-to-list 'exec-path "/etc/profiles/per-user/henri.vandersleyen/bin")
(spacemacs/set-leader-keys "SPC" 'helm-M-x)
(setq user-mail-address "henri-vandersleyen@protonmail.com")
;; --- theme ---
(setq catppuccin-flavor 'mocha)
;; --- elisp ---
(defun mp-elisp-mode-eval-buffer ()
  (interactive)
  (message "--- Evaluated buffer ---\n")
  (eval-buffer))

(define-key emacs-lisp-mode-map (kbd "C-c C-c") #'mp-elisp-mode-eval-buffer)
(define-key lisp-interaction-mode-map (kbd "C-c C-c") #'mp-elisp-mode-eval-buffer)

;; --- shell ---
(spacemacs/set-leader-keys "osp" 'shell-pop)
;; --- bookmarks ---
(spacemacs/set-leader-keys "obs" 'bookmark-set)
(spacemacs/set-leader-keys "obj" 'bookmark-jump)
(spacemacs/set-leader-keys "obj" 'bookmark-locate) ;; file path
;; --- marks ---

;; --- misc problems ---
(when (fboundp 'electric-indent-mode) (electric-indent-mode -1)) ;; disables auto indent on new lines
(setq-default spacemacs-yank-indent-threshold 0) ;; disables auto indent on pasting
(setq-default word-wrap t)
;; --- popper ---
;; --- vue ---
;; --- maggit ---
;; smerge
(defhydra hydra/smerge
  (:color pink :hint nil :post (smerge-auto-leave))
  "
^Move^       ^Keep^               ^Diff^                 ^Other^
^^-----------^^-------------------^^---------------------^^-------
_n_ext       _b_ase               _<_: upper/base        _C_ombine
_p_rev       _u_pper              _=_: upper/lower       _r_esolve
^^           _l_ower              _>_: base/lower        _k_ill current
^^           _a_ll                _R_efine
^^           _RET_: current       _E_diff
"
  ("n" smerge-next :red)
  ("p" smerge-prev :red)
  ("b" smerge-keep-base)
  ("u" smerge-keep-upper)
  ("l" smerge-keep-lower)
  ("a" smerge-keep-all)
  ("RET" smerge-keep-current)
  ("\C-m" smerge-keep-current)
  ("<" smerge-diff-base-upper)
  ("=" smerge-diff-upper-lower)
  (">" smerge-diff-base-lower)
  ("R" smerge-refine)
  ("E" smerge-ediff)
  ("C" smerge-combine-with-next)
  ("r" smerge-resolve)
  ("k" smerge-kill-current)
  ("q" nil "cancel" :color blue))

(spacemacs/set-leader-keys "ogm" 'hydra/smerge/body)

;; --- pomm ---
(setq pomm-audio-enabled t)
(setq pomm-audio-player-executable "aplay")
;; --- llm/ai ---
(defun get-deepseek-api-key ()
  "Retrieve DeepSeek API key from ~/.authinfo."
  (let ((auth-info (auth-source-search :host "api.deepseek.com" :max 1)))
    (when auth-info
      (let ((secret (plist-get (car auth-info) :secret)))
        (if (functionp secret)
            (funcall secret)
          secret)))))

;; Usage
(setq deepseek-api-key (get-deepseek-api-key))
(gptel-make-deepseek "DeepSeek"       ;Any name you want
  :stream t                           ;for streaming responses
  :key "")
;; --- editorconfig ---
(editorconfig-mode 1)
;; --- tailwindcss ---
(setq lsp-tailwindcss-add-on-mode t)
;; --- js/ts ---
(setq-default
 ;; js2-mode
 js2-basic-offset 2
 ;; web-mode
 css-indent-offset 2
 web-mode-markup-indent-offset 2
 web-mode-css-indent-offset 2
 web-mode-code-indent-offset 2
 web-mode-attr-indent-offset 2)
;; --- projectile ---
(setq projectile-project-search-path '("~/knak/packages/" "~/Documents/"))
(spacemacs/set-leader-keys "ps" 'projectile-discover-projects-in-search-path)
(spacemacs/set-leader-keys "p/" 'projectile-ag)
(spacemacs/set-leader-keys "pk" 'projectile-remove-known-project)
(setq projectile-enable-caching t)

;; --- babel ---
(define-derived-mode ts-mode typescript-mode "ts"
  "Major mode for editing typescipt src blocks in org mode.")
(org-babel-do-load-languages
 'org-babel-load-languages
 '((typescript . t)))  ;; Enable TypeScript support

;; --- hl-todo ---
(with-eval-after-load 'hl-todo
  (add-to-list 'hl-todo-keyword-faces '("WARN" . "#FAB387"))  ;; Catppuccin Peach
  (add-to-list 'hl-todo-keyword-faces '("FIX" . "#F38BA8"))  ;; Catppuccin Red
  (add-to-list 'hl-todo-keyword-faces '("INFO" . "#89DCEB"))) ;; Catppuccin Sky
;; --- lsp ---
(add-hook 'python-mode-hook #'lsp)
(add-hook 'typescript-mode-hook #'lsp)
(add-hook 'js-mode-hook #'lsp)
(add-hook 'json-mode-hook #'lsp)
;; prevents refactor move
(setq lsp-auto-execute-action nil)
;; --- helm ---
;; (setq helm-follow-mode-persistent t) ;; automatically preview files but opens them as a buffer
;; --- perspective ---
(spacemacs/set-leader-keys "olk" 'spacemacs/helm-persp-kill)
;; --- sops --
;; https://github.com/djgoku/sops
(spacemacs/set-leader-keys "oSe" 'sops-edit-file)
(spacemacs/set-leader-keys "oSs" 'sops-save-file)
(spacemacs/set-leader-keys "oSc" 'sops-cancel)
(global-sops-mode 1)
;; --- which-key --
(which-key-add-key-based-replacements
  "SPC o S" "sops"
  "SPC o o" "org"
  "SPC o o r" "org-roam"
  "SPC o l" "persp")
;; --- treemacs ---
(custom-set-faces
 '(treemacs-hl-line-face ((t (:background "#e64553")))))
(with-eval-after-load 'treemacs
  (defun treemacs-ignore-node-modules (folder _)
    (string= folder "node_modules"))
  (push #'treemacs-ignore-node-modules treemacs-ignored-file-predicates))
;; --- latex ---
(add-hook 'LaTeX-mode-hook
          (defun fn/latex-compile-on-save ()
            (add-hook 'after-save-hook (lambda () (TeX-command-run-all nil)) nil t)))
;; --- dired ---
(setq dired-kill-when-opening-new-dired-buffer t)
