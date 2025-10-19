require("config.lazy")

-- Workaround for diagnostics disappearing in insert mode causing the whole UI to continously jump around 
vim.diagnostic.config({
    update_in_insert = true,
    --[[
    virtual_text = true,
    signs = true,
    underline = true,
    severity_sort = false,
    float = true,
    ]]
  })
