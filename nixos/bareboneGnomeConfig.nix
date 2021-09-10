{ pkgs, ... }:
{
    programs.xwayland.enable = true;
    services = {
        gnome.core-os-services.enable = true;
        xserver = {
            enable = true;
            libinput.enable = true;

            displayManager = {
                gdm.enable = true;
                gdm.autoSuspend = false;
            };
            desktopManager = {
                gnome = {
                    extraGSettingsOverrides = ''
                        [org.gnome.nautilus.preferences]
                        default-folder-viewer='list-view'
                        search-filter-time-type='last-modified'
                        search-view='list-view'
                        show-delete-permanently=true
                        [org.gnome.desktop.wm.preferences]
                        button-layout='appmenu:minimize,maximize,close'
                        [org.gnome.desktop.input-sources]
                        [('xkb', 'us+colemak')]
                        [org.gnome.desktop.interface]
                        document-font-name='Ubuntu Bold 20'
                        font-antialiasing='rgba'
                        font-name='Ubuntu 16'
                        gtk-theme='materia-cyberpunk-neon'
                        monospace-font-name='Ubuntu Mono 16'
                        show-battery-percentage=true
                    '';
                    enable = true;
                };
            };
        };
    };
    environment.systemPackages = with pkgs; [
        gnome.gnome-shell-extensions
        gnome.dconf-editor
    ];
}
