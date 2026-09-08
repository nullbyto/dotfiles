-- ==========================================
-- Events (Autostart & Reload)
-- ==========================================
hl.on("hyprland.start", function()
    -- Auto login to kdewallet on login
    -- hl.exec_cmd("/usr/lib/pam_kwallet_init")
    hl.exec_cmd("dbus-update-activation-environment --systemd --all")
    hl.exec_cmd(shell)
    hl.exec_cmd("~/.config/hypr/scripts/xdg.sh")
    -- hl.exec_cmd("systemctl --user start xremap &")
    -- hl.exec_cmd("sleep 1 && awww-daemon")
    hl.exec_cmd("nm-applet &")
    hl.exec_cmd("blueman-applet &")
    hl.exec_cmd("emacs --daemon")
    -- hl.exec_cmd("/usr/lib/xfce-polkit/xfce-polkit &")
    hl.exec_cmd("XDG_CURRENT=GNOME insync start &")
    hl.exec_cmd("poweralertd -Ss &")
    hl.exec_cmd("thunar --daemon")
end)

hl.on("config.reloaded", function()
    -- hl.exec_cmd("awww img ~/Pictures/Wallpapers/wallpaper.jpg")
end)

