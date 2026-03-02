-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--

-- ESLint fix-all on save (Nvim 0.11+ uses LspEslintFixAll instead of EslintFixAll)
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.name == 'eslint' then
      vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = args.buf,
        command = 'LspEslintFixAll',
      })
    end
  end,
})
