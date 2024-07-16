local search_git_branches = function()
  require('fzf-lua').git_branches({
    cmd = 'git branch --all --color --sort=-committerdate',
    ['default'] = function(selected)
      local selection = selected[1]

      local current_branch_char = string.find(selection, '*')
      if current_branch_char ~= nil then
        selection = string.sub(selection, 3)
      end

      selection = vim.trim(selection)

      os.execute('git checkout ' .. selection)
    end,
  })
end

return {
  'ibhagwan/fzf-lua',
  keys = {
    { '<leader>gs', search_git_branches, desc = 'Search Git Branches' },
  },
}
