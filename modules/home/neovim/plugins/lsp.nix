{
  programs.nixvim.plugins.conform-nvim = {
    enable = true;
    settings = {
      formatters_by_ft = {
        ruby = [ "rubocop" ];
        typescript = [ "biome" ];
        javascript = [ "biome" ];
        typescriptreact = [ "biome" ];
        javascriptreact = [ "biome" ];
        json = [ "biome" ];
        lua = [ "stylua" ];
        go = [ "gofumpt" "goimports" ];
      };
      format_after_save = {
        lsp_format = "fallback";
      };
    };
  };
}
