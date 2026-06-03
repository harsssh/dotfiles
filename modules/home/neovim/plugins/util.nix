{ pkgs, ... }:
{
  programs.nixvim = {
    extraPlugins = [
      pkgs.vimPlugins.vim-tmux
    ];

    plugins = {
      persistence = {
        enable = true;
        settings.dir.__raw = ''vim.fn.stdpath("state") .. "/sessions/"'';
      };

      toggleterm = {
        enable = true;
        settings = {
          persist_mode = true;
          persist_size = true;
          start_in_insert = true;
          float_opts = {
            border = "curved";
            width.__raw = "function() return math.floor(vim.o.columns * 0.8) end";
            height.__raw = "function() return math.floor(vim.o.lines * 0.8) end";
          };
        };
      };

      tmux-navigator = {
        enable = true;
        settings = {
          no_wrap = 1;
          no_mappings = 1;
        };
      };
    };

    keymaps = [
      # Persistence
      { mode = "n"; key = "<leader>qs"; action.__raw = "function() require('persistence').load() end"; options.desc = "Restore Session"; }
      { mode = "n"; key = "<leader>qS"; action.__raw = "function() require('persistence').select() end"; options.desc = "Select Session"; }
      { mode = "n"; key = "<leader>ql"; action.__raw = "function() require('persistence').load({ last = true }) end"; options.desc = "Restore Last Session"; }
      { mode = "n"; key = "<leader>qd"; action.__raw = "function() require('persistence').stop() end"; options.desc = "Stop Persistence"; }

      # Toggleterm
      { mode = "n"; key = "<leader>tt"; action = "<cmd>ToggleTerm direction=float<cr>"; options.desc = "Toggle floating terminal"; }
      { mode = "n"; key = "<leader>ts"; action = "<cmd>ToggleTerm direction=horizontal size=15<cr>"; options.desc = "Toggle horizontal terminal"; }
      { mode = "n"; key = "<leader>tv"; action = "<cmd>ToggleTerm direction=vertical size=80<cr>"; options.desc = "Toggle vertical terminal"; }
      { mode = "n"; key = "<C-\\>"; action = "<cmd>ToggleTerm<cr>"; options.desc = "Toggle terminal"; }
      { mode = "t"; key = "<C-\\>"; action = "<C-\\><C-n><cmd>ToggleTerm<cr>"; options.desc = "Toggle terminal (term mode)"; }
      { mode = "t"; key = "<ESC>"; action = "<C-\\><C-n>"; options.desc = "Exit terminal mode"; }

      # tmux-navigator
      { mode = "n"; key = "<C-h>"; action = "<cmd>TmuxNavigateLeft<cr>"; options.desc = "Navigate left"; }
      { mode = "n"; key = "<C-j>"; action = "<cmd>TmuxNavigateDown<cr>"; options.desc = "Navigate down"; }
      { mode = "n"; key = "<C-k>"; action = "<cmd>TmuxNavigateUp<cr>"; options.desc = "Navigate up"; }
      { mode = "n"; key = "<C-l>"; action = "<cmd>TmuxNavigateRight<cr>"; options.desc = "Navigate right"; }
      { mode = "n"; key = "<C-p>"; action = "<cmd>TmuxNavigatePrevious<cr>"; options.desc = "Navigate previous"; }
    ];

    extraConfigLua = ''
      -- snacks explorer (snacks_picker_list) での tmux navigation
      -- snacks_picker_list は floating window のため wincmd l が editor に向かい
      -- TmuxNavigateRight が tmux に届かない。snacks_layout_box (非 floating の右端) を
      -- 経由することで正しく tmux 右ペインへ移動できる。
      do
        local group = vim.api.nvim_create_augroup("ExplorerTmuxNav", { clear = true })
        vim.api.nvim_create_autocmd("BufWinEnter", {
          group = group,
          callback = function(ev)
            if vim.bo[ev.buf].filetype ~= "snacks_picker_list" then return end
            vim.schedule(function()
              if not vim.api.nvim_buf_is_valid(ev.buf) then return end
              local opts = { buffer = ev.buf, nowait = true, silent = true }
              local map = vim.keymap.set
              -- floating window からは wincmd が全てアンカーに向かうため
              -- vim-tmux-navigator を経由せず tmux select-pane を直接呼ぶ
              local function tmux_pane(flag)
                return function()
                  if vim.env.TMUX and vim.env.TMUX ~= "" then
                    vim.fn.system("tmux select-pane -" .. flag)
                  end
                end
              end
              map("n", "<C-l>", tmux_pane("R"), opts)
              map("n", "<C-j>", tmux_pane("D"), opts)
              map("n", "<C-k>", tmux_pane("U"), opts)
              map("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", opts)
            end)
          end,
        })
      end
    '';
  };
}
