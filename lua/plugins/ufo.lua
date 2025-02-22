-- return {
--   {
--     "kevinhwang91/nvim-ufo",
--     dependencies = {
--       "kevinhwang91/promise-async",
--       "nvim-treesitter/nvim-treesitter",
--     },
--     config = function()
--       vim.o.foldcolumn = "0" -- '0' does not show the fold column, higher values increase the width
--       vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
--       vim.o.foldlevelstart = 99
--       vim.o.foldenable = true
--
--       require("ufo").setup({
--         provider_selector = function(bufnr, filetype, buftype)
--           return { "treesitter", "indent" }
--         end,
--       })
--     end,
--   },
-- }

local M = {
  "kevinhwang91/nvim-ufo",
  dependencies = { "kevinhwang91/promise-async" },
  opts = {
    filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
  },
  config = function(_, opts)
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("local_detach_ufo", { clear = true }),
      pattern = opts.filetype_exclude,
      callback = function()
        require("ufo").detach()
      end,
    })

    vim.opt.foldlevelstart = 99
    require("ufo").setup(opts)
  end,
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}
local language_servers = vim.lsp.get_clients() -- or list servers manually like {'gopls', 'clangd'}
for _, ls in ipairs(language_servers) do
  require("lspconfig")[ls].setup({
    capabilities = capabilities,
    -- you can add other fields for setting up lsp server in this table
  })
end
return M
