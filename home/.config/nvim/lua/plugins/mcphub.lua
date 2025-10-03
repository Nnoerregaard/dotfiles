-- Used to integrate MCP client functionality into neovim so it can talk to MCP servers for added context in Avante.
-- See https://ravitemer.github.io/mcphub.nvim/
return {
    "ravitemer/mcphub.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    build = "npm install -g mcp-hub@latest",  -- Installs `mcp-hub` node binary globally
    config = function()
      require("mcphub").setup()
    end
}
