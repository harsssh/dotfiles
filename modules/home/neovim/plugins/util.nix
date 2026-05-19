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
        settings.no_wrap = 1;
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
              map("n", "<C-l>", function()
                for _, w in ipairs(vim.api.nvim_list_wins()) do
                  if vim.bo[vim.api.nvim_win_get_buf(w)].filetype == "snacks_layout_box"
                     and vim.api.nvim_win_get_config(w).relative == "" then
                    vim.api.nvim_set_current_win(w)
                    vim.cmd("TmuxNavigateRight")
                    return
                  end
                end
              end, opts)
              map("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>",  opts)
              map("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>",  opts)
              map("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>",    opts)
            end)
          end,
        })
      end
    '';
  };
}
