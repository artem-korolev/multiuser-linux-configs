# multiuser-linux-config

Collection of configurations for programs that I use.
Idea is to have it in repo, so when I install linux on another machine I can
confugure it sipmly by fetching this repo and running one command.
Another cool thing: when I change config on one machine - I can push my changes to
repo and apply this change on all other machines that I use simply by pulling chages
from this repo.

# Usage

```bash
$ cd ~/
$ git clone https://github.com/artem-korolev/multiuser-linux-configs.git .multiuser-linux-configs

```

This will clone this repo into your ~/ home directory under ".multiuser-linux-configs" name.
So it will be hidden

```bash
$ bash .multiuser-linux-configs/bin/check.sh
```

It will show you list of configs that exists in your system, but not linked to repo.
If result is empty, then all configs are linked, or maybe corresponding applications
are not installed, or do not have user configs yet

```bash
$ bash .multiuser-linux-configs/bin/check.sh --fix
```

This will backup not linked configs inside ~/.configs.bak directory, so you always can restore it
and after that it will link repo configs into your user directory
