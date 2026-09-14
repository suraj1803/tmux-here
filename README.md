# tm

A tiny shell wrapper around `tmux` that opens or attaches to a session named after your folder — no more manually naming sessions or remembering which one goes with which project.

## How to use

```bash
tm ~/code/myapp
```

That's it. If a `myapp` session exists, you're dropped into it. If not, one is created (in that folder) and you're dropped into it.

## Why

Typing `tmux new -s myproject -c ~/code/myproject` (and remembering whether that session already exists) gets old fast. `tm` collapses that into one command, keyed on the folder you're pointing at.

## Features

- **Session name = folder name.** `tm ~/code/myapp` creates/attaches a session called `myapp`.
- **Resolves relative paths.** `tm .`, `tm ..`, `tm ../other-project` all work and produce sensible session names based on the real path, not the literal argument.
- **No nested tmux.** Whether the session already exists or needs to be created, `tm` always creates detached first and then uses `switch-client` (if you're already inside tmux) or `attach-session` (if you're not) — so you never hit tmux's nested-session mess.

## Installation

### Option A: Shell function (For Now)

Save the script somewhere, e.g. `~/.config/tm/tm.sh`, then source it from your shell rc file:

```bash
# ~/.bashrc or ~/.zshrc
source ~/.config/tm/tm.sh
```

Reload your shell:

```bash
source ~/.bashrc   # or ~/.zshrc
```

### Option B: Standalone executable

```bash
chmod +x tm
mv tm /usr/local/bin/tm
```

No sourcing needed — `tm` is just a regular command on your `$PATH`.

## Usage

```bash
tm <folder>      # open or attach a session named after <folder>
tm .              # use the current directory
tm ..             # use the parent directory
```


## Uninstalling / removing for the session

Remove just the function from your current shell:

```bash
unset -f tm
```

To stop it loading permanently, remove or comment out the `source` line in your shell rc file.

