return {
  'neovim/nvim-lspconfig',
  opts = {
    inlay_hints = { enabled = false },
    servers = {
      tailwindcss = {
        settings = {
          tailwindCSS = {
            files = {
              watch = '**/*.{css,scss}',
            },
            includeLanguages = { 'typescript', 'typescriptreact' },
            classAttributes = { 'className' },
            classFunctions = { 'tw', 'classed' },
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
