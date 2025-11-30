# Debug UI Keyboard Reference

Quick reference guide for all keyboard shortcuts while debugging in Neovim.

## Main Debugging Controls

| Key | Action | Description |
|-----|--------|-------------|
| `F5` | Continue | Start debugging session or continue to next breakpoint |
| `F1` | Step Into | Step into function calls (go deeper) |
| `F2` | Step Over | Step over function calls (stay at current level) |
| `F3` | Step Out | Step out of current function (go back up) |
| `F7` | Toggle Debug UI | Show/hide the debug UI windows |
| `<leader>b` | Toggle Breakpoint | Add or remove breakpoint on current line |
| `<leader>B` | Conditional Breakpoint | Set a breakpoint with a condition |

**Note**: `<leader>` is typically the Space key in this configuration.

## Debug UI Window Navigation

When the debug UI is open, you have multiple windows. Use these keys to navigate:

| Key | Action | Description |
|-----|--------|-------------|
| `Ctrl-w h` | Move Left | Move focus to window on the left |
| `Ctrl-w l` | Move Right | Move focus to window on the right |
| `Ctrl-w j` | Move Down | Move focus to window below |
| `Ctrl-w k` | Move Up | Move focus to window above |
| `Ctrl-w w` | Cycle Windows | Cycle through all open windows |

## Within Debug UI Panels

### Scopes/Variables Panel

| Key | Action | Description |
|-----|--------|-------------|
| `j` / `k` | Navigate | Move up/down through variables |
| `Enter` | Expand/Collapse | Expand or collapse nested variables |
| `o` | Expand/Collapse | Alternative to Enter |
| `e` | Edit | Edit variable value (if supported) |

### Frames/Call Stack Panel

| Key | Action | Description |
|-----|--------|-------------|
| `j` / `k` | Navigate | Move through stack frames |
| `Enter` | Jump to Frame | Jump to selected stack frame in source code |

### Breakpoints Panel

| Key | Action | Description |
|-----|--------|-------------|
| `j` / `k` | Navigate | Move through breakpoints list |
| `Enter` | Jump to Breakpoint | Jump to selected breakpoint in source code |
| `d` | Delete | Delete the selected breakpoint |

## Debug REPL (Console)

When in the REPL window (if opened):

| Key | Action | Description |
|-----|--------|-------------|
| `i` | Insert Mode | Enter insert mode to type commands |
| `Esc` | Normal Mode | Return to normal mode |
| `Enter` | Execute | Execute the current line/command |
| `:q` | Close REPL | Close the REPL window |

## Additional Debugging Commands

These are executed via command mode (`:` followed by the command):

| Command | Description |
|---------|-------------|
| `:DapContinue` | Same as F5 - start/continue debugging |
| `:DapStepOver` | Same as F2 - step over |
| `:DapStepInto` | Same as F1 - step into |
| `:DapStepOut` | Same as F3 - step out |
| `:DapToggleBreakpoint` | Same as `<leader>b` - toggle breakpoint |
| `:DapTerminate` | Stop/terminate the debugging session |
| `:DapToggleRepl` | Open/close the debug REPL |
| `:DapRestartFrame` | Restart the current frame |

## Debug Session Control

| Action | How To | Description |
|--------|--------|-------------|
| Start Debugging | `F5` in source file | Begin a new debug session |
| Stop Debugging | `:DapTerminate` or let program finish | End the current debug session |
| Restart Debugging | Stop then `F5` again | Restart from beginning |
| Pause Execution | `:DapPause` | Pause running program (not bound by default) |

## Breakpoint Management

| Action | How To | Description |
|--------|--------|-------------|
| Toggle Breakpoint | `<leader>b` | Add/remove simple breakpoint |
| Conditional Breakpoint | `<leader>B` | Add breakpoint with condition (e.g., `x > 5`) |
| List Breakpoints | Check Breakpoints panel or `:DapShowLog` | View all breakpoints |
| Clear All Breakpoints | `:lua require('dap').clear_breakpoints()` | Remove all breakpoints |
| Jump to Breakpoint | Navigate in Breakpoints panel, press `Enter` | Go to breakpoint location |

## Inspecting Variables

| Method | How To | Description |
|--------|--------|-------------|
| View in Scopes | Look in Variables/Scopes panel | Auto-updated as you step |
| Hover | Hover cursor over variable in code | Shows current value (if LSP supports) |
| Watch Expression | Add to watches in UI | Monitor specific expressions |
| REPL Evaluation | `:DapToggleRepl` then type expression | Evaluate in current context |

## Quick Workflow Example

1. **Set breakpoint**: Move to line, press `<leader>b`
2. **Start debugging**: Press `F5`
3. **Navigate code**: Use `F2` (over), `F1` (into), `F3` (out)
4. **Inspect variables**: Look at Scopes panel or hover over variables
5. **Continue**: Press `F5` to go to next breakpoint
6. **Stop**: Let program finish or `:DapTerminate`

## Common Scenarios

### I want to skip to a specific line
1. Set a breakpoint on that line (`<leader>b`)
2. Press `F5` to continue to that breakpoint

### I want to examine what a function does internally
1. When stopped at a function call, press `F1` (step into)
2. Use `F2` to go through the function line by line
3. Press `F3` when you want to return to the caller

### I want to see why a variable has a specific value
1. Set a breakpoint before the variable is used
2. Check the Scopes/Variables panel
3. Step through code with `F2` and watch it change

### I only want to break when a condition is true
1. Press `<leader>B` (conditional breakpoint)
2. Enter condition like: `counter > 100` or `name == "test"`
3. Press `F5` - will only stop when condition is true

## Tips

- **Multiple breakpoints**: You can set many breakpoints across multiple files
- **Navigate panels**: Use `Ctrl-w w` to quickly cycle between debug windows
- **Close UI**: Press `F7` to hide debug UI when you just want to step through code
- **Stay in code**: You don't need to switch to debug panels - you can stay in your source file and use F-keys
- **Stack frames**: Click different stack frames to see variable state at each level

## Troubleshooting

| Problem | Solution |
|---------|----------|
| Debug UI won't open | Press `F7` to toggle it |
| Can't see variable values | Make sure you're stopped at a breakpoint and check Scopes panel |
| Breakpoint not hit | Verify file is saved and breakpoint is on an executable line |
| Lost in nested functions | Press `F3` repeatedly to step out, or `F5` to continue |
| Want to restart | `:DapTerminate` then `F5` to start fresh |

## Reference Links

For more advanced usage:
- `:help dap` - Full DAP documentation
- `:help dap-ui` - Debug UI documentation
- `:help dap-python` - Python-specific features

---

**Pro Tip**: Print this reference or keep it open in a split window during your first few debugging sessions until the keys become muscle memory!
