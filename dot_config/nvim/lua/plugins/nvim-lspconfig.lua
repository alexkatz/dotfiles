return {
  'neovim/nvim-lspconfig',
  opts = {
    inlay_hints = { enabled = false },
    servers = {
      tailwindcss = {
        settings = {
          tailwindCSS = {
            classAttributes = { 'className' },
            classFunctions = { 'tw' },
            experimental = {
              classRegex = {
                { '(?:[a-zA-Z0-9]+ClassName)=\\s*(?:"|\')([^"\']*)(?:"|\')' },
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
