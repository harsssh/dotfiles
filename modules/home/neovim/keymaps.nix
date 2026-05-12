let
  silent = { silent = true; };
  raw = body: { __raw = body; };
  mk = mode: key: action: opts: { inherit mode key action; options = opts; };
  s = mk "n";
  v = mk "v";
  i = mk "i";

  # vim-repeat 連動の resize keymap
  mkResize = key: cmd: s key (raw ''
    function()
      vim.cmd('${cmd}')
      pcall(vim.fn['repeat#set'], '${key}', vim.v.count)
    end
  '') silent;
in
{
  programs.nixvim = {
    keymaps = [
      # General
      (i "jj" "<ESC>" { })
      (s "<leader>n" ":noh<CR>" { })

      # UI: toggle relativenumber
      (s "rn" (raw ''
        function() vim.wo.relativenumber = not vim.wo.relativenumber end
      '') silent)

      # Move
      (s "j" "gj" silent)
      (v "j" "gj" silent)
      (s "k" "gk" silent)
      (v "k" "gk" silent)
      (s "H" "0" silent)
      (v "H" "0" silent)
      (s "L" "$" silent)
      (v "L" "$" silent)

      # Window split / move
      # Ctrl+hjkl はすべての環境で vim-tmux-navigator (tools.nix) が担当する
      (s "sH" "<C-w>H" { })
      (s "sJ" "<C-w>J" { })
      (s "sK" "<C-w>K" { })
      (s "sL" "<C-w>L" { })
      (s "ss" ":split<CR><C-w>w" { })
      (s "sv" ":vsplit<CR><C-w>w" { })

      # Resize
      (mkResize "s," "vertical resize -3")
      (mkResize "s." "vertical resize +3")
      (mkResize "s-" "resize -3")
      (mkResize "s=" "resize +3")
      (s "s0" "<C-w>=" silent)

      # Yank / Paste
      (s "Y" "y$" { })
      (s "p" "]p" { })
      (s "P" "]P" { })
    ];

    extraConfigLua = ''
      for _, cmd in ipairs({ 'q', 'w', 'qa', 'wq', 'wqa' }) do
        vim.api.nvim_create_user_command(cmd:upper(), cmd, {})
        if #cmd > 2 then
          vim.api.nvim_create_user_command(cmd:sub(1, 1):upper() .. cmd:sub(2), cmd, {})
        end
      end
    '';
  };
}
