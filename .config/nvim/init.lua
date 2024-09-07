if vim.g.vscode then
    require("base")
    require("keymap")
else
    require("init_lazy")
    require("base")
    require("keymap")
    require("autocmd")
    require("diagnostic")

    require("lazy").setup("plugins")
end
