return {
  'saghen/blink.cmp',
  opts = function(_, opts)
    -- no snippets: drop the snippets source (sources.default only extends via table opts, so filter here)
    opts.sources = opts.sources or {}
    opts.sources.default = vim.tbl_filter(function(source)
      return source ~= 'snippets'
    end, opts.sources.default or {})

    return vim.tbl_deep_extend('force', opts, {
      completion = {
        ghost_text = { enabled = false },
        accept = { auto_brackets = { enabled = false } },
        documentation = {
          window = {
            winblend = 15,
          },
        },
        menu = {
          draw = { treesitter = { 'lsp' } },
          winblend = 15,
        },
      },
      sources = {
        providers = {
          lsp = {
            -- also drop snippet items sent by language servers
            transform_items = function(_, items)
              local snippet = require('blink.cmp.types').CompletionItemKind.Snippet
              return vim.tbl_filter(function(item)
                return item.kind ~= snippet
              end, items)
            end,
          },
        },
      },
    })
  end,
}
