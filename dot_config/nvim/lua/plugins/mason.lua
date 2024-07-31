return {
  'williamboman/mason.nvim',
  opts = function(_, opts)
    local to_install = {
      'eslint-lsp',
      'stylua',
      'beautysh',
      'yamlfmt',
      'lua-language-server',
      'codelldb',
      'rust-analyzer',
      'typescript-language-server',
      'tailwindcss-language-server',
      'json-lsp',
    }

    for _, package in ipairs(to_install) do
      table.insert(opts.ensure_installed, package)
    end
  end,
}
