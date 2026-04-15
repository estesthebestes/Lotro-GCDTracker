# GCD Timer originally made by meobius92

A lightweight [LOTRO](https://www.lotro.com/) plugin that prints skill cooldown timers to the chat window whenever one of your skills goes on cooldown.

## Features

- Hooks into every trained skill's `ResetTimeChanged` event at load time
- Prints `[SkillTimer] <Skill Name>: <X.Xs` remaining` to the shell when a cooldown starts
- `/st` slash command to refresh the skill list after a trait swap or level-up

## Installation

1. Copy the `moebius92/` folder into your LOTRO plugins directory:
   ```
   %APPDATA%\The Lord of the Rings Online\Plugins\
   ```
   The final path should look like:
   ```
   ...\Plugins\moebius92\SkillTimer\Main.lua
   ...\Plugins\moebius92\SkillTimer.plugin
   ```
2. Launch LOTRO and load the plugin via the Plugin Manager or:
   ```
   /plugins load SkillTimer
   ```

## Usage

| Action | Result |
|--------|--------|
| Load plugin | Begins tracking all trained skills automatically |
| Trigger a skill cooldown in-game | `[SkillTimer] <Skill>: <X.X>s` appears in chat |
| `/st` | Re-scans trained skills (use after trait swaps or level-ups) |

## File Structure

```
moebius92/
├── SkillTimer.plugin          # Plugin manifest
├── Handlers/
│   ├── __init__.lua           # Package entry point
│   └── Handlers.lua           # AddEventHandler / RemoveEventHandler utilities
└── SkillTimer/
    └── Main.lua               # Core cooldown tracking logic
```

## Author

**moebius92** — v1.0
