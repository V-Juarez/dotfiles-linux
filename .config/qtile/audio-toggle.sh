##!/bin/bash
#
# HDMI=42
# SPEAKERS=61
#
# # Obtener SOLO el sink activo dentro de la sección Sinks
# CURRENT=$(wpctl status | awk '/Default Configured Devices:/,/^$/' | grep Audio/Sink | awk '{print $3}')
#
# if [ "$CURRENT" = "$HDMI" ]; then
#   wpctl set-default "$SPEAKERS"
#   notify-send "🔊 Audio cambiado" "Built-in Speakers"
# else
#   wpctl set-default "$HDMI"
#   notify-send "🔊 Audio cambiado" "HDMI"
# fi
#
# wpctl set-default "$HDMI" 2>/dev/null
#
#!/bin/bash

CURRENT=$(wpctl status | awk '/Sinks:/,/Sources:/' | grep '*' | awk '{print $2}' | tr -d '.')

if [ "$CURRENT" = "42" ]; then
  wpctl set-default 61
else
  wpctl set-default 42
fi
