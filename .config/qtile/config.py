# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

import re

from typing import List  # noqa: F401

from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

mod = "mod4"
terminal = "kitty"

cursor_warp = True

keys = [
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(),
        desc="Move window focus to other window"),

    # Move windows around
    Key([mod, "shift"], "h", lazy.layout.swap_left(),
        desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.swap_right(),
        desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(),
        desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    Key([mod, "shift"], "space", lazy.layout.flip()),

    # Growing and shrinking
    Key([mod, "control"], "j", lazy.layout.shrink(),
        desc="Shrink window"),
    Key([mod, "control"], "k", lazy.layout.grow(), desc="Grow window"),
    Key([mod, "control"], "m", lazy.layout.maximize(), desc="Grow window"),
    Key([mod, "control"], "n", lazy.layout.normalize(), desc="Reset all window sizes"),


    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "BackSpace", lazy.window.kill(), desc="Kill focused window"),

    # QTile control
    Key([mod, "control"], "r", lazy.restart(), desc="Restart Qtile"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),

    # Launch applications
    Key([mod], "r", lazy.spawn("ulauncher")),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),

    # Focus screen
    Key([mod], "comma", lazy.to_screen(1)),
    Key([mod], "period", lazy.to_screen(0)),

    # Media keys
    Key([], "XF86AudioNext", lazy.spawn("mpc next")),
    Key([], "XF86AudioPrev", lazy.spawn("mpc prev")),
    Key([], "XF86AudioPlay", lazy.spawn("mpc toggle")),

    # general volume
    Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer -c 0 -q set Master 2dB+")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("amixer -c 0 -q set Master 2dB-")),

    # music volume
    Key(["mod4"], "XF86AudioRaiseVolume", lazy.spawn("mpc volume +5")),
    Key(["mod4"], "XF86AudioLowerVolume", lazy.spawn("mpc volume -5")),

    # Take a screenshot
    Key([], "Print", lazy.spawn("flameshot gui"))
]

groups = [Group(i) for i in "uiop"]
# wallpapers = ["~/pictures/wallpapers/flying girl 1.jpg", "~/pictures/wallpapers/flying girl 5.jpg", "~/pictures/wallpapers/flying girl 6.jpg", "~/pictures/wallpapers/flying girl 7.jpg"]

# @hook.subscribe.setgroup
# def set_wallpaper():
#     wallpaper = wallpapers[qtile.groups.index(qtile.current_group)]
#     qtile.paint_screen(qtile.current_screen, wallpaper, mode="fill")

for i in groups:
    keys.extend([
        # mod1 + letter of group = switch to group
        Key([mod], i.name, lazy.group[i.name].toscreen(),
            desc="Switch to group {}".format(i.name)),

        # mod1 + shift + letter of group = move focused window to group
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            desc="move focused window to group {}".format(i.name)),
    ])

colors = {
    "fg": "#abb2bf",
    "bg": "#181a1f",
    "barbg": "#181a1faa",
    "subbg": "#272b33",
    "lightred": "#e06c75",
    "darkred": "#be5046",
    "green": "#98c379",
    "lightorange": "#e5c07b",
    "darkorange": "#d19a66",
    "blue": "#61afef",
    "cyan": "#56b6c2",
    "magenta": "#c678dd",
    "gutter": "#636d83",
    "comment": "#70798a",
}

layouts = [
    layout.MonadTall(
        border_focus=colors["cyan"],
        margin=6
    ),
    layout.Max(),
]

widget_defaults = dict(
    font='Source Code Pro Bold',
    fontsize=13,
    padding=3,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(
                    active=colors["fg"],
                    inactive=colors["comment"],
                    highlight_method='line',
                    this_current_screen_border=colors["cyan"]
                ),
                widget.Sep(padding=15, linewidth=1, foreground=colors["comment"]),
                widget.CurrentLayout(),
                widget.Spacer(length=bar.STRETCH),
                widget.Systray(),
                widget.Sep(padding=15, linewidth=1, foreground=colors["comment"]),
                widget.CPU(
                    format='{load_percent}% /',
                    foreground=colors["magenta"]
                ),
                widget.ThermalSensor(
                    foreground=colors["magenta"],

                ),
                widget.Sep(padding=15, linewidth=1, foreground=colors["comment"]),
                widget.Memory(
                    format='{MemUsed: .0f} MB',
                    foreground=colors["blue"]
                ),
                widget.Sep(padding=15, linewidth=1, foreground=colors["comment"]),
                widget.NvidiaSensors(
                    # For some reason, {perf} doesn't work for me
                    # format='{perf}  / {fan_speed} / {temp}°C',
                    format='{fan_speed} / {temp}°C',
                    foreground=colors["green"]
                ),
                widget.Sep(padding=15, linewidth=1, foreground=colors["comment"]),
                widget.OpenWeather(
                    format='{weather_details}, {main_temp:.0f}°{units_temperature}',
                    app_key='997472523499bebd3652f39c26317658',
                    cityid='5781087',
                    metric=False,
                    foreground=colors["lightorange"]
                ),
                widget.Sep(padding=15, linewidth=1, foreground=colors["comment"]),
                widget.Volume(
                    foreground=colors["cyan"]
                ),
                widget.Sep(padding=15, linewidth=1, foreground=colors["comment"]),
                widget.Clock(format='%a, %b %d %H:%M'),
                widget.Spacer(length=5),
            ],
            30,
            background=colors["bg"]
        ),
        wallpaper='~/pictures/wallpapers/flying girl 1.jpg',
        wallpaper_mode='fill'
    ),
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(
                    active=colors["fg"],
                    inactive=colors["comment"],
                    highlight_method='line',
                    this_current_screen_border=colors["cyan"]
                ),
            ],
            30,
            background=colors["bg"]
        ),
        wallpaper='~/pictures/wallpapers/flying girl 5.jpg',
        wallpaper_mode='fill',
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    *layout.Floating.default_float_rules,
    Match(wm_class='confirmreset'),  # gitk
    Match(wm_class='makebranch'),  # gitk
    Match(wm_class='maketag'),  # gitk
    Match(wm_class='ssh-askpass'),  # ssh-askpass
    Match(title='branchdialog'),  # gitk
    Match(title='pinentry'),  # GPG key password entry
])
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"

def window_match_re(window, wmname=None, wmclass=None, role=None):
    """
    match windows by name/title, class or role, by regular expressions
    Multiple conditions will be OR'ed together
    """

    if not (wmname or wmclass or role):
        raise TypeError(
            "at least one of name, wmclass or role must be specified"
        )
    ret = False
    if wmname:
        ret = ret or re.match(wmname, window.name)
    try:
        if wmclass:
            cls = window.window.get_wm_class()
            if cls:
                for v in cls:
                    ret = ret or re.match(wmclass, v)
        if role:
            rol = window.window.get_wm_window_role()
            if rol:
                ret = ret or re.match(role, rol)
    except (xcffib.xproto.WindowError, xcffib.xproto.AccessError):
        return False
    return ret

@hook.subscribe.client_new
def on_new(c):
    if c.name == "Calculator":
        c.cmd_enable_floating()
    elif window_match_re(c, wmname="Factorio"):
        c.cmd_togroup("o")

