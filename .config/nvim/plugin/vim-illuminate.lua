require('illuminate').configure({
    delay = 0,
    large_file_cutoff = 2000,
    large_file_overrides = {
        providers = { 'lsp' }
    },
})

local function map(key, dir, buffer)
    vim.keymap.set("n", key, function()
        require("illuminate")["goto_" .. dir .. "_reference"](false)
    end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
end

map("]]", "next")
map("[[", "prev")

vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Visual" })
vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" })
vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Visual" })
