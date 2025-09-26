-- Need to install fd, ripgrep
-- brew install fd ripgrep
return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.6",
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
          "--max-filesize=1M"
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
            preview_width = 0.5,
          },
          vertical = {
            mirror = false,
          },
        },
        file_sorter = require("telescope.sorters").get_fuzzy_file,
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        path_display = { "truncate" },
        winblend = 0,
        border = {},
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
        use_less = true,
        set_env = { ["COLORTERM"] = "truecolor" },
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
        -- Aggiungi cache per performance
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
          find_command = {
            "fd",
            "--type", "f",
            "--strip-cwd-prefix",
            "--hidden",
            "--exclude", ".git",
            "--exclude", "node_modules"
          },
        },
        live_grep = {
          only_sort_text = true,
          previewer = true
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    })

    local builtin = require("telescope.builtin")

    -- Funzione per live grep con filtro per estensioni
    local function live_grep_by_extension()
      local extension = vim.fn.input("Estensione file (es: .js, .py, .lua): ")
      if extension ~= "" then
        -- Rimuovi il punto se presente all'inizio
        extension = extension:gsub("^%.", "")
        builtin.live_grep({
          additional_args = function()
            return { "--type-add", "custom:*." .. extension, "--type", "custom" }
          end
        })
      else
        builtin.live_grep()
      end
    end

    -- Funzione per live grep in una cartella specifica
    local function live_grep_in_folder()
      local folder = vim.fn.input("Cartella (es: src/, lua/, .): ")
      if folder ~= "" then
        builtin.live_grep({
          search_dirs = { folder }
        })
      else
        builtin.live_grep()
      end
    end

    -- Funzione per live grep con esclusione di cartelle
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
          end
        })
      else
        builtin.live_grep()
      end
    end

    -- Funzione per live grep con pattern personalizzato
    local function live_grep_with_pattern()
      local pattern = vim.fn.input("Pattern file (es: *.{js,ts}, **/*.py): ")
      if pattern ~= "" then
        builtin.live_grep({
          additional_args = function()
            return { "--glob", pattern }
          end
        })
      else
        builtin.live_grep()
      end
    end

    -- Keymaps standard
    vim.keymap.set("n", "<C-p>", builtin.find_files, {})
    vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
    vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
    vim.keymap.set("n", "<leader>fw", function()
      builtin.grep_string({ search = vim.fn.input("Grep > ") })
    end)
    vim.keymap.set("n", "<leader>m", builtin.marks, {})
    vim.keymap.set("n", "<leader>fq", builtin.quickfix, {})

    -- Nuovi keymaps per le funzionalità avanzate di live grep
    -- vim.keymap.set("n", "<leader>fge", live_grep_by_extension, { desc = "Live grep per estensione" })
    -- vim.keymap.set("n", "<leader>fgf", live_grep_in_folder, { desc = "Live grep in cartella" })
    -- vim.keymap.set("n", "<leader>fgx", live_grep_exclude_folders, { desc = "Live grep escludendo cartelle" })
    -- vim.keymap.set("n", "<leader>fgp", live_grep_with_pattern, { desc = "Live grep con pattern" })

    -- vim.keymap.set({ "n", "i" }, "<C-q>", builtin.smart_send_to_qflist, {})
  end,
}
