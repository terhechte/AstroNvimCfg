-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {
  {
    {
      "supermaven-inc/supermaven-nvim",
      config = function()
        require("supermaven-nvim").setup({
          keymaps = {
            accept_suggestion = "<C-.>",
            clear_suggestion = "<C-]>",
          },
          ignore_filetypes = { md = true },
          color = {
            suggestion_color = "#00AAFF",
            cterm = 244,
          }
        })
      end,
    },
  },
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
    },

  "andweeb/presence.nvim",
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },

  -- == Examples of Overriding Plugins ==

  -- customize alpha options
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
        " █████  ███████ ████████ ██████   ██████",
        "██   ██ ██         ██    ██   ██ ██    ██",
        "███████ ███████    ██    ██████  ██    ██",
        "██   ██      ██    ██    ██   ██ ██    ██",
        "██   ██ ███████    ██    ██   ██  ██████",
        " ",
        "    ███    ██ ██    ██ ██ ███    ███",
        "    ████   ██ ██    ██ ██ ████  ████",
        "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
        "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
        "    ██   ████   ████   ██ ██      ██",
      }
      return opts
    end,
  },

  -- You can disable default plugins as follows:
  { "max397574/better-escape.nvim", enabled = false },

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require "luasnip"
      luasnip.filetype_extend("javascript", { "javascriptreact" })
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },
}
