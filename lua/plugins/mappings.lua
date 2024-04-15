return {
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      mappings = {
        n = {
          ["<Leader>fd"] = { 
            function() require("telescope.builtin").diagnostics() end, 
            desc = "Find diagnostics" 
          },
        }
      } 
    }
  }
}
