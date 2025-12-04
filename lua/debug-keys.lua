local dapui = require 'dapui'

local function focus_dapui_element(element_name)
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    local buf_name = vim.api.nvim_buf_get_name(buf)

    -- Extract the part after the last slash
    local name_after_slash = buf_name:match '[^/]*$'

    -- Check for standard DAP windows: /DAP <ElementName>
    if buf_name:match('/DAP%s+' .. element_name .. '$') then
      vim.api.nvim_set_current_win(win)
      return true
    end

    -- Check for REPL: [dap-repl-...]
    if element_name == 'REPL' and name_after_slash:match '^%[dap%-repl' then
      vim.api.nvim_set_current_win(win)
      return true
    end

    -- Check for Console: [dap-terminal]
    if element_name == 'Console' and name_after_slash:match '^%[dap%-terminal' then
      vim.api.nvim_set_current_win(win)
      return true
    end
  end
  return false
end

-- Keybindings to switch focus to debug windows
vim.keymap.set('n', '<Leader>dw', function()
  focus_dapui_element 'Watches'
end, { desc = 'Debug: Focus Watches' })

vim.keymap.set('n', '<Leader>ds', function()
  focus_dapui_element 'Scopes'
end, { desc = 'Debug: Focus Scopes' })

vim.keymap.set('n', '<Leader>db', function()
  focus_dapui_element 'Breakpoints'
end, { desc = 'Debug: Focus Breakpoints' })

vim.keymap.set('n', '<Leader>dk', function()
  focus_dapui_element 'Stacks'
end, { desc = 'Debug: Focus Stacks' })

vim.keymap.set('n', '<Leader>dr', function()
  focus_dapui_element 'REPL'
end, { desc = 'Debug: Focus REPL' })

vim.keymap.set('n', '<Leader>dc', function()
  focus_dapui_element 'Console'
end, { desc = 'Debug: Focus Console' })

-- Focus back to code window
vim.keymap.set('n', '<Leader>dx', function()
  -- Find a window that's NOT a dapui window
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    local buf_name = vim.api.nvim_buf_get_name(buf)
    if not buf_name:match 'DAP' then
      vim.api.nvim_set_current_win(win)
      return
    end
  end
end, { desc = 'Debug: Focus Code' })
