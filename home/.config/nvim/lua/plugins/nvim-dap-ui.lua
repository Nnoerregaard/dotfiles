return {
  "rcarriga/nvim-dap-ui",
  dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio", "folke/lazydev.nvim"},
  config = function ()
   require("lazydev").setup({
      library = { "nvim-dap-ui" },
    })
    -- Set up node adapter
    require("dap").adapters["pwa-node"] = {
      type = 'server',
      host = '::1',
      port = '9229',
      executable = {
        command = 'js-debug-adapter',
        args = {
          '9229',
        },
      },
    }

    require("dap").configurations["typescript"] = {
      {
        type = 'pwa-node',
        request = 'launch',
        name = 'Launch file',
        program = '${workspaceFolder}/backend/src/app.ts',
        cwd = '${workspaceFolder}',
      }
    }
  end
}
