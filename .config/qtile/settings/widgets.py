import os
from libqtile.lazy import lazy
from libqtile import widget
from .theme import colors


# Get the icons at https://www.nerdfonts.com/cheat-sheet (you need a Nerd Font)

def base(fg='text', bg='dark'): 
    return {
        'foreground': colors[fg],
        'background': colors[bg]
    }


def separator():
    return widget.Sep(**base(), linewidth=0, padding=5)


def icon(fg='text', bg='dark', fontsize=24, text="?"):
    return widget.TextBox(
        **base(fg, bg),
        fontsize=fontsize,
        text=text,
        padding=3
    )


def powerline(fg="light", bg="dark"):
    return widget.TextBox(
        **base(fg, bg),
        text=" ", # Icon: nf-oct-triangle_left
        fontsize=40,
        padding=-2
    )


def workspaces(): 
    return [
        separator(),
        widget.GroupBox(
            **base(fg='light'),
            font='UbuntuMono Nerd Font',
            fontsize=24,
            margin_y=3,
            margin_x=0,
            padding_y=8,
            padding_x=5,
            borderwidth=1,
            active=colors['active'],
            inactive=colors['inactive'],
            rounded=False,
            highlight_method='block',
            urgent_alert_method='block',
            urgent_border=colors['urgent'],
            this_current_screen_border=colors['focus'],
            this_screen_border=colors['grey'],
            other_current_screen_border=colors['dark'],
            other_screen_border=colors['dark'],
            disable_drag=True
        ),
        separator(),
        widget.WindowName(**base(fg='focus'), fontsize=14, padding=8),
        separator(),
    ]


primary_widgets = [
    *workspaces(),

    separator(),

    powerline('color4', 'dark'),

    icon(bg="color4", text=' '), # Icon: nf-fa-download
    
    widget.CheckUpdates(
        background=colors['color4'],
        colour_have_updates=colors['text'],
        colour_no_updates=colors['text'],
        no_update_string='0',
        display_format='{updates}',
        update_interval=1000,
        custom_command='checkupdates',
    ),

    powerline('color3', 'color4'),

    icon(bg="color3", text='󰨾 '),  # Icon: nf-fa-feed
    
    widget.Net(**base(bg='color3'), interface='enp0s25'),

    powerline('color2', 'color3'),

    widget.CurrentLayout(**base(bg='color2')),

    # widget.CurrentLayout(**base(bg='color2'), padding=5),

        # En tu barra:
    powerline('color1', 'color2'),
    icon(bg="color3", fontsize=17, text=' '),  # Icono calendario
    widget.Clock(**base(bg='color1'), format='%a %d %b %Y'),

    powerline('color2', 'color1'),
    icon(bg="color3", fontsize=17, text='󰺗 '),  # Icono reloj
    widget.Clock(**base(bg='color2'), format='%H:%M:%S'),

    powerline('dark', 'color1'),
    widget.TextBox(
        **base(bg='dark'),
        text='󰓀 ',
        fontsize=17,
        padding=5,
        mouse_callbacks={
            'Button1': lazy.spawn(os.path.expanduser("~/.config/qtile/audio-toggle.sh")),
            'Button3': lazy.spawn("pavucontrol"),
        }
    ),
    powerline('dark', 'color1'),
    widget.TextBox(
        **base(bg='color1'),
        fontsize=17,
        text=' 󰐥 ',
        mouse_callbacks={
            'Button1': lazy.spawn('bash /home/ant/.config/rofi/powermenu.sh')
        },
    ),

     powerline('dark', 'color1'),
    widget.Systray(background=colors['dark'], padding=5),
]

secondary_widgets = [
    *workspaces(),

    separator(),

    powerline('color1', 'dark'),

    # widget.CurrentLayout(**base(bg='color1')),

    widget.CurrentLayout(**base(bg='color1'), padding=5),

    powerline('color2', 'color1'),
    widget.Volume(
        fmt="󱝉  {}%",
        volume_up_command="pactl set-sink-volume @DEFAULT_SINK@ +5%",
        volume_down_command="pactl set-sink-volume @DEFAULT_SINK@ -5%",
        mute_command="pactl set-sink-mute @DEFAULT_SINK@ toggle",
        check_mute_command="pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}'",
        **base(bg='dark'),
        fontsize=17,
        update_interval=0.5,
    ),

    powerline('color2', 'color1'),
    icon(bg="color3", fontsize=17, text=' '),  # Icono calendario
    widget.Clock(**base(bg='color1'), format='%a %d %b %Y'),

    powerline('color2', 'color1'),
    icon(bg="color3", fontsize=17, text='󰺗 '),  # Icono reloj
    widget.Clock(**base(bg='color2'), format='%H:%M:%S'),

    powerline('dark', 'color1'),
    widget.TextBox(
        **base(bg='color1'),
        fontsize=17,
        text=' 󰐥 ',
        mouse_callbacks={
            'Button1': lazy.spawn('bash /home/ant/.config/rofi/powermenu.sh')
        },
    ),

    powerline('dark', 'color2'),
]

widget_defaults = {
    'font': 'UbuntuMono Nerd Font Bold',
    'fontsize': 14,
    'padding': 1,
}
extension_defaults = widget_defaults.copy()
