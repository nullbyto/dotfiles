import os
import re
import socket
import subprocess
from typing import List
from libqtile import qtile
from libqtile.config import Click, Drag, Group, KeyChord, Key, Match, Screen
from libqtile import layout, bar, widget, hook
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from libqtile.dgroups import simple_key_binder
from libqtile.log_utils import logger

########################################################################################
# Variables
########################################################################################

mod = "mod4"                                        # Sets mod key to SUPER/WINDOWS
home = os.path.expanduser("~")                      # Allow using "home +" to expand ~
myTerm = guess_terminal(preference="alacritty")     # Guess term with alacritty as main 
myBrowser = "firefox"                               # My browser
myFM = "thunar"                                     # My file manager

colors = [["#282c34", "#282c34"],
          ["#1c1f24", "#1c1f24"],
          ["#dfdfdf", "#dfdfdf"],
          ["#ff6c6b", "#ff6c6b"],
          ["#98be65", "#98be65"],
          ["#da8548", "#da8548"],
          ["#51afef", "#51afef"],
          ["#c678dd", "#c678dd"],
          ["#46d9ff", "#46d9ff"],
          ["#a9a1e1", "#a9a1e1"]]

dracula_colors = {
    "bg": ["#282a36", "#282a36"],
    "test": ["#ffffff", "#ffffff"],
    "fg": ["#f8f8f2", "#f8f8f2"],
    "select": ["#44475a", "#44475a"],
    "highlight": ["#6272a4", "#6272a4"],
    "cyan": ["#8be9fd", "#8be9fd"],
    "green": ["#50fa7b", "#50fa7b"],
    "orange": ["#ffb86c", "#ffb86c"],
    "pink": ["#ff79c6", "#ff79c6"],
    "purple": ["#bd93f9", "#bd93f9"],
    "red": ["#ff5555", "#ff5555"],
    "yellow": ["#f1fa8c", "#f1fa8c"],
}

catppuccin_colors = {
    "purple": ["#DDB6F2", "#DDB6F2"],  #  0 mauve
    "pink": ["#F5C2E7", "#F5C2E7"],  #  1 pink
    "maroon": ["#E8A2AF", "#E8A2AF"],  #  2 maroon
    "red": ["#F28FAD", "#F28FAD"],  #  3 red
    "orange": ["#F8BD96", "#F8BD96"],  #  4 peach
    "yellow": ["#FAE3B0", "#FAE3B0"],  #  5 yellow
    "green": ["#ABE9B3", "#ABE9B3"],  #  6 green
    "teal": ["#B5E8E0", "#B5E8E0"],  #  7 teal
    "blue": ["#96CDFB", "#96CDFB"],  #  8 blue
    "cyan": ["#89DCEB", "#89DCEB"],  #  9 sky
    "bg1": ["#161320", "#161320"],  # 10 black 0
    "bg": ["#1A1826", "#1A1826"],  # 11 black 1
    "bg3": ["#1E1E2E", "#1E1E2E"],  # 12 black 2
    "bg4": ["#302D41", "#302D41"],  # 13 black 3
    "bg5": ["#575268", "#575268"],  # 14 black 4
    "surface": ["#6E6C7E", "#6E6C7E"],  # 15 gray 0
    "surface1": ["#988BA2", "#988BA2"],  # 16 gray 1
    "overlay": ["#C3BAC6", "#C3BAC6"],  # 17 gray 2
    "fg": ["#D9E0EE", "#D9E0EE"],  # 18 white
    "lavender": ["#C9CBFF", "#C9CBFF"],  # 19 lavender
    "rosewater": ["#F5E0DC", "#F5E0DC"],  # 20 rosewater
    "dblue": ["#89B4FA", "#89B4FA"], # dark blue
}

theme = catppuccin_colors

########################################################################################
# Keybindings
########################################################################################

keys = [
    # The essentials
    Key([mod], "Return",
        lazy.spawn(myTerm),
        desc='Launches My Terminal'
        ),
    Key([mod], "b",
        lazy.spawn(myBrowser),
        desc='Launches my browser'
        ),
    Key([mod], "e",
        lazy.spawn(myFM),
        desc='Launches my file manager'
        ),
    Key([mod], "d",
        lazy.spawn("rofi -modi drun,run -show drun"),
        desc='Run Launcher'
        ),
    Key([mod], "Delete",
        lazy.spawn("rofi -theme ~/.config/rofi/configPower.rasi -show power-menu -modi power-menu:" + home + "/.scripts/rofi-power-menu"),
        desc='Launch the powermenu'
        ),
    Key([mod, "shift"], "x",
        lazy.spawn("betterlockscreen -l dimblur"),
        desc='Lock screen'
        ),
    Key([mod], "p",
        lazy.spawncmd(),
        desc='Spawn a comman using a prompt widget'
        ),
    Key([], "Print",
        lazy.spawn("flameshot screen --path " + home + "/Pictures/Screenshots"),
        desc='Print entire screen'
        ),
    Key([mod, "shift"], "s",
        lazy.spawn("flameshot gui --path " + home + "/Pictures/Screenshots"),
        desc='Select print screen'
        ),
    Key([mod], "space",
        lazy.next_layout(),
        desc='Toggle next layout'
        ),
    Key([mod, "shift"], "space",
        lazy.prev_layout(),
        desc='Toggle last layout'
        ),
    Key([mod], "c",
        lazy.window.kill(),
        desc='Kill active window'
        ),
    Key([mod, "control"], "r",
        lazy.reload_config(),
        desc='Reload the config'
        ),
    Key([mod, "shift"], "r",
        lazy.restart(),
        desc='Restart Qtile'
        ),
    Key([mod, "shift"], "q",
        lazy.shutdown(),
        desc='Shutdown Qtile'
        ),
    Key(["mod1"], "Shift_L",
        lazy.widget["keyboardlayout"].next_keyboard(),
        desc="Next keyboard layout."
        ),

    # Switch focus to specific monitor
    #Key([mod], "w",
    #    lazy.to_screen(0),
    #    desc='Keyboard focus to monitor 1'
    #    ),
    #Key([mod], "e",
    #    lazy.to_screen(1),
    #    desc='Keyboard focus to monitor 2'
    #    ),

    # Switch focus of monitors
    Key([mod], "period",
        lazy.next_screen(),
        desc='Move focus to next monitor'
        ),
    Key([mod], "comma",
        lazy.prev_screen(),
        desc='Move focus to prev monitor'
        ),

    # Switch Groups
    Key([mod], "End",
        lazy.screen.next_group(),
        desc='Move focus to next group'
        ),
    Key([mod], "Home",
        lazy.screen.prev_group(),
        desc='Move focus to prev group'
        ),

    # Floating controls
    Key([mod], "bracketleft",
        lazy.group.prev_window(),
        lazy.window.bring_to_front(),
        desc='Move focus to prev floating window'
        ),
    Key([mod], "bracketright",
        lazy.group.next_window(),
        lazy.window.bring_to_front(),
        desc='Move focus to next floating window'
        ),

    # Window controls
    Key([mod], "h",
        lazy.layout.left(),
        desc='Move focus left in current stack pane'
        ),
    Key([mod], "j",
        lazy.layout.down(),
        desc='Move focus down in current stack pane'
        ),
    Key([mod], "k",
        lazy.layout.up(),
        desc='Move focus up in current stack pane'
        ),
    Key([mod], "l",
        lazy.layout.right(),
        desc='Move focus right in current stack pane'
        ),
    Key([mod], "Left",
        lazy.layout.left(),
        desc='Move focus left in current stack pane'
        ),
    Key([mod], "Down",
        lazy.layout.down(),
        desc='Move focus down in current stack pane'
        ),
    Key([mod], "Up",
        lazy.layout.up(),
        desc='Move focus up in current stack pane'
        ),
    Key([mod], "Right",
        lazy.layout.right(),
        desc='Move focus right in current stack pane'
        ),
    Key([mod, "shift"], "h",
        lazy.layout.shuffle_left(),
        lazy.layout.section_left(),
        desc='Move windows down in current stack'
        ),
    Key([mod, "shift"], "j",
        lazy.layout.shuffle_down(),
        lazy.layout.section_down(),
        desc='Move windows down in current stack'
        ),
    Key([mod, "shift"], "k",
        lazy.layout.shuffle_up(),
        lazy.layout.section_up(),
        desc='Move windows up in current stack'
        ),
    Key([mod, "shift"], "l",
        lazy.layout.shuffle_right(),
        lazy.layout.section_right(),
        desc='Move windows down in current stack'
        ),
    Key([mod, "control"], "h",
        lazy.layout.shrink(),
        lazy.layout.decrease_nmaster(),
        desc='Shrink window (MonadTall), decrease number in master pane (Tile)'
        ),
    Key([mod, "control"], "l",
        lazy.layout.grow(),
        lazy.layout.increase_nmaster(),
        desc='Expand window (MonadTall), increase number in master pane (Tile)'
        ),
    Key([mod], "n",
        lazy.layout.normalize(),
        desc='normalize window size ratios'
        ),
    Key([mod], "m",
        lazy.layout.maximize(),
        desc='toggle window between minimum and maximum sizes'
        ),
    Key([mod, "shift"], "f",
        lazy.window.toggle_floating(),
        desc='toggle floating'
        ),
    Key([mod], "f",
        lazy.window.toggle_fullscreen(),
        desc='toggle fullscreen'
        ),

    # Stack controls
    Key([mod], "Tab",
        lazy.layout.next(),
        desc='Switch window focus to other pane(s) of stack'
        ),
    Key([mod, "shift"], "Tab",
        lazy.layout.rotate(),
        lazy.layout.flip(),
        desc='Switch which side main pane occupies (XmonadTall)'
        ),
    Key([mod, "control"], "Tab",
        lazy.layout.toggle_split(),
        desc='Toggle between split and unsplit sides of stack'
        ),

    # Extra controls
    Key([], "XF86MonBrightnessUp",
        lazy.spawn("brightnessctl set +5%"),
        desc="Increase screen brightness"
        ),
    Key([], "XF86MonBrightnessDown",
        lazy.spawn("brightnessctl set 5%-"),
        desc="Decrease screen brightness"
        ),
    Key([], "XF86AudioRaiseVolume",
        lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +10%"),
        desc="Raise volume"
        ),
    Key([], "XF86AudioLowerVolume",
        lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -10%"),
        desc="Lower volume"
        ),
    Key([], "XF86AudioMute",
        lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle"),
        desc="Mute speakers"
        ),
    Key([], "XF86AudioMicMute",
        lazy.spawn("pactl set-source-mute @DEFAULT_SOURCE@ toggle"),
        desc="Mute microphone"
        ),
    Key([], "XF86AudioPlay",
        lazy.spawn("playerctl play-pause"),
        desc="Play/Pause audio"
        ),
    Key([], "XF86AudioNext",
        lazy.spawn("playerctl next"),
        desc="Next track"
        ),
    Key([], "XF86AudioPrev",
        lazy.spawn("playerctl previous"),
        desc="Previous track"
        ),
]


def show_keys(keys):
    """
    print current keybindings in a pretty way for a rofi/dmenu window.
    """
    key_help = ""
    keys_ignored = (
        "XF86AudioMute",  #
        "XF86AudioLowerVolume",  #
        "XF86AudioRaiseVolume",  #
        "XF86AudioPlay",  #
        "XF86AudioNext",  #
        "XF86AudioPrev",  #
        "XF86AudioStop",
    )
    text_replaced = {
        "mod4": "[S]",  #
        "control": "[Ctl]",  #
        "mod1": "[Alt]",  #
        "shift": "[Shf]",  #
        "twosuperior": "²",  #
        "less": "<",  #
        "ampersand": "&",  #
        "Escape": "Esc",  #
        "Return": "Enter",  #
    }
    for k in keys:
        if k.key in keys_ignored:
            continue

        mods = ""
        key = ""
        desc = k.desc.title()
        for m in k.modifiers:
            if m in text_replaced.keys():
                mods += text_replaced[m] + " + "
            else:
                mods += m.capitalize() + " + "

        if len(k.key) > 1:
            if k.key in text_replaced.keys():
                key = text_replaced[k.key]
            else:
                key = k.key.title()
        else:
            key = k.key

        key_line = "{:<25} {}".format(mods + key, desc + "\n")
        key_help += key_line

        # debug_print(key_line)  # debug only

    return key_help


# this must be done AFTER all the keys have been defined
keys.extend(
    [Key([mod], "F1", lazy.spawn("sh -c 'echo \"" + show_keys(keys) +
         "\" | rofi -theme ~/.config/rofi/configTall.rasi -dmenu -i -mesg \"Keyboard shortcuts\"'"), desc="Print keyboard bindings")]
)

########################################################################################
# Workspaces and layouts
########################################################################################

groups = [Group("1", label="", layout='monadtall'),
          Group("2", label="", layout='monadtall', matches=[Match(wm_class=['firefox'])]),
          Group("3", label="", layout='monadtall'),
          Group("4", label="", layout='monadtall'),
          Group("5", label="", layout='monadtall'),
          Group("6", label="", layout='monadtall'),
          Group("7", label="", layout='monadtall'),
          Group("8", label="", layout='monadtall'),
          Group("9", label="", layout='floating'),
          Group("10", label="", layout="floating"),]

# Allow MODKEY+[0 through 9] to bind to groups
# MOD4 + index Number : Switch to Group[index]
# MOD4 + shift + index Number : Send active window to another Group
dgroups_key_binder = simple_key_binder(mod)

layout_theme = {
    "border_width": 3,
    "margin": 8,
    "border_focus": theme["purple"],
    "border_normal": theme["bg"]
}

layouts = [
    # layout.MonadWide(**layout_theme),
    # layout.Bsp(**layout_theme),
    #layout.Stack(stacks=2, **layout_theme),
    # layout.RatioTile(**layout_theme),
    #layout.Tile(shift_windows=True, **layout_theme),
    # layout.VerticalTile(**layout_theme),
    # layout.Matrix(**layout_theme),
    # layout.Zoomy(**layout_theme),
    #layout.Stack(num_stacks=2),
    layout.Columns(**layout_theme),
    layout.MonadTall(**layout_theme),
    #layout.RatioTile(**layout_theme),
    layout.Max(**layout_theme),
    layout.Floating(**layout_theme),
]

floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    # default_float_rules include: utility, notification, toolbar, splash, dialog,
    # file_progress, confirm, download and error.
        *layout.Floating.default_float_rules,
        Match(wm_class="Pavucontrol"),
        Match(wm_class="Blueman-manager"),
        Match(wm_class="Nm-connection-editor"),
        Match(wm_class="Xarchiver"),
        Match(wm_instance_class="htop"),
        Match(wm_instance_class="nmtui"),
        Match(wm_instance_class="ikhal"),
    ],
    border_focus=theme["teal"],
    border_normal=theme["bg"],
    border_width=3,
)

########################################################################################
# Widgets
########################################################################################

# Set colors for powerline widgets
def powerline_widgets(c1,c2,c3,c4,c5,c6):
    return (
        widget.TextBox(
            text=' ',
            font="Font Awesome 6 Free",
            background=theme["bg"],
            foreground=theme[c1],
            padding=-10,
            fontsize=45
        ),
        widget.TextBox(
            text="",
            font="Font Awesome 6 Free",
            foreground=theme["bg"],
            background=theme[c1],
            mouse_callbacks={
                'Button1': lambda: qtile.cmd_spawn(myTerm + ' --class htop -e htop')},
            padding=2,
        ),
        widget.CPU(
            foreground=theme["bg"],
            background=theme[c1],
            fmt="{}",
            format="{load_percent:>4}%",
            mouse_callbacks={
                'Button1': lambda: qtile.cmd_spawn(myTerm + ' --class htop -e htop')},
            padding=5,
            update_interval=2,
        ),
        widget.Sep(
            linewidth=0,
            padding=5,
            background=theme[c1],
        ),
        widget.TextBox(
            text="",
            font="Font Awesome 6 Free",
            foreground=theme["bg"],
            background=theme[c1],
            mouse_callbacks={
                'Button1': lambda: qtile.cmd_spawn(myTerm + ' --class htop -e htop')},
            padding=2,
        ),
        widget.Memory(
            foreground=theme["bg"],
            background=theme[c1],
            mouse_callbacks={
                'Button1': lambda: qtile.cmd_spawn(myTerm + ' --class htop -e htop')},
            fmt='{}',
            padding=5,
            format="{MemUsed:>4.0f}{mm}/{MemTotal:.0f}{mm}",
            measure_mem="M",
            update_interval=2,
        ),

        # ---------------------------------
        widget.TextBox(
            text=' ',
            font="Font Awesome 6 Free",
            background=theme[c1],
            foreground=theme[c2],
            padding=-10,
            fontsize=45,
        ),
        widget.TextBox(
            text="",
            mouse_callbacks={
                "Button1": redshiftTog,
                "Button4": redshiftInc,
                "Button5": redshiftDec,
            },
            foreground=theme["bg"],
            background=theme[c2],
            padding=5,
        ),
        widget.GenPollText(
            fmt="{}",
            func=redshift,
            update_interval=0.2,
            mouse_callbacks={
                "Button1": redshiftTog,
                "Button4": redshiftInc,
                "Button5": redshiftDec,
            },
            foreground=theme["bg"],
            background=theme[c2],
            padding=5,
        ),
        widget.TextBox(
            text="",
            mouse_callbacks={
                "Button4": lambda: qtile.cmd_spawn("brightnessctl set +5%"),
                "Button5": lambda: qtile.cmd_spawn("brightnessctl set 5%-")
            },
            foreground=theme["bg"],
            background=theme[c2],
            padding=5,
        ),
        widget.Backlight(
            backlight_name="intel_backlight",
            change_command=None,
            mouse_callbacks={
                "Button4": lambda: qtile.cmd_spawn("brightnessctl set +5%"),
                "Button5": lambda: qtile.cmd_spawn("brightnessctl set 5%-")
            },
            scroll=True,
            foreground=theme["bg"],
            background=theme[c2],
            padding=5,
        ),

        # ---------------------------------
        widget.TextBox(
            text=' ',
            font="Font Awesome 6 Free",
            background=theme[c2],
            foreground=theme[c3],
            padding=-10,
            fontsize=45,
        ),
        widget.Battery(
            battery=1,
            format="{char}",
            charge_char="",
            discharge_char="",
            full_char="",
            unknown_char="",
            empty_char="",
            show_short_text=False,
            low_foreground="FF0000",
            foreground=theme["bg"],
            background=theme[c3],
            fontsize=18,
            padding=5,
            update_interval=2,
        ),
        widget.Battery(
            battery=1,
            notify_below=10,
            format="{percent:2.0%}",
            show_short_text=False,
            foreground=theme["bg"],
            background=theme[c3],
            padding=5,
            update_interval=2,
        ),
        widget.Battery(
            battery=0,
            format="{char}",
            charge_char="",
            discharge_char="",
            full_char="",
            unknown_char="",
            empty_char="",
            show_short_text=False,
            foreground=theme["bg"],
            background=theme[c3],
            fontsize=18,
            padding=5,
            update_interval=2,
        ),
        widget.Battery(
            battery=0,
            notify_below=10,
            format="{percent:2.0%}",
            show_short_text=False,
            foreground=theme["bg"],
            background=theme[c3],
            padding=5,
            update_interval=2,
        ),

        # ---------------------------------
        widget.TextBox(
            text=' ',
            font="Font Awesome 6 Free",
            background=theme[c3],
            foreground=theme[c4],
            padding=-10,
            fontsize=45
        ),
        widget.Volume(
            foreground=theme["bg"],
            background=theme[c4],
            mouse_callbacks={
                'Button3': lambda: qtile.cmd_spawn("pavucontrol")},
            fmt='墳 {}',
            padding=5,
        ),

        # ---------------------------------
        widget.TextBox(
            text=' ',
            font="Font Awesome 6 Free",
            background=theme[c4],
            foreground=theme[c5],
            padding=-10,
            fontsize=45
        ),
        widget.KeyboardLayout(
            foreground=theme["bg"],
            background=theme[c5],
            fmt=' {}',
            configured_keyboards=["eu"],
            padding=5
        ),
        widget.TextBox(
            text=' ',
            font="Font Awesome 6 Free",
            background=theme[c5],
            foreground=theme[c6],
            padding=-10,
            fontsize=45
        ),
        widget.Clock(
            foreground=theme["bg"],
            background=theme[c6],
            format=" %a, %d/%m  %H:%M",
            mouse_callbacks={
                'Button1': lambda: qtile.cmd_spawn(myTerm + ' --class ikhal -e ikhal'),
            },
        ),

    )
    

# Widget funcs
def redshift():
    return subprocess.check_output(
        "source " + home + "/.scripts/redshift-env.sh && " +
        home + "/.scripts/redshift.sh temperature", shell=True, text=True)

def redshiftTog():
    return subprocess.check_output(
        "source " + home + "/.scripts/redshift-env.sh && " +
        home + "/.scripts/redshift.sh toggle", shell=True, text=True)

def redshiftInc():
    return subprocess.check_output(
        "source " + home + "/.scripts/redshift-env.sh && " +
        home + "/.scripts/redshift.sh increase", shell=True, text=True)

def redshiftDec():
    return subprocess.check_output(
        "source " + home + "/.scripts/redshift-env.sh && " +
        home + "/.scripts/redshift.sh decrease", shell=True, text=True)


##### DEFAULT WIDGET SETTINGS #####
widget_defaults = dict(
    font="JetBrainsMono NL Nerd Font",
    fontsize=14,
    padding=2,
    background=theme["bg"]
)
extension_defaults = widget_defaults.copy()


def init_widgets_list():
    widgets_list = [
        widget.CurrentLayoutIcon(
            custom_icon_paths=[home + "/.config/qtile/icons"],
            foreground=theme["bg"],
            #background="#2C3E50",
            background=theme["purple"],
            padding=5,
            scale=0.8
        ),
        widget.TextBox(
            #text="",
            text="",
            font="Font Awesome 6 Free",
            fmt="{:2}",
            fontshadow=None,
            fontsize=47,
            foreground=theme["purple"],
            #foreground="#2C3E50",
            max_chars=0,
            padding=-10,
        ),
        widget.Sep(
            linewidth=0,
            padding=5,
            foreground=theme["bg"],
        ),

        # ---------------------------------
        widget.GroupBox(
            fontsize=16,
            margin_y=4,
            margin_x=0,
            padding_y=0,
            padding_x=5,
            borderwidth=3,
            active=theme["fg"],
            inactive=theme["bg5"],
            rounded=False,
			disable_drag=True,
            highlight_color=theme["bg4"],
            highlight_method="line",
            this_current_screen_border=theme["purple"],
            this_screen_border=colors[4],
            other_current_screen_border=colors[6],
            other_screen_border=colors[4],
            foreground=theme["fg"],
            urgent_border=theme["bg"],
            urgent_text=theme["red"]
        ),
        widget.TextBox(
            text='|',
            foreground=theme["bg5"],
            padding=2,
            fontsize=14
        ),
        widget.Prompt(
            prompt = "run: ",
        ),
        widget.WindowName(
            font="JetBrainsMono NL Nerd Font",
            foreground=theme["fg"],
            padding=5
        ),
        widget.Sep(
            linewidth=0,
            padding=6,
            foreground=colors[0],
        ),

        # ---------------------------------
        # Right side
        # ---------------------------------

        widget.Systray(
            padding=5,
        ),

        *powerline_widgets("surface1","lavender","pink","purple","dblue","teal"),

        # ---------------------------------
        #widget.TextBox(
        #    text=' ',
        #    font="Font Awesome 6 Free",
        #    background=theme["green"],
        #    foreground=theme["surface"],
        #    padding=-10,
        #    fontsize=45,
        #),
        #widget.Systray(
        #    background=theme["surface"],
        #    padding=5,
        #),

        # ---------------------------------
        widget.TextBox(
            text=' ',
            font="Font Awesome 6 Free",
            background=theme["teal"],
            foreground=theme["bg"],
            padding=-10,
            fontsize=45,
        ),
        widget.TextBox(
            text="",
            font="Font Awesome 6 Free",
            fontsize=15,
            padding=8,
            foreground=theme["fg"],
            background=theme["bg"],
            #background="#2C3E50",
            mouse_callbacks={"Button1": lambda: qtile.cmd_spawn(
                "rofi -theme ~/.config/rofi/configPower.rasi -show power-menu -modi power-menu:~/.scripts/rofi-power-menu")
            },
        ),
    ]
    return widgets_list


def init_widgets_screen1():
    widgets_screen1 = init_widgets_list()
    return widgets_screen1


def init_widgets_screen2():
    widgets_screen2 = init_widgets_list()
    return widgets_screen2


def init_screens():
    return [
        Screen(top=bar.Bar(widgets=init_widgets_screen1(), opacity=1.0, size=24)),
        Screen(top=bar.Bar(widgets=init_widgets_screen2(), opacity=1.0, size=24)),
    ]


if __name__ in ["config", "__main__"]:
    screens = init_screens()
    widgets_list = init_widgets_list()
    widgets_screen1 = init_widgets_screen1()
    widgets_screen2 = init_widgets_screen2()


def window_to_prev_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i - 1].name)


def window_to_next_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i + 1].name)


def window_to_previous_screen(qtile):
    i = qtile.screens.index(qtile.current_screen)
    if i != 0:
        group = qtile.screens[i - 1].group.name
        qtile.current_window.togroup(group)


def window_to_next_screen(qtile):
    i = qtile.screens.index(qtile.current_screen)
    if i + 1 != len(qtile.screens):
        group = qtile.screens[i + 1].group.name
        qtile.current_window.togroup(group)


def switch_screens(qtile):
    i = qtile.screens.index(qtile.current_screen)
    group = qtile.screens[i - 1].group
    qtile.current_screen.set_group(group)


mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False

auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# Default LG3D
wmname = "qtile"

########################################################################################
# Hooks
########################################################################################

@hook.subscribe.startup_once
def start_once():
    subprocess.call([home + "/.config/qtile/autostart.sh"])

@hook.subscribe.float_change
def center_floating_win():
    window = qtile.current_window
    if window.floating and not window.fullscreen:
        window.cmd_set_size_floating(900, 600)
        window.cmd_center()

@hook.subscribe.layout_change
def tile_floating_on_layout_change(layout, group):
    for window in group.windows:
        window.floating = False


@hook.subscribe.client_new
async def move_apps_to_group(window):
    wm_class = window.window.get_wm_class()
    if wm_class[1] == "Spotify":
        window.togroup("9")
