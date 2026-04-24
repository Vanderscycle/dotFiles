{
  steppe.xdg = {
    nixos = {
      xdg.terminal-exec.enable = true;
    };
    homeManager =
      { config, ... }:
      {
        xdg = {
          enable = true;
          autostart.enable = true;
          autostart.readOnly = true;
          userDirs = {
            enable = true;
            createDirectories = true;
            setSessionVariables = true;
            desktop = null;
            templates = null;
            music = null;
            publicShare = null;
          };
        };
        home.sessionVariables = {
          # cleaning up ~
          BUN_INSTALL_GLOBAL_DIR = "${config.xdg.dataHome}/bun";
          BUN_INSTALL_BIN = "${config.home.homeDirectory}/.local/bin";
          GOPATH = "${config.xdg.dataHome}/go";
          LESSHISTFILE = "${config.xdg.cacheHome}/less/history";
          NODE_REPL_HISTORY = "${config.xdg.stateHome}/node_repl_history";
          NPM_CONFIG_INIT_MODULE = "${config.xdg.configHome}/npm/config/npm-init.js";
          NPM_CONFIG_CACHE = "${config.xdg.cacheHome}/npm";
          NPM_CONFIG_PREFIX = "${config.xdg.stateHome}/npm";
          STACK_ROOT = "${config.xdg.dataHome}/stack";
          WINEPREFIX = "${config.xdg.dataHome}/wine";
          XCOMPOSECACHE = "${config.xdg.cacheHome}/X11/xcompose";
          _Z_DATA = "${config.xdg.dataHome}/z";
        };
      };
  };
}
