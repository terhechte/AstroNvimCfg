return function(local_vim)
  local_vim.o.guifont = "Isoveka Nerd Font:h14"
  local_vim.g.neovide_input_macos_alt_is_meta = false
  local_vim.opt.relativenumber = false

  local_vim.keymap.set(
    {'n', 'v', 's', 'x', 'o', 'i', 'l', 'c', 't'},
    '<D-v>',
    function() vim.api.nvim_paste(vim.fn.getreg('+'), true, -1) end,
    { noremap = true, silent = true }
  )




  return local_vim
end
