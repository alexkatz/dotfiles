-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- centers cursor on page up or page down
vim.keymap.set('n', '<C-d>', '<C-d>zz', { noremap = true, silent = true })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { noremap = true, silent = true })

-- centers cursor on next/prev search
vim.keymap.set('n', 'n', 'nzzzv', { noremap = true, silent = true })
vim.keymap.set('n', 'N', 'Nzzzv', { noremap = true, silent = true })

-- save, save all
vim.keymap.set({ 'i', 'v', 'n', 's' }, '<M-s>', '<cmd>w<cr><esc>', { desc = 'Save file' })
vim.keymap.set({ 'i', 'v', 'n', 's' }, '<M-a>', '<cmd>wa<cr><esc>', { desc = 'Save file' })

--  option or ctrl + bs to delete word like macOS
vim.keymap.set({ 'i', 'v', 'n', 's' }, '<M-BS>', '<C-w>', { desc = 'Delete word' })
vim.keymap.set({ 'i', 'v', 'n', 's' }, '<C-BS>', '<C-w>', { desc = 'Delete word' })

-- Resize window using <option>+arrows
vim.keymap.set('n', '<M-Up>', '<cmd>resize +2<cr>', { desc = 'Increase window height' })
vim.keymap.set('n', '<M-Down>', '<cmd>resize -2<cr>', { desc = 'Decrease window height' })
vim.keymap.set('n', '<M-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease window width' })
vim.keymap.set('n', '<M-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase window width' })

-- save buffer or all buffers
vim.keymap.set('n', '<leader>bw', '<cmd>w<cr>', { desc = 'Save Buffer' })
vim.keymap.set('n', '<leader>bW', '<cmd>wa<cr>', { desc = 'Save All Buffers' })

-- delete window
vim.keymap.set('n', '<leader>wd', '<cmd>q<cr>', { desc = 'Delete Window' })

-- close all other windows
vim.keymap.set('n', '<leader>wo', '<cmd>only<cr>', { desc = 'Close Other Windows' })

-- close non-visible buffers
vim.keymap.set('n', '<leader>bo', function()
  local vis_buffers = {}
  local wins = vim.api.nvim_list_wins()
  for _, win in ipairs(wins) do
    local buffer = vim.api.nvim_win_get_buf(win)
    vis_buffers[buffer] = true
  end

  local all_buffers = vim.api.nvim_list_bufs()
  for _, buf in ipairs(all_buffers) do
    if not vis_buffers[buf] then
      Snacks.bufdelete.delete(buf)
    end
  end
end, { desc = 'Close Hidden Buffers' })

if vim.g.vscode then
  local vscode = require('vscode')
  print(vscode)

  vim.keymap.set('n', 'gd', function()
    vscode.action('editor.action.revealDefinition')
  end, { desc = 'Go to Definition' })

  vim.keymap.set('n', 'gr', function()
    vscode.action('editor.action.goToReferences')
  end, { desc = 'Go to References' })

  vim.keymap.set('n', '<leader>bd', function()
    vscode.action('workbench.action.closeActiveEditor')
  end, { desc = 'Close Active Editor' })

  vim.keymap.set('n', '<leader>wd', function()
    vscode.action('workbench.action.closeActiveEditor')
  end, { desc = 'Close Active Editor' })

  vim.keymap.set('n', '<leader>wv', function()
    vscode.action('workbench.action.splitEditorRight')
  end, { desc = 'Split Editor Right' })

  vim.keymap.set('n', '<leader>ws', function()
    vscode.action('workbench.action.splitEditorDown')
  end, { desc = 'Split Editor Down' })

  vim.keymap.set('n', '<leader>cr', function()
    vscode.action('editor.action.rename')
  end, { desc = 'Rename Variable' })

  vim.keymap.set('n', ']d', function()
    vscode.action('editor.action.marker.next')
  end, { desc = 'Next Problem' })

  vim.keymap.set('n', '[d', function()
    vscode.action('editor.action.marker.prev')
  end, { desc = 'Previous Problem' })

  vim.keymap.set('n', '<leader>cu', function()
    vscode.action('typescript.removeUnusedImports')
  end, { desc = 'Remove Unused Imports' })
end
