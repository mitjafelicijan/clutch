![Preview](https://github.com/mitjafelicijan/clutch/assets/296714/dca4a47a-d33e-46fd-8a45-b54b633909a2)

# Nested X11 dwm sessions

Clutch allows you to run nested `dwm` session inside your existing X session.
This comes in handy when you already have a desktop environment running (like
Gnome) but you want to have a tiling window manager as well.

> [!IMPORTANT]
> All the tests were done on Xorg so if you are using Wayland this may not work
> for you. Patches welcome.

# Why?

Personally I like having Gnome as my main window manager because it comes with
all the niceties and quality of life stuff like network management etc. But for
coding I do prefer tiling window managers.

There are some extensions available for Gnome that introduce tiling but none of
them were up to par with proper tiling window manager like `dwm` or `i3`.

This approach DOES NOT require `dwm` to be installed on your machine. All these
dependencies will be downloaded and compiled automatically.

# How?

This project heavily relies on several [Suckless](https://suckless.org/)
programs such as:

- dwm - https://dwm.suckless.org/
- dmenu - https://tools.suckless.org/dmenu/
- st - https://st.suckless.org/

These three programs together gives us tiling window manager, lean terminal
emulator and dynamic menu (program launcher).

All this is achieved with [Xephyr](https://en.wikipedia.org/wiki/Xephyr) which
allows us to run nested X server.

> [!IMPORTANT]
> Because some of the applications are downloaded and need to be compiled GCC
> or Clang is also required. 

## Tips and tricks

- If you resize the window execute `xrandr` program in your `Xephyr` session to
  Make `dwm` the size of the window.
- Clutch respects `$XDG_CACHE_HOME`.
  
## Acknowledgment

- https://stackoverflow.com/a/31443098

## Alternatives

- https://github.com/paperwm/PaperWM
- https://github.com/material-shell/material-shell
- https://github.com/pop-os/shell
- https://github.com/gTile/gTile
- https://github.com/regolith-linux

## License

[clutch](https://github.com/mitjafelicijan/clutch) was written by [Mitja
Felicijan](https://mitjafelicijan.com) and is released under the BSD
two-clause license, see the LICENSE file for more information.
