{
  programs.nixvim = {
    globals = {
      mapleader = " ";
      loaded_ruby_provider = 0;
      loaded_node_provider = 0;
      loaded_perl_provider = 0;
      loaded_python3_provider = 0;
      no_ruby_maps = 1;
    };

    opts = {
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

      clipboard = "unnamed,unnamedplus";

      # foldmethod / foldexpr は plugins.treesitter.folding が FileType ごとに
      # ウィンドウローカルで設定する
      foldlevel = 99;
      foldenable = true;
    };

    extraConfigLuaPre = ''
      vim.opt.undodir = vim.fn.stdpath("state") .. "/undo"
    '';
  };
}
