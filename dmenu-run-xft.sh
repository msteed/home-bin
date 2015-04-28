#!/bin/sh

dmenu="dmenu -fn LiberationMono-10 -nb \#a54242 -nf \#c5c8c6 -sb \#b58900 -sf \#073642"

cachedir=${XDG_CACHE_HOME:-"$HOME/.cache"}
if [ -d "$cachedir" ]; then
	cache=$cachedir/dmenu_run
else
	cache=$HOME/.dmenu_cache # if no xdg dir, fall back to dotfile in ~
fi
(
	IFS=:
	if stest -dqr -n "$cache" $PATH; then
		stest -flx $PATH | sort -u | tee "$cache" | eval $dmenu
	else
		eval $dmenu $xft "$@" < "$cache"
	fi
) | ${SHELL:-"/bin/sh"} &
