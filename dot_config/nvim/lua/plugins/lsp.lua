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
      lua_ls = {
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT',
              path = vim.split(package.path, ';'),
            },
            diagnostics = {
              globals = { 'vim', 'Snacks', 'LazyVim' },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file('', true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
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
