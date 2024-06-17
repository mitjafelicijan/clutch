# Nested X dwm sessions

Clutch is a simple script that allows you to run nested `dwm` session inside
your existing X session. This comes in handy when you already have a desktop
environment running (like Gnome) but you want to have a tiling window manager
as well.

> [!IMPORTANT]
> All the tests were done on Xorg so if you are using Wayland this may not work
> for you. Patches welcome.

# Why?

Personally I like having Gnome as my main window manager because it comes with
all the niceties and quality of life stuff like network management etc. But for
coding I do prefer tiling window managers.

There are some extensions available for Gnome that introduce tiling but none of
them were up to par with proper tiling window manager like `dwm` or `i3`.

# How?

This project heavily relies on several [Suckless](https://suckless.org/)
programs such as:

- dwm - https://dwm.suckless.org/
- dmenu - https://tools.suckless.org/dmenu/
- st - https://st.suckless.org/

These three programs together gives us tiling window manager, lean terminal
emulator and dynamic menu (program launcher).

## Tips and tricks

- If you resize the window execute `xrandr` program in your `Xephyr` session to
  make `dwm` the size of the window.

## Alternatives

- Gnome Shell extension which provides scrollable tiling - https://github.com/paperwm/PaperWM
