return {
  'neovim/nvim-lspconfig',
  opts = {
    inlay_hints = { enabled = false },
    servers = {
      tailwindcss = {
        settings = {
          tailwindCSS = {
            experimental = {
              classRegex = {
                { 'tw\\(([^)]*)\\)', "(?:'|\"|`)([^']*)(?:'|\"|`)" },
                { 'tw\\(([^)]*)\\)', '["\'`]([^"\'`]*).*?["\'`]' },
                '(?:[a-z]ClassName)=\\s*(?:"|\')([^(?:"|\')]*)',
              },
            },
          },
        },
      },
      clangd = {
        capabilities = {
          offsetEncoding = 'utf-8',
        },
      },
    },
  },
}
