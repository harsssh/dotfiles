{
  programs.nixvim.plugins.treesitter = {
    enable = true;
    folding.enable = true;
    settings = {
      auto_install = true;
      sync_install = false;
      ensure_installed = [
        "c"
        "cpp"
        "go"
        "rust"
        "haskell"
        "scala"
        "lua"
        "typescript"
        "javascript"
        "ruby"
      ];
      highlight = {
        enable = true;
        additional_vim_regex_highlighting = false;
      };
      indent.enable = true;
    };
  };
}
