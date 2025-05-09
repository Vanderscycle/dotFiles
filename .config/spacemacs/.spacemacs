;; -*- mode: emacs-lisp; lexical-binding: t -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Layer configuration:
This function should only modify configuration layer settings."
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
     latex ;; oh baby its time to go even beyond
     pdf ;; refusing to pay adobe is morally right
     svelte ;; frontend-for-hipsters
     (vue :variables
          vue-backend 'lsp
          vue-lsp-client 'vls)
     (yaml :variables
           yaml-enable-lsp t) ;; evil clearly fomatted
     toml  ;; what if we tried yet another std
     (json :variables
           json-fmt-on-save t
           json-fmt-tool 'prettier) ;; the prefered backend/frontend love letter format
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
                                       (setq lsp-nix-nixd-server-path "/home/henri/.nix-profile/bin/nixd")
                                       (let ((system-name (if (eq system-type 'darwin)
                                                              "henri-MacBook-Pro"
                                                            "desktop"))
                                             (config-type (if (eq system-type 'darwin)
                                                              "darwinConfigurations"
                                                            "nixosConfigurations")))
                                         (setq lsp-nix-nixd-home-manager-options-expr
                                               (format "(builtins.getFlake \"%s/Documents/dotFiles/nix-darwin\").%s.\"%s\".options.home-manager"
                                                       (getenv "HOME")
                                                       config-type
                                                       system-name))
                                         (setq lsp-nix-nixd-nixos-options-expr
                                               (format "(builtins.getFlake \"%s/Documents/dotFiles/nix-darwin\").%s.\"%s\".options"
                                                       (getenv "HOME")
                                                       config-type
                                                       system-name)))
                                       (setq lsp-nix-nixd-nixpkgs-expr "import <nixpkgs> { }"))
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
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization:
This function is called at the very beginning of Spacemacs startup,
before layer configuration.
It should only modify the values of Spacemacs settings."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non-nil then enable support for the portable dumper. You'll need to
   ;; compile Emacs 27 from source following the instructions in file
   ;; EXPERIMENTAL.org at to root of the git repository.
   ;;
   ;; WARNING: pdumper does not work with Native Compilation, so it's disabled
   ;; regardless of the following setting when native compilation is in effect.
   ;;
   ;; (default nil)
   dotspacemacs-enable-emacs-pdumper nil

   ;; Name of executable file pointing to emacs 27+. This executable must be
   ;; in your PATH.
   ;; (default "emacs")
   dotspacemacs-emacs-pdumper-executable-file "emacs"

   ;; Name of the Spacemacs dump file. This is the file will be created by the
   ;; portable dumper in the cache directory under dumps sub-directory.
   ;; To load it when starting Emacs add the parameter `--dump-file'
   ;; when invoking Emacs 27.1 executable on the command line, for instance:
   ;;   ./emacs --dump-file=$HOME/.emacs.d/.cache/dumps/spacemacs-27.1.pdmp
   ;; (default (format "spacemacs-%s.pdmp" emacs-version))
   dotspacemacs-emacs-dumper-dump-file (format "spacemacs-%s.pdmp" emacs-version)

   ;; Maximum allowed time in seconds to contact an ELPA repository.
   ;; (default 5)
   dotspacemacs-elpa-timeout 5

   ;; Set `gc-cons-threshold' and `gc-cons-percentage' when startup finishes.
   ;; This is an advanced option and should not be changed unless you suspect
   ;; performance issues due to garbage collection operations.
   ;; (default '(100000000 0.1))
   dotspacemacs-gc-cons '(100000000 0.1)

   ;; Set `read-process-output-max' when startup finishes.
   ;; This defines how much data is read from a foreign process.
   ;; Setting this >= 1 MB should increase performance for lsp servers
   ;; in emacs 27.
   ;; (default (* 1024 1024))
   dotspacemacs-read-process-output-max (* 1024 1024)

   ;; If non-nil then Spacelpa repository is the primary source to install
   ;; a locked version of packages. If nil then Spacemacs will install the
   ;; latest version of packages from MELPA. Spacelpa is currently in
   ;; experimental state please use only for testing purposes.
   ;; (default nil)
   dotspacemacs-use-spacelpa nil

   ;; If non-nil then verify the signature for downloaded Spacelpa archives.
   ;; (default t)
   dotspacemacs-verify-spacelpa-archives t

   ;; If non-nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil

   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'. (default 'emacs-version)
   dotspacemacs-elpa-subdirectory 'emacs-version

   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'vim

   ;; If non-nil show the version string in the Spacemacs buffer. It will
   ;; appear as (spacemacs version)@(emacs version)
   ;; (default t)
   dotspacemacs-startup-buffer-show-version t

   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official

   ;; Scale factor controls the scaling (size) of the startup banner. Default
   ;; value is `auto' for scaling the logo automatically to fit all buffer
   ;; contents, to a maximum of the full image height and a minimum of 3 line
   ;; heights. If set to a number (int or float) it is used as a constant
   ;; scaling factor for the default logo size.
   dotspacemacs-startup-banner-scale 'auto

   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `recents-by-project' `bookmarks' `projects' `agenda' `todos'.
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   ;; The exceptional case is `recents-by-project', where list-type must be a
   ;; pair of numbers, e.g. `(recents-by-project . (7 .  5))', where the first
   ;; number is the project limit and the second the limit on the recent files
   ;; within a project.
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 7))

   ;; True if the home buffer should respond to resize events. (default t)
   dotspacemacs-startup-buffer-responsive t

   ;; Show numbers before the startup list lines. (default t)
   dotspacemacs-show-startup-list-numbers t

   ;; The minimum delay in seconds between number key presses. (default 0.4)
   dotspacemacs-startup-buffer-multi-digit-delay 0.4

   ;; If non-nil, show file icons for entries and headings on Spacemacs home buffer.
   ;; This has no effect in terminal or if "all-the-icons" package or the font
   ;; is not installed. (default nil)
   dotspacemacs-startup-buffer-show-icons nil

   ;; Default major mode for a new empty buffer. Possible values are mode
   ;; names such as `text-mode'; and `nil' to use Fundamental mode.
   ;; (default `text-mode')
   dotspacemacs-new-empty-buffer-major-mode 'text-mode

   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode

   ;; If non-nil, *scratch* buffer will be persistent. Things you write down in
   ;; *scratch* buffer will be saved and restored automatically.
   dotspacemacs-scratch-buffer-persistent nil

   ;; If non-nil, `kill-buffer' on *scratch* buffer
   ;; will bury it instead of killing.
   dotspacemacs-scratch-buffer-unkillable nil

   ;; Initial message in the scratch buffer, such as "Welcome to Spacemacs!"
   ;; (default nil)
   dotspacemacs-initial-scratch-message nil

   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press `SPC T n' to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(doom-tokyo-night
                         catppuccin)

   ;; Set the theme for the Spaceline. Supported themes are `spacemacs',
   ;; `all-the-icons', `custom', `doom', `vim-powerline' and `vanilla'. The
   ;; first three are spaceline themes. `doom' is the doom-emacs mode-line.
   ;; `vanilla' is default Emacs mode-line. `custom' is a user defined themes,
   ;; refer to the DOCUMENTATION.org for more info on how to create your own
   ;; spaceline theme. Value can be a symbol or list with additional properties.
   ;; (default '(spacemacs :separator wave :separator-scale 1.5))
   dotspacemacs-mode-line-theme '(doom :separator wave :separator-scale 1.5)

   ;; If non-nil the cursor color matches the state color in GUI Emacs.
   ;; (default t)
   dotspacemacs-colorize-cursor-according-to-state t

   ;; Default font or prioritized list of fonts. This setting has no effect when
   ;; running Emacs in terminal. The font set here will be used for default and
   ;; fixed-pitch faces. The `:size' can be specified as
   ;; a non-negative integer (pixel size), or a floating-point (point size).
   ;; Point size is recommended, because it's device independent. (default 10.0)
   dotspacemacs-default-font '("JetBrains Mono"
                               :size 18
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)

   ;; The leader key (default "SPC")
   dotspacemacs-leader-key "SPC"

   ;; The key used for Emacs commands `M-x' (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"

   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"

   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"

   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","

   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m" for terminal mode, "<M-return>" for GUI mode).
   ;; Thus M-RET should work as leader key in both GUI and terminal modes.
   ;; C-M-m also should work in terminal mode, but not in GUI mode.
   dotspacemacs-major-mode-emacs-leader-key (if window-system "<M-return>" "C-M-m")

   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs `C-i', `TAB' and `C-m', `RET'.
   ;; Setting it to a non-nil value, allows for separate commands under `C-i'
   ;; and TAB or `C-m' and `RET'.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil

   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"

   ;; If non-nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil

   ;; If non-nil then the last auto saved layouts are resumed automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil

   ;; If non-nil, auto-generate layout name when creating new layouts. Only has
   ;; effect when using the "jump to layout by number" commands. (default nil)
   dotspacemacs-auto-generate-layout-names nil

   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1

   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache

   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5

   ;; If non-nil, the paste transient-state is enabled. While enabled, after you
   ;; paste something, pressing `C-j' and `C-k' several times cycles through the
   ;; elements in the `kill-ring'. (default nil)
   dotspacemacs-enable-paste-transient-state nil

   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4

   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; It is also possible to use a posframe with the following cons cell
   ;; `(posframe . position)' where position can be one of `center',
   ;; `top-center', `bottom-center', `top-left-corner', `top-right-corner',
   ;; `top-right-corner', `bottom-left-corner' or `bottom-right-corner'
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom

   ;; Control where `switch-to-buffer' displays the buffer. If nil,
   ;; `switch-to-buffer' displays the buffer in the current window even if
   ;; another same-purpose window is available. If non-nil, `switch-to-buffer'
   ;; displays the buffer in a same-purpose window even if the buffer can be
   ;; displayed in the current window. (default nil)
   dotspacemacs-switch-to-buffer-prefers-purpose nil

   ;; Whether side windows (such as those created by treemacs or neotree)
   ;; are kept or minimized by `spacemacs/toggle-maximize-window' (SPC w m).
   ;; (default t)
   dotspacemacs-maximize-window-keep-side-windows t

   ;; If nil, no load-hints enabled. If t, enable the `load-hints' which will
   ;; put the most likely path on the top of `load-path' to reduce walking
   ;; through the whole `load-path'.
   dotspacemacs-enable-load-hints nil

   ;; If t, enable the `package-quickstart' feature to avoid full package
   ;; loading, otherwise do not try the `package-quickstart' (default nil).
   dotspacemacs-enable-package-quickstart nil

   ;; If non-nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t

   ;; If non-nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil

   ;; If non-nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil

   ;; If non-nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default t) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup t

   ;; If non-nil the frame is undecorated when Emacs starts up. Combine this
   ;; variable with `dotspacemacs-maximized-at-startup' to obtain fullscreen
   ;; without external boxes. Also disables the internal border. (default nil)
   dotspacemacs-undecorated-at-startup nil

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90

   ;; A value from the range (0..100), in increasing opacity, which describes the
   ;; transparency level of a frame background when it's active or selected. Transparency
   ;; can be toggled through `toggle-background-transparency'. (default 90)
   dotspacemacs-background-transparency 90

   ;; If non-nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t

   ;; If non-nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t

   ;; If non-nil unicode symbols are displayed in the mode line.
   ;; If you use Emacs as a daemon and wants unicode characters only in GUI set
   ;; the value to quoted `display-graphic-p'. (default t)
   dotspacemacs-mode-line-unicode-symbols t

   ;; If non-nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t

   ;; Show the scroll bar while scrolling. The auto hide time can be configured
   ;; by setting this variable to a number. (default t)
   dotspacemacs-scroll-bar-while-scrolling t

   ;; Control line numbers activation.
   ;; If set to `t', `relative' or `visual' then line numbers are enabled in all
   ;; `prog-mode' and `text-mode' derivatives. If set to `relative', line
   ;; numbers are relative. If set to `visual', line numbers are also relative,
   ;; but only visual lines are counted. For example, folded lines will not be
   ;; counted and wrapped lines are counted as multiple lines.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :visual nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; When used in a plist, `visual' takes precedence over `relative'.
   ;; (default nil)
   dotspacemacs-line-numbers 'relative

   ;; Code folding method. Possible values are `evil', `origami' and `vimish'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil

   ;; If non-nil and `dotspacemacs-activate-smartparens-mode' is also non-nil,
   ;; `smartparens-strict-mode' will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil

   ;; If non-nil smartparens-mode will be enabled in programming modes.
   ;; (default t)
   dotspacemacs-activate-smartparens-mode t

   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc...
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil

   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all

   ;; If non-nil, start an Emacs server if one is not already running.
   ;; (default nil)
   dotspacemacs-enable-server t

   ;; Set the emacs server socket location.
   ;; If nil, uses whatever the Emacs default is, otherwise a directory path
   ;; like \"~/.emacs.d/server\". It has no effect if
   ;; `dotspacemacs-enable-server' is nil.
   ;; (default nil)
   dotspacemacs-server-socket-dir nil

   ;; If non-nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server t

   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `rg', `ag', `pt', `ack' and `grep'.
   ;; (default '("rg" "ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("rg" "ag" "pt" "ack" "grep")

   ;; The backend used for undo/redo functionality. Possible values are
   ;; `undo-fu', `undo-redo' and `undo-tree' see also `evil-undo-system'.
   ;; Note that saved undo history does not get transferred when changing
   ;; your undo system. The default is currently `undo-fu' as `undo-tree'
   ;; is not maintained anymore and `undo-redo' is very basic."
   dotspacemacs-undo-system 'undo-fu

   ;; Format specification for setting the frame title.
   ;; %a - the `abbreviated-file-name', or `buffer-name'
   ;; %t - `projectile-project-name'
   ;; %I - `invocation-name'
   ;; %S - `system-name'
   ;; %U - contents of $USER
   ;; %b - buffer name
   ;; %f - visited file name
   ;; %F - frame name
   ;; %s - process status
   ;; %p - percent of buffer above top of window, or Top, Bot or All
   ;; %P - percent of buffer above bottom of window, perhaps plus Top, or Bot or All
   ;; %m - mode name
   ;; %n - Narrow if appropriate
   ;; %z - mnemonics of buffer, terminal, and keyboard coding systems
   ;; %Z - like %z, but including the end-of-line format
   ;; If nil then Spacemacs uses default `frame-title-format' to avoid
   ;; performance issues, instead of calculating the frame title by
   ;; `spacemacs/title-prepare' all the time.
   ;; (default "%I@%S")
   dotspacemacs-frame-title-format "%I@%S"

   ;; Format specification for setting the icon title format
   ;; (default nil - same as frame-title-format)
   dotspacemacs-icon-title-format nil

   ;; Color highlight trailing whitespace in all prog-mode and text-mode derived
   ;; modes such as c++-mode, python-mode, emacs-lisp, html-mode, rst-mode etc.
   ;; (default t)
   dotspacemacs-show-trailing-whitespace t

   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed' to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; The variable `global-spacemacs-whitespace-cleanup-modes' controls
   ;; which major modes have whitespace cleanup enabled or disabled
   ;; by default.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup 'trailing

   ;; If non-nil activate `clean-aindent-mode' which tries to correct
   ;; virtual indentation of simple modes. This can interfere with mode specific
   ;; indent handling like has been reported for `go-mode'.
   ;; If it does deactivate it here.
   ;; (default t)
   dotspacemacs-use-clean-aindent-mode t

   ;; Accept SPC as y for prompts if non-nil. (default nil)
   dotspacemacs-use-SPC-as-y nil

   ;; If non-nil shift your number row to match the entered keyboard layout
   ;; (only in insert state). Currently supported keyboard layouts are:
   ;; `qwerty-us', `qwertz-de' and `querty-ca-fr'.
   ;; New layouts can be added in `spacemacs-editing' layer.
   ;; (default nil)
   dotspacemacs-swap-number-row nil

   ;; Either nil or a number of seconds. If non-nil zone out after the specified
   ;; number of seconds. (default nil)
   dotspacemacs-zone-out-when-idle nil

   ;; Run `spacemacs/prettify-org-buffer' when
   ;; visiting README.org files of Spacemacs.
   ;; (default nil)
   dotspacemacs-pretty-docs nil

   ;; If nil the home buffer shows the full path of agenda items
   ;; and todos. If non-nil only the file name is shown.
   dotspacemacs-home-shorten-agenda-source nil

   ;; If non-nil then byte-compile some of Spacemacs files.
   dotspacemacs-byte-compile nil))

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
  ;;INFO: in macos, you can increase the repeat rate of keys
  ;; M-x nerd-icons-install-fonts to fix doom-emacs status line
  (add-to-list 'exec-path "/etc/profiles/per-user/henri.vandersleyen/bin")
  ;; --- misc problems ---
  (when (fboundp 'electric-indent-mode) (electric-indent-mode -1)) ;; disables auto indent on new lines
  (setq-default spacemacs-yank-indent-threshold 0) ;; disables auto indent on pasting
  (setq-default word-wrap t)
  (spacemacs/set-leader-keys "obs" 'scratch-buffer)
  ;; --- popper ---
  (spacemacs/set-leader-keys "opt" 'popper-toggle)
  (spacemacs/set-leader-keys "opc" 'popper-cycle)
  (spacemacs/set-leader-keys "opm" 'popper-toggle-type)
  (popper-mode +1)
  (popper-echo-mode +1)
  (setq popper-reference-buffers
        (append popper-reference-buffers
                '("^\\*eshell.*\\*$" eshell-mode ;eshell as a popup
                  "^\\*shell.*\\*$"  shell-mode  ;shell as a popup
                  "^\\*term.*\\*$"   term-mode   ;term as a popup
                  "^\\*vterm.*\\*$"  vterm-mode  ;vterm as a popup
                  )))
  (setq popper-window-height 0.33)
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
  ;; --- ai ---
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
  ;; --- llm/ai ---
  (gptel-make-deepseek "DeepSeek"
    :stream t
    :key "your-api-key")
  ;; --- projectile ---
  (setq projectile-project-search-path '("~/knak/packages/" "~/Documents/"))
  (spacemacs/set-leader-keys "ps" 'projectile-discover-projects-in-search-path)
  (spacemacs/set-leader-keys "p/" 'projectile-ag)
  (spacemacs/set-leader-keys "pk" 'projectile-remove-known-project)
  ;; --- babel ---
  (define-derived-mode ts-mode typescript-mode "ts"
    "Major mode for editing typescipt src blocks in org mode.")
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((typescript . t)))  ;; Enable TypeScript support

  ;; --- hl-todo ---
  (with-eval-after-load 'hl-todo
    (add-to-list 'hl-todo-keyword-faces '("WARN" . "#FFA500")))
  ;; --- org-general ---
  (setq user-mail-address "henri-vandersleyen@protonmail.com")
  (add-hook 'org-mode-hook
            (lambda ()
              (toggle-truncate-lines nil) ))

  (spacemacs/set-leader-keys "olk" 'spacemacs/helm-persp-kill)
  ;; --- org-keybindings ---
  (defun my/org-add-checkbox-counter ()
    "Append `[/]` at the end of the current TODO item."
    (interactive)
    (save-excursion
      (org-back-to-heading t)
      (end-of-line)
      (insert " [/]")
      ))
  ;; keybinding will only be available in org mode
  (add-hook 'org-mode-hook
            (lambda ()
              (spacemacs/set-leader-keys-for-major-mode 'org-mode "T/" 'my/org-add-checkbox-counter)
              (spacemacs/set-leader-keys-for-major-mode 'org-mode "iDc" 'org-download-clipboard)
              ))
  ;; --- org-todo ---
  (setq org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!)")
          (sequence "BACKLOG(b)" "PLAN(p)" "READY(r)" "ACTIVE(a)" "REVIEW(v)" "WAIT(w@/!)" "HOLD(h)" "|" "COMPLETED(c)" "CANC(k@)")))

  (setq org-todo-keyword-faces
        '(("TODO"      :inherit (org-todo region) :foreground "#A6E3A1" :weight bold)  ; Green
          ("NEXT"      :inherit (org-todo region) :foreground "#F9E2AF" :weight bold)  ; Yellow
          ("PLAN"      :inherit (org-todo region) :foreground "#74C7EC" :weight bold)  ; Sapphire
          ("READY"     :inherit (org-todo region) :foreground "#89B4FA" :weight bold)  ; Blue
          ("ACTIVE"    :inherit (org-todo region) :foreground "#F38BA8" :weight bold)  ; Red
          ("REVIEW"    :inherit (org-todo region) :foreground "#F5C2E7" :weight bold)  ; Pink
          ("WAIT"      :inherit (org-todo region) :foreground "#EBA0AC" :weight bold)  ; Maroon
          ("BACKLOG"   :inherit (org-todo region) :foreground "#B4BEFE" :weight bold)  ; Lavender
          ("HOLD"      :inherit (org-todo region) :foreground "#CBA6F7" :weight bold)  ; Mauve
          ("DONE"      :inherit (org-todo region) :foreground "#6C7086" :weight bold)  ; Gray (Subtext0)
          ("COMPLETED" :inherit (org-todo region) :foreground "#6C7086" :weight bold)  ; Gray (same as DONE)
          ("CANC"      :inherit (org-todo region) :foreground "#FAB387" :weight bold)  ; Peach
          ))
  ;; --- org-priority
  ;; ~spc m p~ will allow you to set the priority
  (setq org-lowest-priority  ?F) ;; Gives us priorities A through F
  (setq org-default-priority ?E) ;; If an item has no priority, it is considered [#E].

  (setq org-priority-faces
        '(
          ;; Priority A (highest) - Red
          (65 . (:foreground "#f38ba8" :weight bold))
          ;; Priority B - Peach
          (66 . (:foreground "#fab387" :weight bold))
          ;; Priority C - Mauve
          (67 . (:foreground "#cba6f7" :weight bold))
          ;; Priority D - Blue
          (68 . (:foreground "#89b4fa" :weight bold))
          ;; Priority E - Sapphire
          (69 . (:foreground "#74c7ec" :weight bold))
          ;; Priority F (lowest) - Overlay2
          (70 . (:foreground "#9399b2" :weight bold))
          ))
  ;; --- org-tags ---
  (setq org-tag-alist
        '(
          ;; Ticket types
          (:startgroup . nil)
          ("@bug" . ?b)
          ("@feature" . ?u)
          ("@spike" . ?j)
          (:endgroup . nil)

          ;; Ticket flags
          ("@write_future_ticket" . ?w)
          ("@emergency" . ?e)
          ("@research" . ?r)

          ;; Meeting types
          (:startgroup . nil)
          ("sprint_planning" . ?i)
          ("sprint_retro" . ?s)
          (:endgroup . nil)

          ;; Code TODOs tags
          ("QA" . ?q)
          ("backend" . ?k)
          ("broken_code" . ?c)
          ("frontend" . ?f)
          ("devops" . ?d)

          ;; Special tags
          ("CRITICAL" . ?x)
          ("obstacle" . ?o)

          ;; Meeting tags
          ("general" . ?l)
          ("meeting" . ?m)
          ("misc" . ?z)
          ("planning" . ?p)

          ;; Work Log Tags
          ("accomplishment" . ?a)
          ))
  (setq org-tag-faces
        '(
          ("planning"  . (:foreground "#cba6f7" :weight bold))  ; Mauve
          ("backend"   . (:foreground "#89b4fa" :weight bold))  ; Blue
          ("frontend"  . (:foreground "#a6e3a1" :weight bold))  ; Green
          ("QA"        . (:foreground "#fab387" :weight bold))  ; Peach
          ("meeting"   . (:foreground "#f9e2af" :weight bold))  ; Yellow
          ("CRITICAL"  . (:foreground "#f38ba8" :weight bold))  ; Red
          ))
  ;; --- org-modern ---
  (setq org-adapt-indentation t
        org-hide-leading-stars t
        org-hide-emphasis-markers t
        org-pretty-entities t
        org-ellipsis "  ·")
  (setq org-src-fontify-natively t
        org-src-tab-acts-natively t
        org-edit-src-content-indentation 0)
  ;; --- org-journal ---
  (setq org-journal-dir "~/Documents/zettelkasten/org/journal")
  (setq org-directory "~/Documents/zettelkasten/org")
  (setq org-default-notes-file (concat org-directory )) ;; "/notes.org"
  (setq find-file-visit-truename t)
  ;; --- org-templates ---
  (setq org-capture-templates
        '(
          ("j" "Work Log Entry"
           entry (file+datetree "~/Documents/zettelkasten/org-roam/work-log.org")
           "* %?"
           :empty-lines 0)
          ("g" "General To-Do"
           entry (file "~/Documents/zettelkasten/org-roam/todo.org")
           "* TODO [#E] %?\n:Created: %T\n "
           :empty-lines 0)
          ("m" "Meeting"
           entry (file+datetree "~/Documents/zettelkasten/org-roam/meetings.org")
           "* %? :meeting:%^g \n:Created: %T\n** Attendees\n*** \n** Notes\n** Action Items\n*** TODO [#A] "
           :tree-type week
           :clock-in t
           :clock-resume t
           :empty-lines 0)
          ))
  ;; --- org-agenda ---
  (setq org-agenda-files '("~/Documents/zettelkasten/org-roam/"))
  (setq org-agenda-skip-deadline-if-done t)

  ;; --- org-roam ---
  (setq org-roam-directory "~/Documents/zettelkasten/org-roam")
  (setq org-journal-dir "~/Documents/zettelkasten/org/journal")
  (setq org-directory "~/Documents/zettelkasten/org")
  (setq org-default-notes-file (concat org-directory )) ;; "/notes.org"
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
  (which-key-add-key-based-replacements "os" "+sops")
  (spacemacs/set-leader-keys "ose" 'sops-edit-file)
  (spacemacs/set-leader-keys "oss" 'sops-save-file)
  (spacemacs/set-leader-keys "osc" 'sops-cancel)
  (global-sops-mode 1)
  ;; --- treemacs ---
  (custom-set-faces
   '(treemacs-hl-line-face ((t (:background "#e64553")))))
  (with-eval-after-load 'treemacs
    (defun treemacs-ignore-node-modules (folder _)
      (string= folder "node_modules"))
    (push #'treemacs-ignore-node-modules treemacs-ignored-file-predicates))
  ;; --- dired ---
  (setq dired-kill-when-opening-new-dired-buffer t)
  ;; Do not write anything past this comment. This is where Emacs will
  ;; auto-generate custom variable definitions.
  )

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
   '(package-selected-packages
     '(a ace-jump-helm-line ace-link ace-pinyin add-node-modules-path
         aggressive-indent aio alert all-the-icons anaconda-mode auctex
         auto-compile auto-dictionary auto-highlight-symbol auto-yasnippet blacken
         browse-at-remote bui catppuccin-theme centered-cursor-mode chinese-conv
         chinese-word-at-point clean-aindent-mode closql code-cells code-review
         color-identifiers-mode column-enforce-mode company company-anaconda
         company-auctex company-emoji company-math company-nixos-options
         company-reftex company-shell concurrent consult ctable cython-mode
         dap-mode deferred define-word devdocs diff-hl diminish dired-quick-sort
         disable-mouse docker dockerfile-mode doom-modeline doom-themes
         dotenv-mode drag-stuff dumb-jump eat editorconfig elisp-def elisp-demos
         elisp-slime-nav ellama emacsql emoji-cheat-sheet-plus emojify emr epc
         esh-help eshell-prompt-extras eshell-z eval-sexp-fu evil-anzu evil-args
         evil-cleverparens evil-collection evil-easymotion evil-escape
         evil-evilified-state evil-exchange evil-goggles evil-iedit-state
         evil-indent-plus evil-lion evil-lisp-state evil-matchit evil-mc
         evil-nerd-commenter evil-numbers evil-org evil-surround evil-tex
         evil-textobj-line evil-tutor evil-unimpaired evil-visual-mark-mode
         evil-visualstar exec-path-from-shell expand-region eyebrowse
         fancy-battery fcitx fic-mode find-by-pinyin-dired fish-mode flx-ido
         flycheck-bashate flycheck-elsa flycheck-package flycheck-pos-tip
         flyspell-correct flyspell-correct-helm flyspell-popup font-utils forge
         gh-md ghub git-link git-messenger git-modes git-timemachine
         gitignore-templates gntp gnuplot golden-ratio google-translate gptel
         helm-ag helm-c-yasnippet helm-comint helm-company helm-descbinds
         helm-git-grep helm-ls-git helm-lsp helm-make helm-mode-manager
         helm-nixos-options helm-org helm-org-rifle helm-projectile helm-purpose
         helm-pydoc helm-swoop helm-themes helm-xref hide-comnt
         highlight-indentation highlight-numbers highlight-parentheses hl-todo
         holy-mode htmlize hungry-delete hybrid-mode importmagic indent-guide
         info+ insert-shebang inspector js-doc js2-mode js2-refactor json-mode
         json-navigator json-reformat json-snatcher ligature link-hint
         live-py-mode livid-mode llm load-env-vars log4e lorem-ipsum lsp-docker
         lsp-latex lsp-mode lsp-origami lsp-pyright lsp-tailwindcss lsp-treemacs
         lsp-ui macrostep magit magit-section markdown-mode markdown-toc
         math-symbol-lists multi-line multi-term multi-vterm multiple-cursors
         nameless names nerd-icons nix-mode nix-ts-mode nixos-options nodejs-repl
         npm-mode nyan-mode ob-typescript open-junk-file org org-category-capture
         org-cliplink org-contrib org-download org-mime org-pomodoro org-present
         org-project-capture org-projectile org-rich-yank org-roam org-roam-ui
         org-superstar orgit orgit-forge origami overseer pangu-spacing paradox
         password-generator pcache pcre2el persistent-soft pinyinlib
         pip-requirements pipenv pippel plz plz-event-source plz-media-type poetry
         pomm popper popwin pos-tip prettier-js py-isort pydoc pyenv-mode pyim
         pyim-basedict pylookup pytest pythonic pyvenv quickrun rainbow-delimiters
         rainbow-identifiers rainbow-mode reformatter request restart-emacs
         shell-pop shfmt shrink-path simple-httpd skewer-mode smeargle sops
         space-doc spaceline spacemacs-purpose-popwin spacemacs-whitespace-cleanup
         sphinx-doc sqlite3 string-edit-at-point string-inflection symbol-overlay
         symon term-cursor terminal-here toc-org toml-mode transient
         treemacs-all-the-icons treemacs-evil treemacs-icons-dired treemacs-magit
         treemacs-persp treemacs-projectile treepy typescript-mode ucs-utils
         undo-fu undo-fu-session unicode-fonts uuidgen valign vi-tilde-fringe
         vim-powerline vmd-mode volatile-highlights vterm vundo web-beautify
         web-mode websocket which-key winum with-editor writeroom-mode ws-butler
         xkcd xr xref yaml yaml-mode yapfify yasnippet yasnippet-snippets
         youdao-dictionary)))
  (custom-set-faces
   ;; custom-set-faces was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   '(treemacs-hl-line-face ((t (:background "#e64553")))))
  )
