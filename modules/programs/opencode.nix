{ ... }:
{
  steppe.ai._.ollama = {
    homeManager = {
      programs.opencode = {
        enable = true;
        settings = {
          provider = {
            ollama = {
              npm = "@ai-sdk/openai-compatible";
              name = "Ollama";
              options = {
                baseURL = "http://localhost:11434/v1";
              };
              models = {
                # "qwen3.5" = {
                #   name = "qwen3.5";
                # };
                "qwen3.5:0.8b" = {
                  name = "qwen3.5:0.8b";
                };
              };
            };
          };
          theme = "catppuccin";
          autoshare = false;
          autoupdate = true;
          server = {
            port = 4096;
            hostname = "0.0.0.0";
            mdns = true;
            # mdnsDomain = "opencode.local";
            # cors = [ "http://localhost:5173" ];
          };
        };
      };
    };
  };
}
