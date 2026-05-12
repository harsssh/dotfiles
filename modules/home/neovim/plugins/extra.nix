{ pkgs, ... }:
let
  mkLambdaPlugin = { repo, rev, hash }:
    pkgs.vimUtils.buildVimPlugin {
      pname = repo;
      version = rev;
      src = pkgs.fetchFromGitHub {
        owner = "lambdalisue";
        inherit repo rev hash;
      };
    };

  vim-nerdfont = mkLambdaPlugin {
    repo = "vim-nerdfont";
    rev = "cc50782ee9580fc70b659cf1ebd55229d94b37ab";
    hash = "sha256-Eb79rGmFBidT9hdjYZqyxwXynpsipfZopJFabYHimys=";
  };
  vim-fern-renderer-nerdfont = mkLambdaPlugin {
    repo = "vim-fern-renderer-nerdfont";
    rev = "325629c68eb543229715b68920fbcb92b206beb6";
    hash = "sha256-bcFIyPHxdckmmEGSCr9F5hLGTENF+KgRoz2BK49rGv4=";
  };
  vim-fern-git-status = mkLambdaPlugin {
    repo = "vim-fern-git-status";
    rev = "151336335d3b6975153dad77e60049ca7111da8e";
    hash = "sha256-9N+T/MB+4hKcxoKRwY8F7iwmTsMtNmHCHiVZfcsADcc=";
  };
  vim-fern-hijack = mkLambdaPlugin {
    repo = "vim-fern-hijack";
    rev = "f65524899231b15528066744e714fb344abf0892";
    hash = "sha256-mtGg1rUif5pl/PvFUOJImHQ/Zde/Vr0VOSeDJXmkDPk=";
  };
in
{
  programs.nixvim = {
    extraPlugins = [
      pkgs.vimPlugins.vim-repeat
      pkgs.vimPlugins.haskell-vim
      pkgs.vimPlugins.vim-tmux
      pkgs.vimPlugins.vim-fern
      vim-nerdfont
      vim-fern-renderer-nerdfont
      vim-fern-git-status
      vim-fern-hijack
    ];

    globals = {
      "fern#disable_drawer_smart_quit" = 1;
      "fern#default_hidden" = 0;
      "fern#renderer" = "nerdfont";
    };

    keymaps = [
      {
        mode = "n";
        key = "-";
        action.__raw = ''
          function()
            if vim.bo.filetype == 'fern' then
              vim.cmd.wincmd 'p'
            else
              vim.cmd.Fern('.', '-reveal=%', '-width=30', '-drawer', '-right')
            end
          end
        '';
        options = { noremap = true; silent = true; };
      }
    ];

    autoGroups.FernSettings.clear = true;

    autoCmd = [
      {
        event = [ "FileType" ];
        group = "FernSettings";
        pattern = "fern";
        callback.__raw = ''
          function()
            vim.opt_local.number = false
            vim.opt_local.relativenumber = false
            vim.opt_local.signcolumn = "no"
            vim.b.miniindentscope_disable = true
            vim.b.minicursorword_disable = true

            local function bmap(lhs, rhs)
              vim.keymap.set('n', lhs, rhs, { buffer = true, noremap = true, silent = true })
            end
            -- window 移動と衝突するので無効化
            bmap('s', '<Nop>')
            -- ディレクトリ展開
            bmap('l', '<Plug>(fern-action-expand)')
            -- fern 内でも vim-tmux-navigator で移動
            bmap('<C-h>', '<cmd>TmuxNavigateLeft<cr>')
            bmap('<C-l>', '<cmd>TmuxNavigateRight<cr>')
            bmap('<C-j>', '<cmd>TmuxNavigateDown<cr>')
            bmap('<C-k>', '<cmd>TmuxNavigateUp<cr>')
          end
        '';
      }
    ];
  };
}
