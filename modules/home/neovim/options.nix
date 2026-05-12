{
  programs.nixvim = {
    globals = {
      mapleader = " ";
      loaded_ruby_provider = 0;
      loaded_node_provider = 0;
      loaded_perl_provider = 0;
      loaded_python_provider = 0;
      no_ruby_maps = 1;
    };

    opts = {
      syntax = "on";

      number = true;
      relativenumber = true;
      showtabline = 2;
      signcolumn = "yes";
      termguicolors = true;
      laststatus = 3;
      cursorline = true;
      pumheight = 12;
      scrolloff = 4;

      tabstop = 4;
      shiftwidth = 4;
      expandtab = true;

      timeoutlen = 300;
      updatetime = 300;

      lazyredraw = true;
      synmaxcol = 200;

      smartindent = true;
      breakindent = true;
      smarttab = true;
      autoindent = true;

      incsearch = true;
      hlsearch = true;
      ignorecase = true;
      smartcase = true;

      backup = false;
      swapfile = false;

      undofile = true;

      clipboard = "unnamedplus";

      foldmethod = "expr";
      foldexpr = "v:lua.vim.treesitter.foldexpr()";
      foldlevel = 99;
      foldenable = true;
    };

    extraConfigLuaPre = ''
      vim.opt.undodir = vim.fn.stdpath("state") .. "/undo"
    '';
  };
}
