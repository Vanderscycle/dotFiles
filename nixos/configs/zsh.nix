
{ pkgs, ... }:
	{
	programs.zsh = {
        enable = true;
        enableAutosuggestions = true;
          plugins = with pkgs; [
	        {
        name = "agkozak-zsh-prompt";
        src = fetchFromGitHub {
          owner = "agkozak";
          repo = "agkozak-zsh-prompt";
          rev = "v3.7.0";
          sha256 = "1iz4l8777i52gfynzpf6yybrmics8g4i3f1xs3rqsr40bb89igrs";
        };
        file = "agkozak-zsh-prompt.plugin.zsh";
      }
	        {
        name = "zsh-syntax-highlighting";
        src = fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "0.6.0";
          sha256 = "0zmq66dzasmr5pwribyh4kbkk23jxbpdw4rjxx0i7dx8jjp2lzl4";
        };
        file = "zsh-syntax-highlighting.zsh";
      }
      {
        name = "zsh-autopair";
        src = fetchFromGitHub {
          owner = "hlissner";
          repo = "zsh-autopair";
          rev = "34a8bca0c18fcf3ab1561caef9790abffc1d3d49";
          sha256 = "1h0vm2dgrmb8i2pvsgis3lshc5b0ad846836m62y8h3rdb3zmpy1";
        };
        file = "autopair.zsh";
      }
          ];
        oh-my-zsh = {
          enable = true;
          theme = "agnoster";
        };
        localVariables = {
          EDITOR = "vim";
        };
        shellAliases = {

	ls = "exa -al";
          mff = "git merge --ff-only";
          vi = "nvim";
        };
        initExtra = ''

export PATH=~/.npm-packages/bin:$PATH;
export NODE_PATH=~/.npm-packages/lib/node_modules;
          unset LESS
        '';
      };
    }
