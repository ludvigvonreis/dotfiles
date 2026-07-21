#!/usr/bin/env python3
"""
Minimal native-messaging <-> MPRIS bridge.

Owns its own bus name (org.mpris.MediaPlayer2.mprisbridge) instead of
piggybacking on Firefox's built-in, single-session MPRIS handler. Because
each tab reports its *real* play/pause state (see content.js), this host
can pick the tab that's actually playing rather than whichever one Firefox
happened to touch last, and route PlayPause to that specific tab.

Requires: python3-gobject (GLib) + pydbus
  pip install pydbus --break-system-packages   (or distro package)
"""
import sys
import json
import struct
import threading

from pydbus import SessionBus
from pydbus.generic import signal
from gi.repository import GLib

# import atexit
# logs = open("log.txt", "w")
# atexit.register(logs.close)

# ---- Native messaging framing (4-byte little-endian length + JSON) ----

def read_message():
	raw_length = sys.stdin.buffer.read(4)
	if len(raw_length) == 0:
		sys.exit(0)
	length = struct.unpack("<I", raw_length)[0]
	return json.loads(sys.stdin.buffer.read(length).decode("utf-8"))


def send_message(msg):
	data = json.dumps(msg).encode("utf-8")
	sys.stdout.buffer.write(struct.pack("<I", len(data)))
	sys.stdout.buffer.write(data)
	sys.stdout.buffer.flush()


# ---- Per-tab state registry ----

class TabRegistry:
	def __init__(self):
		self.tabs = {}  # tabId -> state dict
		self.lock = threading.Lock()

	def update(self, tab_id, state):
		with self.lock:
			self.tabs[tab_id] = state

	def remove(self, tab_id):
		with self.lock:
			self.tabs.pop(tab_id, None)

	def active(self):
		"""Prefer a tab that's actually playing; else the most recent one."""
		with self.lock:
			playing = [item for item in self.tabs.items() if item[1].get("playing")]
			if playing:
				return playing[0]
			if self.tabs:
				return next(reversed(self.tabs.items()))
			return None, None


registry = TabRegistry()


# ---- MPRIS interfaces ----
# Real implementations should also cover Seek/Position/volume/CanGoNext etc.
# This is intentionally the minimum PlayPause-round-trip.

ROOT_XML = """
<node>
  <interface name="org.mpris.MediaPlayer2">
	<property name="Identity" type="s" access="read"/>
	<property name="CanQuit" type="b" access="read"/>
	<property name="CanRaise" type="b" access="read"/>
	<property name="HasTrackList" type="b" access="read"/>
  </interface>
</node>
"""

PLAYER_XML = """
<node>
  <interface name="org.mpris.MediaPlayer2.Player">
	<method name="PlayPause"/>
	<method name="Play"/>
	<method name="Pause"/>
	<method name="Next"/>
	<method name="Previous"/>
	<property name="PlaybackStatus" type="s" access="read"/>
	<property name="Metadata" type="a{sv}" access="read"/>
	<property name="CanPlay" type="b" access="read"/>
	<property name="CanPause" type="b" access="read"/>
	<property name="CanGoNext" type="b" access="read"/>
	<property name="CanGoPrevious" type="b" access="read"/>
 	<property name="CanControl" type="b" access="read"/>
  </interface>
</node>
"""


class MPRISRoot:
	dbus = ROOT_XML
	Identity = "MPRIS Bridge"
	CanQuit = False
	CanRaise = False
	HasTrackList = False


class MPRISPlayer:
	dbus = PLAYER_XML
	PropertiesChanged = signal()
	CanPlay = True
	CanPause = True
	CanControl = True
	CanGoNext = True
	CanGoPrevious = True

	def _send_cmd(self, cmd):
		tab_id, _ = registry.active()
		if tab_id is not None:
			send_message({"cmd": cmd, "tabId": tab_id})

	def PlayPause(self):
		self._send_cmd("playpause")

	def Play(self):
		self._send_cmd("play")

	def Pause(self):
		self._send_cmd("pause")

	def Next(self):
		self._send_cmd("next")
	
	def Previous(self):
		self._send_cmd("prev")

	@property
	def PlaybackStatus(self):
		_, state = registry.active()
		if state is None:
			return "Stopped"
		return "Playing" if state.get("playing") else "Paused"

	@property
	def Metadata(self):
		_, state = registry.active()
		if state is None:
			return {}

		return {
			"xesam:title": GLib.Variant("s", state.get("title", "")),
			"xesam:url": GLib.Variant("s", state.get("url", "")),
		}


# ---- stdin reader thread: feeds the registry, GLib loop handles D-Bus ----

def stdin_loop():
	while True:
		msg = read_message()
		# logs.write(json.dumps(msg) + "\n")
		# logs.flush()
		if msg.get("type") == "state":
			registry.update(msg["tabId"], msg["state"])
		elif msg.get("type") == "removed":
			registry.remove(msg["tabId"])


def main():
	bus = SessionBus()
	bus.publish(
		"org.mpris.MediaPlayer2.mprisbridge",
		("/org/mpris/MediaPlayer2", MPRISRoot()),
		("/org/mpris/MediaPlayer2", MPRISPlayer()),
	)
	
	# notifications = bus.get(
	# 	"org.freedesktop.Notifications",
	# 	"/org/freedesktop/Notifications",
	# )

	# notifications.Notify(
	# 	"MyApp",        # app_name
	# 	0,              # replaces_id
	# 	"",             # app_icon
	# 	"Title",        # summary
	# 	"Hello world!", # body
	# 	[],             # actions
	# 	{},             # hints
	# 	5000,           # expire_timeout (ms)
	# )

	threading.Thread(target=stdin_loop, daemon=True).start()
	GLib.MainLoop().run()


if __name__ == "__main__":
	main()
