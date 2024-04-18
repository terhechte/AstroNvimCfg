return {
  n = {
    ["<Leader>fd"] = { 
        function() require("telescope.builtin").diagnostics() end, 
        desc = "Find diagnostics" 
    },
    ["<D-s>"] = { ":w!<cr>", desc = "Save File" },
    ["<Leader>v"] = { '"+y<cr>gv', desc = "Copy System" },
    ["<Leader>lo"] = { 
        function() vim.lsp.buf.hover() end, 
        desc = "Signature Help" 
    },
    ["<Leader>rt"] = {
      function() require("crates").toggle() end,
      desc = "Toggle UI"
    },
    ["<Leader>rv"] = {
      function() require("crates").show_versions_popup() end,
      desc = "Show Versions"
    },
    ["<Leader>rf"] = {
      function() require("crates").show_features_popup() end,
      desc = "Show Features"
    },
    ["<Leader>rd"] = {
      function() require("crates").open_documentation() end,
      desc = "Open Docs"
    },
    ["<Leader>r"] = {
      name = "Rust"
    },
  },
  v = {
    ["<Leader>v"] = { '"+y<cr>gv', desc = "Copy System" },
  },
  i = {
    ["<D-s>"] = { "<c-o>:w!<cr>", desc = "Save File" },
  }
}

