-- Need to install fd, ripgrep
-- brew install fd ripgrep
-- find_files: sorter nativo (fuzzy meno permissivo); live_grep: fzf-native
return {
  "nvim-telescope/telescope.nvim",
  tag = "v0.2.1",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
  },
  config = function()
    require("telescope").setup({
      defaults = {
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden",
          "--glob=!.git/*",
          "--glob=!node_modules/*",
          "--glob=!*.lock",
          "--max-filesize=1M",
        },
        prompt_prefix = " ",
        selection_caret = " ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "descending",
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            mirror = false,
            preview_width = 0.55,
          },
          vertical = {
            mirror = false,
          },
        },
        file_sorter = require("telescope.sorters").get_fuzzy_file,
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        path_display = { "filename_first" },
        winblend = 0,
        border = {},
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
        use_less = false,
        set_env = { ["COLORTERM"] = "truecolor" },
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
        cache_index = true,
        mappings = {
          i = {
            ["<C-n>"] = "move_selection_next",
            ["<C-p>"] = "move_selection_previous",
            ["<C-c>"] = "close",
            ["<C-j>"] = "preview_scrolling_down",
            ["<C-k>"] = "preview_scrolling_up",
            ["<C-q>"] = "send_to_qflist",
            ["<CR>"] = "select_default",
          },
          n = {
            ["<C-c>"] = "close",
            ["<C-q>"] = "send_to_qflist",
            ["<C-n>"] = "move_selection_next",
            ["<C-p>"] = "move_selection_previous",
            ["<CR>"] = "select_default",
          },
        },
      },
      pickers = {
        find_files = {
          respect_gitignore = true,
        },
        live_grep = {
          only_sort_text = true,
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = false,
          case_mode = "smart_case",
        },
      },
    })

    local builtin = require("telescope.builtin")

    local function fd_find_command(hidden)
      local cmd = {
        "fd",
        "--type", "f",
        "--strip-cwd-prefix",
        "--exclude", ".git",
        "--exclude", "node_modules",
      }
      if hidden then
        table.insert(cmd, "--hidden")
      end
      return cmd
    end

    local function find_files(hidden)
      builtin.find_files({
        respect_gitignore = true,
        find_command = fd_find_command(hidden),
      })
    end

    local function live_grep_by_extension()
      local extension = vim.fn.input("Estensione file (es: .js, .py, .lua): ")
      if extension ~= "" then
        extension = extension:gsub("^%.", "")
        builtin.live_grep({
          additional_args = function()
            return { "--type-add", "custom:*." .. extension, "--type", "custom" }
          end,
        })
      else
        builtin.live_grep()
      end
    end

    local function live_grep_in_folder()
      local folder = vim.fn.input("Cartella (es: src/, lua/, .): ")
      if folder ~= "" then
        builtin.live_grep({
          search_dirs = { folder },
        })
      else
        builtin.live_grep()
      end
    end

    local function live_grep_exclude_folders()
      local exclude_folders = vim.fn.input("Cartelle da escludere (es: node_modules,dist): ")
      if exclude_folders ~= "" then
        local folders = {}
        for folder in exclude_folders:gmatch("[^,]+") do
          table.insert(folders, "--glob=!" .. folder:match("^%s*(.-)%s*$") .. "/*")
        end

        builtin.live_grep({
          additional_args = function()
            return folders
          end,
        })
      else
        builtin.live_grep()
      end
    end

    local function live_grep_with_pattern()
      local pattern = vim.fn.input("Pattern file (es: *.{js,ts}, **/*.py): ")
      if pattern ~= "" then
        builtin.live_grep({
          additional_args = function()
            return { "--glob", pattern }
          end,
        })
      else
        builtin.live_grep()
      end
    end

    vim.keymap.set("n", "<C-p>", function() find_files(false) end, { desc = "Find files" })
    vim.keymap.set("n", "<leader>ff", function() find_files(false) end, { desc = "Find files" })
    vim.keymap.set("n", "<leader>fH", function() find_files(true) end, { desc = "Find files (hidden)" })
    vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
    vim.keymap.set("n", "<leader>fw", function()
      builtin.grep_string({ search = vim.fn.input("Grep > ") })
    end, { desc = "Grep string" })
    vim.keymap.set("n", "<leader>m", builtin.marks, { desc = "Marks" })
    vim.keymap.set("n", "<leader>fq", builtin.quickfix, { desc = "Quickfix" })

    -- vim.keymap.set("n", "<leader>fge", live_grep_by_extension, { desc = "Live grep per estensione" })
    -- vim.keymap.set("n", "<leader>fgf", live_grep_in_folder, { desc = "Live grep in cartella" })
    -- vim.keymap.set("n", "<leader>fgx", live_grep_exclude_folders, { desc = "Live grep escludendo cartelle" })
    -- vim.keymap.set("n", "<leader>fgp", live_grep_with_pattern, { desc = "Live grep con pattern" })

    -- vim.keymap.set({ "n", "i" }, "<C-q>", builtin.smart_send_to_qflist, {})
  end,
}
