return {
  "mason-org/mason-lspconfig.nvim",
  opts = {
    ensure_installed = { "lua_ls", "ts_ls" }
  },
  dependencies = {
      { "mason-org/mason.nvim", opts = {
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
          }
        }
      } },
      { "neovim/nvim-lspconfig",
      --[[ opts = function()
        local keys = require("Lazyvim.plugins.lsp.keymaps").get()
        keys[#keys+1] = { "gd", vim.lsp.buf.implementation }
      end,
      ]]
    },
  },
}
