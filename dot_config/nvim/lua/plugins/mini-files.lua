return {
  'echasnovski/mini.files',
  opts = function(_, opts)
    opts.options = {
      use_as_default_explorer = true,
    }

    opts.windows = {
      preview = true,
      width_nofocus = 40,
      width_focus = 40,
      width_preview = 100,
    }
  end,
  config = function()
    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesBufferCreate',
      callback = function(event)
        local buf_id = event.data.buf_id

        vim.keymap.set('n', '<esc>', function()
          require('mini.files').close()
        end, { buffer = buf_id, desc = 'Close Mini Files' })
      end,
    })

    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesActionMove',
      callback = function(event)
        local clients = vim.lsp.get_clients({ name = 'vtsls' })
        for _, client in ipairs(clients) do
          if client.supports_method('workspace/didRenameFiles') then
            client.notify('workspace/didRenameFiles', {
              files = {
                {
                  oldUri = vim.uri_from_fname(event.data.from),
                  newUri = vim.uri_from_fname(event.data.to),
                },
              },
            })
          end
        end
      end,
    })
  end,
  keys = {
    {
      '<leader>e',
      function()
        local MiniFiles = require('mini.files')
        if not MiniFiles.close() then
          MiniFiles.open(vim.api.nvim_buf_get_name(0), true)
        end
      end,
      desc = 'Open mini.files ',
    },
  },
}
