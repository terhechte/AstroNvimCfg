return {
  {
    {
      "yorickpeterse/nvim-window",
      config = function()
        vim.api.nvim_set_keymap('n', '-', '<cmd>lua require("nvim-window").pick()<CR>', { noremap = true, silent = true })
      end,
      keys = {'-'}
    },
    {
      'mrjones2014/legendary.nvim',
      version = 'v2.13.9',
      -- since legendary.nvim handles all your keymaps/commands,
      -- its recommended to load legendary.nvim before other plugins
      priority = 10000,
      lazy = false,
      -- sqlite is only needed if you want to use frecency sorting
      dependencies = { 'kkharji/sqlite.lua' }
    },
    {
      "NeogitOrg/neogit",
      dependencies = {
        "nvim-lua/plenary.nvim",         -- required
        "sindrets/diffview.nvim",        -- optional - Diff integration
      },
      config = true
    },
    {
      "olimorris/codecompanion.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "nvim-telescope/telescope.nvim", -- Optional
        {
          "stevearc/dressing.nvim", -- Optional: Improves the default Neovim UI
          opts = {},
        },
      },
      config = true
    },
    {
      "folke/edgy.nvim",
      event = "VeryLazy",
      init = function()
        vim.opt.laststatus = 3
        vim.opt.splitkeep = "screen"
      end,
      opts = {
        right = {
          { ft = "codecompanion", title = "Code Companion Chat", size = { width = 0.45 } },
        }
      }
    },
    {
        'saecki/crates.nvim',
        tag = 'stable',
        config = function()
            require('crates').setup()
        end,
    },
    {
      'mrcjkb/rustaceanvim',
      version = '^4', -- Recommended
      ft = { 'rust' },
    },
    {
      'smoka7/hop.nvim',
      version = "*",
      opts = {},
    }
  }
}
