;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

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
(setq display-line-numbers-type 'relative)
(setq +evil-want-o/O-to-continue-comments nil)
(setq
doom-font (font-spec :family "JetBrains Mono Medium Nerd Font"))

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(xterm-mouse-mode 1)
(xclip-mode 1)

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

;; custom keybindings
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

;; org-mode move-up/down
(after! :map org-mode-map
  :n "M-j" #'org-metadown
  :n "M-k" #'org-metaup)
;; plugins config

(after! projectile
 (setq projectile-project-search-path '("~/" ("~/Documents/" . 2)  "~/Documents/houseAtreides/" "~/zettelkasten/" "~/.config/")))
(after! hl-todo
  (setq hl-todo-keyword-faces
                `(("TODO"       warning bold)
                ("FIXME"      error bold)
                ("HACK"       font-lock-constant-face bold)
                ("REVIEW"     font-lock-keyword-face bold)
                ("NOTE"       success bold)
                ("DEPRECATED" font-lock-doc-face bold))))
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

(use-package k8s-mode
  :ensure t
  :hook (k8s-mode . yas-minor-mode))

(after! restclient (require 'gnutls)) ;;https://github.com/doomemacs/doomemacs/issues/6073

;; mail client  (FIXME not workinbs)
;; https://shom.dev/posts/20220108_setting-up-protonmail-in-emacs/
(after! mu4e
  :ensure t
        (setq mu4e-maildir "~/.mail"
        mu4e-attachment-dir "~/Downloads")

        (setq user-mail-address "henri-vandersleyen@protonmail.com"
        user-full-name  "Henri Vandersleyen")

        ;; Get mail
        (setq mu4e-get-mail-command "mbsync protonmail"
        mu4e-change-filenames-when-moving t   ; needed for mbsync
        mu4e-update-interval 120)             ; update every 2 minutes

        ;; Send mail
        (setq message-send-mail-function 'smtpmail-send-it
        smtpmail-auth-credentials "~/.authinfo.gpg"
        smtpmail-smtp-server "127.0.0.1"
        smtpmail-stream-type 'starttls
        smtpmail-smtp-service 1025)

        (add-to-list 'gnutls-trustfiles (expand-file-name "~/.config/protonmail/bridge/cert.pem")))
;; devops
(use-package kubernetes
  :defer
  :commands (kubernetes-overview))
(use-package kubernetes-evil
  :defer
  :after kubernetes)
(map! :leader
      (:prefix "o"
        :desc "Kubernetes" "K" 'kubernetes-overview))
;; fun
;; FIXME really janky and keybindings not workings
;; https://github.com/vibhavp/emacs-xkcd/blob/master/xkcd.el
(after! xkcd
  :enable t)
(map! :leader
      (:prefix "o"
        :desc "Kubernetes" "x" 'xkcd))
(defun xkcd-kill-buffer ()
        "kill the xkcd buffer"
        (interactive)
        (kill-buffer "xkcd"))

(map! :leader
      (:prefix "o"
        :desc "image-dired" "i" 'image-dired))
(setq org-src-fontify-natively t) ;;https://stackoverflow.com/questions/10642888/syntax-highlighting-within-begin-src-block-in-emacs-orgmode-not-working

;; https://gist.github.com/jordangarrison/8720cf98126a1a64890b2f18c1bc69f5
(use-package! python-black
  :demand t
  :after python
  :config
  (add-hook! 'python-mode-hook #'python-black-on-save-mode)
  ;; Feel free to throw your own personal keybindings here
  (map! :leader :desc "Blacken Buffer" "m b b" #'python-black-buffer)
  (map! :leader :desc "Blacken Region" "m b r" #'python-black-region)
  (map! :leader :desc "Blacken Statement" "m b s" #'python-black-statement)
)
