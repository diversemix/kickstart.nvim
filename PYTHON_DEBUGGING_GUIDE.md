# Python Debugging Guide for Kickstart.nvim

## Overview

Your Neovim configuration is now set up with full Python debugging support using the Debug Adapter Protocol (DAP). This allows you to set breakpoints, step through code, inspect variables, and more, all within Neovim.

## What's Installed

The following plugins and tools have been configured:

- **nvim-dap**: The core Debug Adapter Protocol client for Neovim
- **nvim-dap-ui**: A beautiful UI for the debugger
- **nvim-dap-python**: Python-specific debugging configuration
- **debugpy**: The Python debug adapter (installed via Mason)
- **mason-nvim-dap**: Automatically installs and configures debug adapters

## Prerequisites

Before you start debugging, ensure you have:

1. Python 3 installed on your system
2. The Python project you want to debug
3. **debugpy installed via Mason** (see installation steps below)

### Installing debugpy via Mason

The configuration is set to automatically install debugpy, but if it doesn't install automatically or you encounter errors, follow these steps:

1. **Open Neovim**
2. **Open Mason**: Type `:Mason` and press Enter
3. **Search for debugpy**: Type `/debugpy` to search for it in the list
4. **Install debugpy**:
   - Move your cursor to `debugpy` in the list
   - Press `i` to install
   - Wait for the installation to complete (you'll see a progress indicator)
5. **Verify installation**: You should see a checkmark or "installed" indicator next to debugpy
6. **Close Mason**: Press `q` to quit
7. **Restart Neovim** to ensure the configuration picks up the newly installed debugpy

### Verify debugpy Installation

To verify debugpy was installed correctly, you can check the Mason packages directory:

```bash
ls -la ~/.local/share/nvim/mason/packages/debugpy/
```

You should see a `venv` directory containing the Python virtual environment with debugpy.

## Key Bindings

The following keybindings are configured for debugging:

| Key | Action | Description |
|-----|--------|-------------|
| `F5` | Continue | Start debugging or continue to next breakpoint |
| `F1` | Step Into | Step into functions |
| `F2` | Step Over | Step over functions |
| `F3` | Step Out | Step out of current function |
| `F7` | Toggle UI | Open/close the debug UI |
| `<leader>b` | Toggle Breakpoint | Set/remove breakpoint on current line |
| `<leader>B` | Conditional Breakpoint | Set a breakpoint with a condition |

## Quick Start Example

### 1. Create a Simple Python Script

Create a file called `test_debug.py`:

```python
def calculate_sum(numbers):
    total = 0
    for num in numbers:
        total += num
    return total

def main():
    numbers = [1, 2, 3, 4, 5]
    result = calculate_sum(numbers)
    print(f"The sum is: {result}")

if __name__ == "__main__":
    main()
```

### 2. Set Breakpoints

1. Open the file in Neovim: `nvim test_debug.py`
2. Move your cursor to line 3 (inside the `calculate_sum` function)
3. Press `<leader>b` (usually `Space` followed by `b`) to set a breakpoint
4. You should see a breakpoint indicator in the sign column

### 3. Start Debugging

1. Press `F5` to start debugging
2. The debugger will start and the debug UI will automatically open
3. Execution will pause at your breakpoint

### 4. Navigate Through Code

Once stopped at a breakpoint:

- Press `F2` to step over the current line
- Press `F1` to step into a function call
- Press `F3` to step out of the current function
- Press `F5` to continue to the next breakpoint or end of program

### 5. Inspect Variables

The debug UI will show you:

- **Scopes**: Local and global variables with their current values
- **Watch**: Variables you want to monitor
- **Call Stack**: The current execution stack
- **Breakpoints**: All your breakpoints

### 6. Stop Debugging

- Continue execution with `F5` until the program ends, or
- Manually stop debugging through the debug UI controls

## Debug UI Layout

When you start debugging, the UI will split into several windows:

```
┌─────────────────────┬─────────────────────┐
│                     │                     │
│   Your Code         │   Variables/Scopes  │
│   (with breakpoint) │   (Watch values)    │
│                     │                     │
├─────────────────────┼─────────────────────┤
│                     │                     │
│   Call Stack        │   Breakpoints       │
│                     │                     │
└─────────────────────┴─────────────────────┘
```

## Advanced Usage

### Running with Command Line Arguments

If your Python script requires command-line arguments, you can configure a custom launch configuration. Add this to your debug.lua or create a `.vscode/launch.json` file in your project:

```lua
-- In your project, you can add custom configurations
require('dap').configurations.python = {
  {
    type = 'python',
    request = 'launch',
    name = 'Launch file with arguments',
    program = '${file}',
    args = {'arg1', 'arg2'},
  },
}
```

### Debugging Tests

To debug Python tests (pytest, unittest), you can use:

```vim
:lua require('dap-python').test_method()
```

This will debug the test method under your cursor.

### Conditional Breakpoints

1. Press `<leader>B` (Space followed by Shift+B)
2. Enter a condition, e.g., `num > 3`
3. The breakpoint will only trigger when the condition is true

## Troubleshooting

### Debug adapter not found

If you see an error about debugpy not being found:

1. Open Neovim
2. Run `:Mason`
3. Search for `debugpy`
4. Press `i` to install it if it's not already installed

### Breakpoints not working

1. Make sure you're in a Python file (`.py` extension)
2. Ensure the file is saved before starting debugging
3. Check that your Python code is syntactically correct

### Debug UI not opening

Press `F7` to manually toggle the debug UI.

### Python interpreter issues

The debug configuration uses the Python interpreter from Mason's debugpy installation. If you need to use a different Python interpreter (e.g., from a virtual environment), you can modify the setup in `lua/kickstart/plugins/debug.lua`:

```lua
-- Change this line to point to your preferred Python interpreter
require('dap-python').setup '/path/to/your/python'
```

For a virtual environment:
```lua
require('dap-python').setup '~/.venv/bin/python'
```

## Tips and Tricks

1. **Quick breakpoint toggle**: Use `<leader>b` to quickly toggle breakpoints without typing commands

2. **Inspect hover**: While debugging, hover over variables to see their values

3. **REPL**: You can open a debug REPL to execute Python code in the current context

4. **Persistent breakpoints**: Breakpoints are saved per session, but not across Neovim restarts

5. **Multiple files**: You can set breakpoints in multiple files and debug across them

## Next Steps

- Explore the debug UI by pressing `F7` during a debug session
- Try setting conditional breakpoints with `<leader>B`
- Read `:help dap` for more advanced DAP features
- Check out `:help dap-python` for Python-specific debugging options

## Resources

- [nvim-dap Documentation](https://github.com/mfussenegger/nvim-dap)
- [nvim-dap-python Documentation](https://github.com/mfussenegger/nvim-dap-python)
- [Debug Adapter Protocol](https://microsoft.github.io/debug-adapter-protocol/)

Happy debugging!
