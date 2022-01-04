local tree ={}
local tree_width = vim.g.nvim_tree_width
tree.toggle = function()
  require('nvim-tree').toggle()
  if require('nvim-tree.view').win_open() then
   require('bufferline.state').set_offset(tree_width + 1, '')
   require('nvim-tree').find_file(true)
  else
    require('bufferline.state').set_offset(0)
  end
end

return tree