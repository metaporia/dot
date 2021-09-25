export XDG_SESSION_TYPE=x11
export GDK_BACKEND=x11
# note that startx is run at login by ~/.bash_profile
exec gnome-session
