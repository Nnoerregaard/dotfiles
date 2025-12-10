return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- or if using mini.icons/mini.nvim
  -- dependencies = { "nvim-mini/mini.icons" },
  ---@module "fzf-lua"
  ---@type fzf-lua.Config|{}
  ---@diagnostics disable: missing-fields
  opts = {},
  keys = {
    { "<leader>f", ':FzfLua live_grep<CR>'},
    { "<leader>ff", ':FzfLua files<CR>'},
    { "<leader>fb", ':FzfLua buffers<CR>'},
    { "<leader>fw", ':FzfLua grep_cWORD<CR>'},
    { "<leader>fs", ':FzfLua grep_visual<CR>'},
  }
  ---@diagnostics enable: missing-fields
}
