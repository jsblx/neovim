return {
  { "ellisonleao/gruvbox.nvim" },
  { "neanias/everforest-nvim" },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "everforest",
    },
  },
}
