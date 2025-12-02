local M = {}

M.setup = function()
  local telescope = require('telescope')

  local actions = require('telescope.actions')

  telescope.setup({
    defaults = {
      mappings = {
        i = {
          ['<C-f>'] = actions.to_fuzzy_refine,
        },
      },
      sorting_strategy = 'ascending',
      layout_strategy = 'vertical',
      layout_config = {
        prompt_position = "top",
        mirror = true,
      },
      -- パフォーマンス最適化
      file_ignore_patterns = {
        "%.git/",
        "node_modules/",
        "target/",
        "build/",
        "dist/",
        "%.lock$",       -- *.lock files
        "%-lock%.json$", -- *-lock.json files
        "%-lock%.yaml$", -- *-lock.yaml files
        "%-lock%.yml$",  -- *-lock.yml files
      },
      path_display = { "truncate" },
      dynamic_preview_title = true,
      preview = {
        timeout = 200,
        filesize_limit = 0.1,
      },
      -- 起動時間短縮
      results_title = false,
      prompt_title = false,
    },
    pickers = {
      find_files = {
        find_command = { "fd", "--type", "f", "--hidden", "--exclude", ".git" },
        previewer = false,
        theme = "dropdown",
      },
      live_grep = {
        additional_args = function()
          return {
            "--hidden",
            "--glob", "!.git/*",
            "--glob", "!*.lock",
            "--glob", "!*-lock.json",
            "--glob", "!*-lock.yaml",
          }
        end,
        only_sort_text = false,
      },
      current_buffer_fuzzy_find = {
        previewer = false,
        theme = "dropdown",
      },
    },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      }
    }
  })

  -- fzf-native が正常にビルドされている場合のみ読み込み
  local ok, _ = pcall(telescope.load_extension, 'fzf')
  if not ok then
    vim.notify("telescope-fzf-native not available, using default sorter", vim.log.levels.WARN)
  end
end

return M
