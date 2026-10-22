-- chezmoi.nvim opens the *source* file, which for encrypted entries is age ciphertext.
-- for those, edit the decrypted target instead and re-encrypt it into the source on save.

local source_dir = vim.env.HOME .. '/.local/share/chezmoi'

-- realpaths of encrypted targets; looked up once, encrypted entries rarely change
local encrypted_targets

local function is_encrypted_target(path)
  if not encrypted_targets then
    encrypted_targets = {}
    local res = vim.system({ 'chezmoi', 'managed', '--include=encrypted', '--path-style=absolute' }):wait()
    for target in vim.gsplit(res.stdout or '', '\n', { trimempty = true }) do
      encrypted_targets[vim.uv.fs_realpath(target) or target] = true
    end
  end
  return encrypted_targets[path] == true
end

local function reencrypt(path)
  -- age ciphertext differs on every encryption, so skip unchanged saves to keep git quiet
  vim.system({ 'chezmoi', 'verify', path }, {}, function(verify)
    if verify.code == 0 then
      return
    end
    vim.system({ 'chezmoi', 'add', '--encrypt', path }, {}, function(add)
      vim.schedule(function()
        if add.code == 0 then
          vim.notify('Re-encrypted into chezmoi source', vim.log.levels.INFO, { title = 'chezmoi' })
        else
          vim.notify(add.stderr, vim.log.levels.ERROR, { title = 'chezmoi' })
        end
      end)
    end)
  end)
end

return {
  'xvzc/chezmoi.nvim',
  init = function()
    local group = vim.api.nvim_create_augroup('chezmoi_encrypted', { clear = true })

    -- opening an encrypted source (picker, :ChezmoiEdit, file explorer): swap to its target
    vim.api.nvim_create_autocmd('BufReadPost', {
      group = group,
      pattern = source_dir .. '/*encrypted_*',
      callback = function(event)
        local res = vim.system({ 'chezmoi', 'target-path', event.match }):wait()
        local target = vim.trim(res.stdout or '')
        if res.code ~= 0 or target == '' then
          return
        end
        -- scheduled: LazyVim's chezmoi watch is queued first and binds to the source buffer,
        -- so wiping that buffer also drops its apply-on-save hook
        vim.schedule(function()
          vim.cmd.edit(vim.fn.fnameescape(target))
          if vim.api.nvim_buf_is_valid(event.buf) then
            vim.api.nvim_buf_delete(event.buf, { force = true })
          end
        end)
      end,
    })

    -- saving an encrypted target, also through a symlink such as ~/Developer/run-local.sh
    vim.api.nvim_create_autocmd('BufWritePost', {
      group = group,
      callback = function(event)
        local path = vim.uv.fs_realpath(event.match)
        if path and not vim.startswith(path, source_dir) and is_encrypted_target(path) then
          reencrypt(path)
        end
      end,
    })
  end,
}
