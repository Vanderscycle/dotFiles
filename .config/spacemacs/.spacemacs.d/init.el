;; -*- mode: emacs-lisp; lexical-binding: t -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

;; TODO:
;;lua works (required https://nix.dev/guides/faq#how-to-run-non-nix-executables)
;; python works w/ black
;; ts/js too

(defun dotspacemacs/layers ()
  "Layer configuration:
This function should only modify configuration layer settings."

  (let ((config-dir "~/.spacemacs.d/"))
    (load-file (concat config-dir "layers.el"))
    )
  )

(defun dotspacemacs/init ()
  "Initialization:
This function is called at the very beginning of Spacemacs startup,
before layer configuration.
It should only modify the values of Spacemacs settings."

  (let ((config-dir "~/.spacemacs.d/"))
    (load-file (concat config-dir "options.el"))
    )
  )

(defun dotspacemacs/user-env ()
  "Environment variables setup.
This function defines the environment variables for your Emacs session. By
default it calls `spacemacs/load-spacemacs-env' which loads the environment
variables declared in `~/.spacemacs.env' or `~/.spacemacs.d/.spacemacs.env'.
See the header of this file for more information."
  (spacemacs/load-spacemacs-env)
  )

(defun dotspacemacs/user-init ()
  "Initialization for user code:
This function is called immediately after `dotspacemacs/init', before layer
configuration.
It is mostly for variables that should be set before packages are loaded.
If you are unsure, try setting them in `dotspacemacs/user-config' first."
  )


(defun dotspacemacs/user-load ()
  "Library to load while dumping.
This function is called only while dumping Spacemacs configuration. You can
`require' or `load' the libraries of your choice that will be included in the
dump."
  )


(defun dotspacemacs/user-config ()
  "Configuration for user code:
This function is called at the very end of Spacemacs startup, after layer
configuration.
Put your configuration code here, except for variables that should be set
before packages are loaded."
  (let ((user-config-dir "~/.spacemacs.d/user/"))
    (load-file (concat user-config-dir "general.el"))
    (load-file (concat user-config-dir "custom_func.el"))
    (load-file (concat user-config-dir "org/org.el"))
    (load-file (concat user-config-dir "org/style.el"))
    (load-file (concat user-config-dir "ssh.el"))
    )
  )

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
This is an auto-generated function, do not modify its content directly, use
Emacs customize menu instead.
This function is called at the very end of Spacemacs initialization."
  (custom-set-variables
   ;; custom-set-variables was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   '(custom-enabled-themes '(catppuccin))
   '(custom-safe-themes
     '("3793b8a8e626a24a8e6aaba21a055473990bd7f2fb69c23e75bb07014d1007c8"
       "9af2b1c0728d278281d87dc91ead7f5d9f2287b1ed66ec8941e97ab7a6ab73c0"
       "01f347a923dd21661412d4c5a7c7655bf17fb311b57ddbdbd6fce87bd7e58de6" default))
   '(ignored-local-variable-values '((smie-indent-basic . 2)))
   '(package-selected-packages
     '(a ace-jump-helm-line ace-link ace-pinyin add-node-modules-path
         aggressive-indent aio alert all-the-icons anaconda-mode auctex
         auto-compile auto-dictionary auto-highlight-symbol auto-yasnippet blacken
         browse-at-remote bui calfw-org catppuccin-theme centered-cursor-mode
         chinese-conv chinese-word-at-point clean-aindent-mode closql code-cells
         code-review color-identifiers-mode column-enforce-mode company
         company-anaconda company-auctex company-emoji company-math
         company-nixos-options company-reftex company-shell concurrent consult
         ctable cython-mode dap-mode deferred define-word devdocs diff-hl diminish
         dired-quick-sort disable-mouse docker dockerfile-mode doom-modeline
         doom-themes dotenv-mode drag-stuff drupal-mode dumb-jump eat editorconfig
         elisp-def elisp-demos elisp-slime-nav ellama emacsql
         emoji-cheat-sheet-plus emojify emr epc esh-help eshell-prompt-extras
         eshell-z eval-sexp-fu evil-anzu evil-args evil-cleverparens
         evil-collection evil-easymotion evil-escape evil-evilified-state
         evil-exchange evil-goggles evil-iedit-state evil-indent-plus evil-lion
         evil-lisp-state evil-matchit evil-mc evil-nerd-commenter evil-numbers
         evil-org evil-surround evil-tex evil-textobj-line evil-tutor
         evil-unimpaired evil-visual-mark-mode evil-visualstar
         exec-path-from-shell expand-region eyebrowse fancy-battery fcitx fic-mode
         find-by-pinyin-dired fish-mode flx-ido flycheck-bashate flycheck-elsa
         flycheck-golangci-lint flycheck-package flycheck-pos-tip flyspell-correct
         flyspell-correct-helm flyspell-popup font-utils forge gh-md ghub git-link
         git-messenger git-modes git-timemachine gitignore-templates gntp gnuplot
         go-eldoc go-fill-struct go-gen-test go-guru go-impl go-mode go-rename
         go-tag godoctor golden-ratio google-translate gptel helm-ag
         helm-c-yasnippet helm-comint helm-company helm-descbinds helm-git-grep
         helm-ls-git helm-lsp helm-make helm-mode-manager helm-mu
         helm-nixos-options helm-org helm-org-rifle helm-projectile helm-purpose
         helm-pydoc helm-spotify-plus helm-swoop helm-themes helm-xref hide-comnt
         highlight-indentation highlight-numbers highlight-parentheses hl-todo
         holy-mode htmlize hungry-delete hybrid-mode importmagic indent-guide
         info+ insert-shebang inspector js-doc js2-mode js2-refactor json-mode
         json-navigator json-reformat json-snatcher ligature link-hint
         live-py-mode livid-mode llm load-env-vars log4e lorem-ipsum lsp-docker
         lsp-latex lsp-mode lsp-origami lsp-pyright lsp-tailwindcss lsp-treemacs
         lsp-ui lua-mode macrostep magit magit-section markdown-mode markdown-toc
         math-symbol-lists multi multi-line multi-term multi-vterm
         multiple-cursors nameless names nerd-icons nix-mode nix-ts-mode
         nixos-options nodejs-repl npm-mode nyan-mode ob-go ob-typescript
         open-junk-file org org-category-capture org-cliplink org-contrib
         org-download org-drill org-mime org-pomodoro org-present
         org-project-capture org-projectile org-rich-yank org-roam org-roam-ui
         org-superstar orgit orgit-forge origami overseer pangu-spacing paradox
         password-generator pcache pcre2el persist persistent-soft
         php-auto-yasnippets php-mode phpunit pinyinlib pip-requirements pipenv
         pippel plz plz-event-source plz-media-type poetry pomm popper popwin
         pos-tip prettier-js py-isort pydoc pyenv-mode pyim pyim-basedict pylookup
         pytest pythonic pyvenv quickrun rainbow-delimiters rainbow-identifiers
         rainbow-mode reformatter request restart-emacs shell-pop shfmt
         shrink-path simple-httpd skewer-mode smeargle sops space-doc spaceline
         spacemacs-purpose-popwin spacemacs-whitespace-cleanup sphinx-doc spotify
         sqlite3 string-edit-at-point string-inflection svg-lib svg-tag-mode
         symbol-overlay symon term-cursor terminal-here toc-org toml-mode
         transient treemacs-all-the-icons treemacs-evil treemacs-icons-dired
         treemacs-magit treemacs-persp treemacs-projectile treepy typescript-mode
         ucs-utils undo-fu undo-fu-session unicode-fonts uuidgen valign
         vi-tilde-fringe vim-powerline vmd-mode volatile-highlights vterm vundo
         web-beautify web-mode websocket which-key winum with-editor
         writeroom-mode ws-butler xkcd xr xref yaml yaml-mode yapfify yasnippet
         yasnippet-snippets youdao-dictionary)))
  (custom-set-faces
   ;; custom-set-faces was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   '(treemacs-hl-line-face ((t (:background "#e64553")))))
  )
