vim.opt.relativenumber = true

vim.opt.clipboard = ""
vim.cmd("set clipboard=")

vim.keymap.set(
  {'n', 'v', 's', 'x', 'o', 'i', 'l', 'c', 't'},
  '<D-v>',
  function() vim.api.nvim_paste(vim.fn.getreg('+'), true, -1) end,
  { noremap = true, silent = true }
)

-- temporarily disabled
require('legendary').setup({ 
  extensions = {
    lazy_nvim = { auto_register = true } 
  }
})

-- neogit
local neogit = require('neogit')
neogit.setup {}

-- Copilot
require("codecompanion").setup({
  adapters = {
    chat = "openai",
    inline = "openai"
  },
})
vim.api.nvim_set_keymap("n", "<D-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<D-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>a", "<cmd>CodeCompanionToggle<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<leader>a", "<cmd>CodeCompanionToggle<cr>", { noremap = true, silent = true })

-- Cargo.toml / Crates support
vim.api.nvim_create_autocmd("BufRead", {
  group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
  pattern = "Cargo.toml",
  callback = function()
    --vim.cmd.setup.buffer({ sources = { { name = "crates" } } })
  end,
})
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'rust', -- Replace with the desired filetype
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    vim.keymap.set("n", "<leader>ra", function()
      vim.cmd.RustLsp('codeAction')
    end, { silent = true, buffer = bufnr, desc = "Actions" }
    )
    vim.keymap.set("n", "<leader>rr", function()
      vim.cmd.RustLsp('runnables')
    end, { silent = true, buffer = bufnr, desc = "Runnables" }
    )
    --vim.keymap.set("n", "<leader>rx", function()
    --    vim.cmd.RustLsp('runnables', bang = true)
    --  end, { silent = true, buffer = bufnr, desc = "ReRun" }
    --)
    vim.keymap.set("n", "<leader>rh", function()
      vim.cmd.RustLsp { 'hover', 'actions' }
    end, { silent = true, buffer = bufnr, desc = "ReRun" }
    )
  end,
})

-- Hop configuration
-- place this in one of your configuration file(s)
local hop = require('hop')
local directions = require('hop.hint').HintDirection
vim.keymap.set('', 'f', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
end, {remap=true})
vim.keymap.set('', 'F', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
end, {remap=true})
vim.keymap.set('', 't', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
end, {remap=true})
vim.keymap.set('', 'T', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
end, {remap=true})
vim.keymap.set('n', '<C-i>', function()
  vim.cmd(":HopWord")
end, {remap=true})
vim.keymap.set('n', '<C-l>', function()
  vim.cmd(":HopNodes")
end, {remap=true})
vim.keymap.set('v', '<C-i>', function()
  vim.cmd(":HopWord")
end, {remap=true})
vim.keymap.set('v', '<C-l>', function()
  vim.cmd(":HopNodes")
end, {remap=true})

--- neovide specific
--FIXME For t
-- Helper function for transparency formatting
if vim.g.neovide then
  local alpha = function()
	  return string.format("%x", math.floor(255 * vim.g.transparency or 0.8))
  end
  -- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
  vim.g.neovide_transparency = 0.8
  vim.g.transparency = 0.8
  vim.g.neovide_background_color = "#0f1117" .. alpha()
  vim.g.neovide_window_blurred = true
  vim.g.neovide_floating_shadow = false
  --vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_show_border = false
  vim.opt.guifont = { "IosevkaTermSlab Nerd Font:h17" }
end

-- Custom mappings

vim.keymap.set('n', '<Leader>fd', function()
  require("telescope.builtin").diagnostics()
end, {remap=true, desc = "Find Diagnostics"})

vim.keymap.set('n', '<Leader>lo', function()
  vim.lsp.buf.hover()
end, {remap=true, desc = "See Signature"})

vim.keymap.set('n', '<Leader>fs', function()
  require("telescope.builtin").lsp_document_symbols()
end, {remap=true, desc = "Find Document Symbols"})

vim.keymap.set('n', '<Leader>fS', function()
  require("telescope.builtin").lsp_dynamic_workspace_symbols()
end, {remap=true, desc = "Find Workspace Symbols"})

vim.keymap.set('n', '<Leader>fR', function()
  require("telescope.builtin").lsp_references()
end, {remap=true, desc = "Find References"})

--vim.keymap.set('n', '<Leader>fS', function()
--  require("telescope.builtin").lsp_references()
--end, {remap=true, desc = "Find References"})

vim.keymap.set('v', '<Leader>v', '"+y<cr>gv', {remap=true, desc = "Copy System"})
vim.keymap.set('n', '<D-s>', '<c-o>:w!<cr>', { desc = "Save File"})
vim.keymap.set('i', '<D-s>', '<c-o>:w!<cr>', { desc = "Save File"})
vim.keymap.set('v', '<D-s>', '<c-o>:w!<cr>', { desc = "Save File"})


