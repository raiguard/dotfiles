#!/bin/python

from i3ipc import Connection, Event, WindowEvent


def on_window(i3: Connection, event: WindowEvent):
    if event.container.app_id == "org.qutebrowser.qutebrowser":
        tree_container = i3.get_tree().find_by_id(event.container.id)
        if tree_container.parent.layout != "tabbed":
            tree_container.command("splitv")
            tree_container.command("layout tabbed")


i3 = Connection()
i3.on(Event.WINDOW_NEW, on_window)
i3.main()
