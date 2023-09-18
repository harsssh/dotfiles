local status, treesitter = pcall(require, "nvim-treesitter.configs")
if (not status) then return end

treesitter.setup {
  ensure_installed = {"vim","dockerfile","typescript","tsx","javascript","json","lua","gitignore","bash","markdown","css","yaml","toml","vue","html","c"},
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false, -- catpuucin用
    disable = {},
  },
	indent ={
		enable =true,
    disable ={"html"},
	},
  autotag = {
    enable = true,
  },
}
