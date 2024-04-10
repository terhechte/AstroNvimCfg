
-- https://github.com/AstroNvim/user_example/blob/main/init.lua

local alpha = function()
	return string.format("%x", math.floor(255 * vim.g.transparency or 0.8))
end


return {
  -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
  diagnostics = {
    virtual_text = true,
    underline = true,
  },

  lsp = {
    -- customize lsp formatting options
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = true, -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          -- "go",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          -- "python",
        },
      },
      timeout_ms = 1000, -- default format timeout
    },
  },
  -- This function is run last and is a good place to configuring
  -- augroups/autocommands and custom filetypes also this just pure lua so
  -- anything that doesn't fit in the normal config locations above can go here
  polish = function()
    require('user/emacs')
    if vim.g.neovide then
	    vim.o.guifont = "IosevkaTermSlab Nerd Font:h17"
    end
    --vim.cmd('source ~/.config/astrovim/user/configure_emacs.vim')
    --vim.cmd('source ~/.config/astrovim/user/other.vim')
    --vim.o.guifont = "Isoveka Nerd Font:h17"
    --vim.g.neovide_input_macos_alt_is_meta = false

  vim.opt.clipboard = ""
  vim.cmd("set clipboard=")

    vim.keymap.set(
      {'n', 'v', 's', 'x', 'o', 'i', 'l', 'c', 't'},
      '<D-v>',
      function() vim.api.nvim_paste(vim.fn.getreg('+'), true, -1) end,
      { noremap = true, silent = true }
    )

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
            cmp.setup.buffer({ sources = { { name = "crates" } } })
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
    end


    -- Set up custom filetypes
    -- vim.filetype.add {
    --   extension = {
    --     foo = "fooscript",
    --   },
    --   filename = {
    --     ["Foofile"] = "fooscript",
    --   },
    --   pattern = {
    --     ["~/%.config/foo/.*"] = "fooscript",
    --   },
    -- }
  end,
}
