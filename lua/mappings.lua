return {
  n = {
    ["<Leader>fd"] = { 
        function() require("telescope.builtin").diagnostics() end, 
        desc = "Find diagnostics" 
    },
    ["<D-s>"] = { ":w!<cr>", desc = "Save File" },
    ["<leader>v"] = { '"+y<cr>gv', desc = "Copy System" },
    ["<leader>lo"] = { 
        function() vim.lsp.buf.hover() end, 
        desc = "Signature Help" 
    },
    ["<leader>rt"] = {
      function() require("crates").toggle() end,
      desc = "Toggle UI"
    },
    ["<leader>rv"] = {
      function() require("crates").show_versions_popup() end,
      desc = "Show Versions"
    },
    ["<leader>rf"] = {
      function() require("crates").show_features_popup() end,
      desc = "Show Features"
    },
    ["<leader>rd"] = {
      function() require("crates").open_documentation() end,
      desc = "Open Docs"
    },
    ["<leader>r"] = {
      name = "Rust"
    },
  },
  v = {
    ["<leader>v"] = { '"+y<cr>gv', desc = "Copy System" },
  },
  i = {
    ["<D-s>"] = { "<c-o>:w!<cr>", desc = "Save File" },
  }
}

