#!/bin/bash

# Save a shot of the screen or a window.
# 'import' is from ImageMagick.

if [ "$1" = "full" ]; then
    winid="root"
elif [ "$1" = "window" ]; then
    line=$(xprop -root | grep '_NET_ACTIVE_WINDOW(WINDOW)')
    winid=${line:40}
fi

if [ -n "${winid}" ]; then
    import -window "${winid}" /tmp/screenshot-$(date +%F_%H%M%S).png
fi
