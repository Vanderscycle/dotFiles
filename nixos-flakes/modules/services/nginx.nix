{
  services.nginx = {
    enable = true;
    virtualHosts."localhost" = {
      root = "/var/www/html"; # Serve files from this directory
      listen = [
        {
          addr = "127.0.0.1";
          port = 8080;
        }
      ];

      # Serve the favicon.ico
      locations = {
        "/favicon.ico" = {
          root = "/var/www/html";
          extraConfig = ''
            log_not_found off;
            access_log off;
          '';
        };

        "/" = {
          index = "index.html";
        };

        "/hello" = {
          extraConfig = ''
            return 200 'Hello, World!';
            add_header Content-Type text/plain;
          '';
        };
      };
    };
  };

  # Make sure the favicon file is deployed
  environment.etc."var/www/html/favicon.ico".source = /home/henri/Documents/houseVanCylesIndustries/blog/frontend/static/favicon.ico;
}

# sudo mkdir -p /var/www/html
# echo "<h1>Welcome to Nginx!</h1>" | sudo tee /var/www/html/index.html
