return {
  "akinsho/toggleterm.nvim",
  config = function()
    require("toggleterm").setup({
      size = 15,
      open_mapping = [[<C-\>]],
      direction = "horizontal",
      start_in_insert = true,
      insert_mappings = true, -- mappature in modalitˆ insert (Esc per uscire)
      terminal_mappings = true,
      persist_size = true,
      shade_terminals = true,
      shading_factor = 2,
    })
  end
}
