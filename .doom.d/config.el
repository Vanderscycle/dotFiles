;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; NOTE: https://abdelhakbougouffa.pro/posts/config/
;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Henri Vandersleyen"
      user-mail-address "henri-vandersleyen@protonmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-tokyo-night)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
(setq display-line-numbers-type 'relative)
(setq +evil-want-o/O-to-continue-comments nil)
;;projectile config
(setq
 doom-font (font-spec :family "JetBrains Mono Medium Nerd Font"))
(after! projectile
 projectile-project-search-path '("~" "~/Documents/*"  "~/Documents/houseAtreides/" "~/zettelkasten/" "~/.config/"))


;; https://emacsredux.com/blog/2013/04/02/move-current-line-up-or-down/
(defun move-line-up ()
  "Move up the current line."
  (interactive)
  (transpose-lines 1)
  (forward-line -2)
  (indent-according-to-mode))

(defun move-line-down ()
  "Move down the current line."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1)
  (indent-according-to-mode))

(global-set-key [(control shift n)]  'move-line-down)
(global-set-key [(control shift p)]  'move-line-up)

(defun comment-or-uncomment-region-or-line ()
    "Comments or uncomments the region or the current line if there's no active region."
    (interactive)
    (let (beg end)
        (if (region-active-p)
            (setq beg (region-beginning) end (region-end))
            (setq beg (line-beginning-position) end (line-end-position)))
        (comment-or-uncomment-region beg end)
        (forward-line 1)))

(global-set-key (kbd "C-/")  'comment-or-uncomment-region-or-line)

;; TODO: remove later
(after! :map org-mode-map
  :n "M-j" #'org-metadown
  :n "M-k" #'org-metaup)

;; (when noninteractive
;;   (add-to-list 'doom-env-whitelist "^SSH_"))
;; TODO: fix magit and emacs SSH_AUTH_SOCK being M-X setenv SSH_AUTH_SOCK
;; https://github.com/doomemacs/doomemacs/issues/2434

;; custom user implementation
;;(def-package! org-super-agenda
;;  :after org-agenda
;;  :init
;;  (setq org-supe//r-agenda-groups '((:name "Today"
;;                                   :time-grid t
;;                                   :scheduled today)
;;                                  (:name "Important"
;;                                         :priority "A")))
;;  :config
;;  (org-super-agenda-mode))

;; Evil-snipe package
;; https://github.com/hlissner/evil-snipe
(evil-snipe-override-mode 1)
(add-hook 'magit-mode-hook 'turn-off-evil-snipe-override-mode)
(setq flyspell-mouse-map nil)

;; Emacs sometimes has a white flash when starting.
;;https://github.com/doomemacs/doomemacs/issues/2828
(when (daemonp)
  (remove-hook 'after-make-frame-functions #'doom-init-theme-h)
  (add-hook 'server-after-make-frame-hook #'doom-init-theme-h))

;; Fixes SSH_AUTH_SOCK not being mounted by default
(when noninteractive
  (add-to-list 'doom-env-whitelist "^SSH_" ))

(after! evil-escape
  (setq  evil-escape-delay 0.2)
  (setq evil-escape-unordered-key-sequence t))
;; WARN: This will completly change the default org-todo
(after! org
        (setq org-roam-directory "~/zettelkasten/")
        (setq org-roam-index-file "~/zettelkasten/index.org")
        (setq org-todo-keywords '((sequence "TODO(t)" "INPROGRESS(i)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)"))
                org-todo-keyword-faces
                '(("TODO" :foreground "#7c7c75" :weight normal :underline t)
                ("WAITING" :foreground "#9f7efe" :weight normal :underline t)
                ("INPROGRESS" :foreground "#0098dd" :weight normal :underline t)
                ("DONE" :foreground "#50a14f" :weight normal :underline t))
                org-agenda-files (list "~/zettelkasten/")))

;; there is a hl-todo-mode
(after! hl-todo
  (setq hl-todo-keyword-faces
                `(("TODO"       warning bold)
                ("FIXME"      error bold)
                ("HACK"       font-lock-constant-face bold)
                ("REVIEW"     font-lock-keyword-face bold)
                ("NOTE"       success bold)
                ("DEPRECATED" font-lock-doc-face bold))))
;; Insead of using iedit we use evil-multiedit
(setq fcitx-remote-command "fcitx-remote")
(after! pyim
  (setq default-input-method "pyim")
  (global-set-key (kbd "C-\\") 'toggle-input-method)
)
;; lsp (enable with K)
;; https://emacs-lsp.github.io/lsp-mode/tutorials/how-to-turn-off/

(after! lsp-mode
  (setq lsp-lens-enable t
        lsp-semantic-tokens-enable t ;; hide unreachable ifdefs
        lsp-enable-symbol-highlighting t
        lsp-headerline-breadcrumb-enable nil
        ;; LSP UI related tweaks
        lsp-ui-sideline-enable nil
        lsp-ui-sideline-show-hover nil
        lsp-ui-sideline-show-symbol nil
        lsp-ui-sideline-show-diagnostics nil
        lsp-ui-sideline-show-code-actions nil))
;; don't treat underscores as word delimeters
(defalias 'forward-evil-word 'forward-evil-symbol)
(add-hook! 'js2-mode-hook (modify-syntax-entry ?_ "w")) ;; because the above doesn't work for JS

(after! magit
  ;; makes magit prompt me for the new branch name first:
  (setq magit-branch-read-upstream-first nil))

(after! epg
  (setq epg-pinentry-mode nil))

(setq fcitx-active-evil-states '(insert emacs hybrid))
