return {
  n = {
    ["<leader>fd"] = { 
        function() require("telescope.builtin").diagnostics() end, 
        desc = "Find diagnostics" 
      }
  }
}
