(setq-default
 ;; Base distribution to use. This is a layer contained in the directory
 ;; `+distribution'. For now available distributions are `spacemacs-base'
 ;; or `spacemacs'. (default 'spacemacs)
 dotspacemacs-distribution 'spacemacs

 ;; Lazy installation of layers (i.e. layers are installed only when a file
 ;; with a supported type is opened). Possible values are `all', `unused'
 ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
 ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
 ;; lazy install any layer that support lazy installation even the layers
 ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
 ;; installation feature and you have to explicitly list a layer in the
 ;; variable `dotspacemacs-configuration-layers' to install it.
 ;; (default 'unused)
 dotspacemacs-enable-lazy-installation 'unused

 ;; If non-nil then Spacemacs will ask for confirmation before installing
 ;; a layer lazily. (default t)
 dotspacemacs-ask-for-lazy-installation t

 ;; List of additional paths where to look for configuration layers.
 ;; Paths must have a trailing slash (i.e. "~/.mycontribs/")
 dotspacemacs-configuration-layer-path '()

 ;; List of configuration layers to load.
 dotspacemacs-configuration-layers
 '(
   ;; ----------------------------------------------------------------
   ;; Example of useful layers you may want to use right away.
   ;; Uncomment some layer names and press `SPC f e R' (Vim style) or
   ;; `M-m f e R' (Emacs style) to install them.
   ;; ----------------------------------------------------------------
   auto-completion
   better-defaults
   emacs-lisp
   git ;; maggit
   helm
   docker
   ;; (chinese :variables
   ;;          chinese-default-input-method 'pinyin
   ;;          chinese-use-fcitx5 t
   ;;          chinese-enable-fcitx t
   ;;          chinese-enable-youdao-dict t)
   spotify ;; of course there's a plugin for that
   ;; (mu4e :variables
   ;;       mu4e-installation-path (executable-find "mu")) ;; email client
   (nixos :variables
          nix-backend 'lsp
          nixos-format-on-save t) ;; I DECLARE LINUX!!!
   (lsp :variables
        lsp-lens-enable t
        lsp-enable-snippet t
        lsp-ui-doc-position 'at-point
        lsp-ui-doc-show-with-cursor t
        lsp-ui-doc-include-signature t) ;; share the love between editors
   prettier ;; you are as pretty as the first day I laid eyes on you
   html
   (javascript :variables
               javascript-backend 'lsp
               javascript-fmt-tool 'prettier
               javascript-lsp-linter 'esling
               javascript-import-tool 'import-js
               javascript-fmt-on-save t
               node-add-modules-path t) ;; everything that can be written in js will be written in js
   (typescript :variables
               typescript-backend 'lsp
               typescript-fmt-tool 'prettier
               typescript-linter 'eslint
               typescript-fmt-on-save t
               ) ;; js but like better?
   (php :variables php-backend 'lsp) ;; personal home programming says what?
   (python :variables
           python-format-on-save t
           python-formatter 'black
           python-sort-imports-on-save t
           python-backend 'lsp) ;; ai slop fest enabler
   (org :variables
        org-enable-roam-protocol t
        org-enable-roam-ui t
        org-enable-roam-support t) ;; ride the unicorn
   (treemacs :variables
             treemacs-use-all-the-icons-theme t ;; don't forget to run all-the-icons-install-font
             treemacs-use-git-mode 'deferred) ;; a file system is much like a tree
   markdown ;; mark that down Patrick!
   (latex :variables
          latex-enable-auto-fill t
          latex-enable-folding t
          latex-view-pdf-in-split-window t
          latex-backend 'lsp
          latex-refresh-preview t
          lsp-latex-build-on-save t
          latex-build-command "LaTeX") ;; oh baby its time to go even beyond
   pdf ;; refusing to pay adobe is morally right
   svelte ;; frontend-for-hipsters
   (vue :variables
        vue-backend 'lsp
        vue-lsp-client 'vls)
   (yaml :variables
         yaml-enable-lsp t) ;; evil clearly fomatted
   toml  ;; what if we tried yet another std
   (json :variables
         json-fmt-tool 'prettier
         json-fmt-on-save t) ;; the prefered backend/frontend love letter format
   multiple-cursors
   (shell :variables
          shell-default-height 30
          shell-default-position 'bottom) ;; my home
   (shell-scripts :variables
                  shell-scripts-backend 'lsp) ;; shellcheck it
   version-control
   (spell-checking :variables
                   spell-checking-enable-by-default nil
                   enable-flyspell-auto-completion t);; spell right for once
   (syntax-checking :variables
                    syntax-checking-enable-by-default t) ;; like spelling proprely
   colors
   xkcd ;; a touch of humour
   (llm-client :variables
               llm-client-enable-gptel t) ;; ai client
   (unicode-fonts :variables
                  unicode-fonts-enable-ligatures t) ;; ascii is so o 1970
   treemacs)


 ;; List of additional packages that will be installed without being wrapped
 ;; in a layer (generally the packages are installed only and should still be
 ;; loaded using load/require/use-package in the user-config section below in
 ;; this file). If you need some configuration for these packages, then
 ;; consider creating a layer. You can also put the configuration in
 ;; `dotspacemacs/user-config'. To use a local version of a package, use the
 ;; `:location' property: '(your-package :location "~/path/to/your-package/")
 ;; Also include the dependencies as they will not be resolved automatically.
 dotspacemacs-additional-packages '(
                                    (popper
                                     :ensure t)
                                    ag
                                    rg
                                    ob-typescript ;; for org babel
                                    (nix-ts-mode
                                     :mode "\\.nix\\'"
                                     :config
                                     (let ((home-dir (if (eq system-type 'gnu/linux)
                                                         "/home/henri/Documents"
                                                       "/Users/henri.vandersleyen/Documents")))
                                       (setq lsp-nix-nixd-home-manager-options-expr
                                             (format "(builtins.getFlake \"%s/dotFiles/nix-darwin\").darwinConfigurations.\"henri-MacBook-Pro\".options.home-manager" home-dir))
                                       (setq lsp-nix-nixd-nixos-options-expr
                                             (format "(builtins.getFlake \"%s/dotFiles/nix-darwin\").darwinConfigurations.\"henri-MacBook-Pro\".options" home-dir))
                                       (setq lsp-nix-nixd-nixpkgs-expr "import <nixpkgs> { }")))
                                    (sops
                                     :recipe (:type git :host github :repo "djgoku/sops"))
                                    catppuccin-theme
                                    sqlite3
                                    (exec-path-from-shell
                                     :ensure t
                                     :config
                                     (exec-path-from-shell-initialize))
                                    pomm ;; pommodero
                                    )

 ;; A list of packages that cannot be updated.
 dotspacemacs-frozen-packages '()

 ;; A list of packages that will not be installed and loaded.
 dotspacemacs-excluded-packages '()

 ;; Defines the behaviour of Spacemacs when installing packages.
 ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
 ;; `used-only' installs only explicitly used packages and deletes any unused
 ;; packages as well as their unused dependencies. `used-but-keep-unused'
 ;; installs only the used packages but won't delete unused ones. `all'
 ;; installs *all* packages supported by Spacemacs and never uninstalls them.
 ;; (default is `used-only')
 dotspacemacs-install-packages 'used-only)
