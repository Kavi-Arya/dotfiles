from fabric.widgets.box import Box
from fabric.widgets.label import Label
from fabric.widgets.datetime import DateTime
from fabric.widgets.centerbox import CenterBox
from fabric.widgets.button import Button
from fabric.widgets.wayland import WaylandWindow as Window
from fabric.hyprland.widgets import Workspaces, WorkspaceButton
from gi.repository import GLib, Gdk
# from modules.systemtray import SystemTray
from modules.notch import Notch
import modules.icons as icons
# from dashboard import Dashboard
from gi.repository import GLib
import subprocess

class CpubarsWidget(Label):
    def __init__(self, name="cpu-bars", interval=1, rust_binary_path="/home/kvl/src/cpubarsRust/cpubars/target/debug/cpubars"):
        super().__init__(name=name)
        self.interval = interval
        self.rust_binary_path = rust_binary_path
        self.update_bars()

    def update_bars(self):
        try:
            # Use the Rust binary instead of the previous command
            bars = subprocess.check_output([self.rust_binary_path]).decode().strip()
            self.set_markup(bars)
        except Exception as e:
            self.set_markup(f"Error: {e}")
        # Schedule the next update
        GLib.timeout_add_seconds(self.interval, self.update_bars)

# class CpubarsWidget(Label):
#     def __init__(self, name="cpu-bars", interval=1):
#         super().__init__(name=name)
#         self.interval = interval
#         self.update_bars()
#
#     def update_bars(self):
#         try:
#             bars = subprocess.check_output(["/home/kvl/.config/fabric/modules/cpubars"]).decode().strip()
#             self.set_markup(bars)
#         except Exception as e:
#             self.set_markup(f"Error: {e}")
#         GLib.timeout_add_seconds(self.interval, self.update_bars)
#

class NettrfWidget(Label):
    def __init__(self, name="nettrf", interval=1, rust_binary_path="/home/kvl/src/nettrf/src/main"):
        super().__init__(name=name)
        self.interval = interval
        self.rust_binary_path = rust_binary_path
        self.update_traffic()

    def update_traffic(self):
        try:
            # Use the Rust binary instead of the previous command
            bars = subprocess.check_output([self.rust_binary_path]).decode().strip()
            self.set_markup(bars)
        except Exception as e:
            self.set_markup(f"Error: {e}")
        # Schedule the next update
        GLib.timeout_add_seconds(self.interval, self.update_traffic)

# class NettrfWidget(Label):
#     def __init__(self, name="nettrf", interval=1):
#         super().__init__(name=name)
#         self.interval = interval
#         self.update_traffic()
#
#     def update_traffic(self):
#         try:
#             traffic = subprocess.check_output(["/home/kvl/.config/fabric/modules/nettrf"]).decode().strip()
#             self.set_markup(traffic)
#         except Exception as e:
#             self.set_markup(f"Error: {e}")
#         GLib.timeout_add_seconds(self.interval, self.update_traffic)

class ArchUpdatesWidget(Label):
    def __init__(self, name="arch-updates", interval=60, rust_binary_path="/home/kvl/src/archupdates/target/debug/archupdates"):
        super().__init__(name=name)
        self.interval = interval
        self.rust_binary_path = rust_binary_path
        self.update_updates()

    def update_updates(self):
        try:
            # Use the Rust binary instead of the previous command
            bars = subprocess.check_output([self.rust_binary_path]).decode().strip()
            self.set_markup(bars)
        except Exception as e:
            self.set_markup(f"Error: {e}")
        # Schedule the next update
        GLib.timeout_add_seconds(self.interval, self.update_updates)

class ModeTell(Label):
    def __init__(self, name="mode", interval=0.1):
        super().__init__(name=name)
        self.interval = interval
        self.modeUpdates()

    def modeUpdates(self):
        try:
            updates = subprocess.check_output(["/home/kvl/.config/fabric/modules/showMode.sh"]).decode().strip()
            self.set_markup(updates)
        except Exception as e:
            self.set_markup(f"Error: {e}")
        GLib.timeout_add_seconds(self.interval, self.modeUpdates)

class CpuTemp(Label):
    def __init__(self, name="cpu_temp", interval=1):
        super().__init__(name=name)
        self.interval = interval
        self.cpuTempUpdates()

    def cpuTempUpdates(self):
        try:
            updates = subprocess.check_output(["/home/kvl/.config/fabric/modules/cpu-temp"]).decode().strip()
            self.set_markup(updates)
        except Exception as e:
            self.set_markup(f"Error: {e}")
        GLib.timeout_add_seconds(self.interval, self.cpuTempUpdates)


# class date_time(Label):
#     def __init__(self, name="date_time", interval=1):
#         super().__init__(name=name)
#         self.interval = interval
#         self.date_time_update()
#
#     def date_time_update(self):
#         try:
#             updates = subprocess.check_output(["/home/kvl/.config/fabric/modules/date_time"]).decode().strip()
#             self.set_markup(updates)
#         except Exception as e:
#             self.set_markup(f"Error: {e}")
#         GLib.timeout_add_seconds(self.interval, self.date_time_update)

class Bar(Window):
    def __init__(self, **kwargs):
        super().__init__(
            name="bar",
            layer="top",
            anchor="left top right",
            margin="-8px -4px -8px -4px",
            exclusivity="auto",
            visible=True,
            all_visible=True,
        )
        
        self.workspaces = Workspaces(
            name="workspaces",
            invert_scroll=True,
            empty_scroll=True,
            v_align="fill",
            orientation="h",
            spacing=10,
            buttons=[WorkspaceButton(id=i, label="") for i in range(1, 11)],
        )

        # self.systray = SystemTray()  # Revert to original SystemTray

        self.date_time = DateTime(name="date-time", formatters=["%d %b %y (%a) %r"], h_align="center", v_align="center")
        self.cpu_temp = CpuTemp(name="cpu_temp")
        self.cpubars = CpubarsWidget(name="cpu-bars")
        self.nettrf = NettrfWidget(name="nettrf")
        self.arch_updates = ArchUpdatesWidget(name="arch-updates")
        self.modeTell = ModeTell(name="mode")

        self.button_apps = Button(
            name="button-bar",
            on_clicked=lambda *_: self.search_apps(),
            child=Label(
                name="button-bar-label",
                markup=icons.apps
            )
        )
        self.button_apps.connect("enter_notify_event", self.on_button_enter)
        self.button_apps.connect("leave_notify_event", self.on_button_leave)
        
        self.button_power = Button(
            name="button-bar",
            on_clicked=lambda *_: self.power_menu(),
            child=Label(
                name="button-bar-label",
                markup=icons.shutdown
            )
        )
        self.button_power.connect("enter_notify_event", self.on_button_enter)
        self.button_power.connect("leave_notify_event", self.on_button_leave)

        self.bar_inner = CenterBox(
            name="bar-inner",
            orientation="h",
            h_align="fill",
            v_align="center",
            start_children=Box(
                name="start-container",
                spacing=4,
                orientation="h",
                children=[
                    self.button_apps,
                    Box(name="workspaces-container", children=[self.workspaces]),
                    self.arch_updates,
                    self.nettrf,  # Move nettrf next to workspaces
                ]
            ),
            end_children=Box(
                name="end-container",
                spacing=4,
                orientation="h",
                children=[
                    self.modeTell,
                    self.cpubars,  # Add the cpubars widget here
                    self.cpu_temp,
                    # self.systray,
                    self.date_time,
                    self.button_power,
                ],
            ),
        )

        self.children = self.bar_inner

        self.hidden = False

        self.show_all()

    def on_button_enter(self, widget, event):
        window = widget.get_window()
        if window:
            window.set_cursor(Gdk.Cursor(Gdk.CursorType.HAND2))

    def on_button_leave(self, widget, event):
        window = widget.get_window()
        if window:
            window.set_cursor(None)

    def on_button_clicked(self, *args):
        # Ejecuta notify-send cuando se hace clic en el botón
        GLib.spawn_command_line_async("uwsm app -- zen-browser google.com")

    def search_apps(self):
        GLib.spawn_command_line_async("fabric-cli exec ax-shell 'notch.open_notch(\"launcher\")'")

    def power_menu(self):
        GLib.spawn_command_line_async("fabric-cli exec ax-shell 'notch.open_notch(\"power\")'")

    def toggle_hidden(self):
        self.hidden = not self.hidden
        if self.hidden:
            self.bar_inner.add_style_class("hidden")
        else:
            self.bar_inner.remove_style_class("hidden")

