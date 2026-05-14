{
  programs.nixvim = {
    diagnostic.settings = {
      virtual_text = {
        severity.min.__raw = "vim.diagnostic.severity.WARN";
      };
      signs = false;
      underline = true;
      update_in_insert = false;
    };
  };
}
