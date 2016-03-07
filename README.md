# Getting Started

0. git clone to $HOME/.vim

1. Run "./util.py update rebuild install". This will
fetch all submodule repositories (the plugins themselves), recompile the ones
with compiled components, and will install symlinks and create directories to
make the vim config configurable.

# Staying Up-to-Date

To update plugins, run "./util.py update". Any changes to plugins with compiled
components will also require "rebuild" to be executed.

Updating will take a moderate amount of time, as it checks upstream repositories
of plugins for changes. It is also mysteriously quiet if there are no updates
found, but rest assured that it is working.
