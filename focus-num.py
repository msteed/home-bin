#!/usr/bin/env python

import i3ipc
import sys

num = int(sys.argv[1])

i3 = i3ipc.Connection()

focused = i3.get_tree().find_focused()
if focused.type == 'con':
    if focused.window_class == 'Chromium':
        pass # TODO: xdotool key ctrl+N, but without i3 intercepting it
    else:
        siblings = [con for con in focused.parent.descendents() if con.parent.id == focused.parent.id]
        if len(siblings) >= num:
            siblings[num - 1].command('focus')
