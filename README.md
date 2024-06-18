![Preview](https://github.com/mitjafelicijan/clutch/assets/296714/dca4a47a-d33e-46fd-8a45-b54b633909a2)

# Nested X11 dwm sessions

Clutch allows you to run nested `dwm` session inside your existing X session.
This comes in handy when you already have a desktop environment running (like
Gnome) but you want to have a tiling window manager as well.

> [!NOTE]
> Even though this was tested and works on X11 and on Wayland I use it on X11
> exclusively. So, your millage may wary.

All this can be achieved manually, this script just packages all the commands
into a nice package that is easy to use. Please check `clutch.sh` script to see
how it was done. Nothing magical happening here.

# Why?

Personally I like having Gnome as my main window manager because it comes with
all the niceties and quality of life stuff like network management, calendar
integration etc. You could achieve this in tiling window managers but it would
take more work. But for coding and the work I do regularly I do prefer tiling
window managers.

There are some extensions available for Gnome that introduce tiling but none of
them were up to par with proper tiling window manager like `dwm` or `i3`.

# How?

I had to choose a stack to make this project viable and not be this impossible
all in one solution. So I choose something that is easily reproducible on every
machine.

Because of this reason, this project heavily relies on several
[Suckless](https://suckless.org/) programs such as:

- dwm - https://dwm.suckless.org/
- dmenu - https://tools.suckless.org/dmenu/
- st - https://st.suckless.org/

These three programs together gives us tiling window manager, lean terminal
emulator and dynamic menu (program launcher).

All this is achieved with [Xephyr](https://en.wikipedia.org/wiki/Xephyr) which
allows us to run nested X server.

> [!IMPORTANT]
> Because some of the applications are downloaded and need to be compiled GCC
> or Clang and some other software is required. More on this is described later
> in the readme file.

This approach **DOES NOT** require `dwm`, `dmenu` or `st` to be installed on
your machine. All these dependencies will be downloaded and compiled
automatically.  When `$PATH` gets updated by the `clutch.sh` script all
downloaded versions will be preferred to system ones.

Tested on:

- Debian 12 Bookworm with GNOME Shell 43.9 on X11
- Ubuntu 24.04 Noble Numbat with GNOME Shell 46.0 on Wayland
- Fedora Workstation 40 with GNOME Shell 46.0 on Wayland
- Manjaro 24.0.2 with GNOME Shell 46.2 on X11

## Installation & Usage

Some prerequisites are required for the compilation of `dwm`, `dmenu` and `st`. 

```sh
# Debian 12 or Ubuntu 24.04
sudo apt install git gcc make libx11-dev libxinerama-dev libxft-dev xserver-xephyr x11-xserver-utils

# Fedora Workstation 40
sudo dnf install git gcc make xorg-x11-server-Xephyr libX11-devel libXinerama-devel libXft-devel xrandr

# Manjaro 24.0.2
sudo pacman -Su git gcc make base-devel extra/xorg-server-xephyr extra/libx11 extra/libxinerama extra/libxft extra/xorg-xrandr
```

After the installation of prerequisites we can continue with downloading and
bootstrapping of necessary dependencies.

```sh
git clone https://github.com/mitjafelicijan/clutch
cd clutch

# This will download dwm, dmenu, st and compile them all.
bash clutch.sh --bootstrap

# After that we can run our first nested desktop with.
bash clutch.sh --run
```

You can have multiple nested desktop environments and they will each get unique
X11 server display id.

> [!IMPORTANT]
> Since all the software will be downloaded to `$XDG_CACHE_HOME/clutch` you can
> put `clutch.sh` in your `$PATH` to make it easily available from everywhere.
> All code regarding this project lived in `clutch.sh` file so there is no fear
> of missing something when moving this tool around.

`clutch.sh` has several options available via arguments.

```sh
$ bash clutch.sh --help
Usage: clutch.sh [--bootstrap | --run]
  --bootstrap    Downloads and compiles required software
  --killall      Kills all running Xephyr and dwm instances
  --run          Runs dwm session in Xephyr
  --info         Displays all relavant paths and settings for Clutch
```

- Bootstrap should be used only for the first time to prepare environment.
- Most of the time you will be using `--run` which starts a session.
- `--killall` is a nuclear option if something goes wrong and some sessions are
  still running even though you closed them.
- Info with `--info` is there just to tell you which software versions are you
  running and which paths apply to your setup.

> [!TIP]
> If you resize the window manually execute `xrandr` program in your `Xephyr`
> session to Make `dwm` the size of the window.

## Configuration

All the configuration is done in the `clutch.sh` file itself.

```sh
# General settings for the Xephyr session.
DISPLAY_ID=50         # Start X server display id.
RESOLUTION=1280x720   # Initial resolution, can be resized later.
DPI=96                # DPI settings. On high DPI display adjust this value.
XEPHYR_FLAGS="-ac -br -noreset -no-host-grab" # Additional flags.

# Used when downloading the source tarballs.
DWM_VERSION=6.5    # dwm version used.
DMENU_VERSION=5.3  # dmenu version used.
ST_VERSION=0.9.2   # st terminal version used.
```

Additional configuration can be done after the bootstraping is done. Execute
`bash clutch.sh --info` to see all the paths used.

- dwm - `$CLUTCH_PATH/dwm-{version}/config.def.h`
- dmenu - `$CLUTCH_PATH/dmenu-{version}/config.def.h`
- st - `$CLUTCH_PATH/st-{version}/config.def.h`

`$CLUTCH_PATH` respects `$XDG_CACHE_HOME` variable and if nothing is set by
user defaults to `~/.config/clutch`.
 
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
