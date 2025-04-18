return { {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    lint.lint_ignore_pattern = { "node_modules/*", "build/*" };
    lint.linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", {
      clear = true
    })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end
    })

    -- Configurazione per mostrare le diagnostiche inline
    vim.diagnostic.config({
      virtual_text = true,
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = false
    })
  end
}, {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform");

    conform.setup({
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback"
      },
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { { "prettier", "prettierd" } },
        typescript = { { "prettier", "prettierd" } },
        javascriptreact = { { "prettier", "prettierd" } },
        typescriptreact = { { "prettier", "prettierd" } },
        json = { { "prettier", "prettierd" } }
      }
    })

    vim.keymap.set("n", "<leader>f", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 500
      })
    end)
  end
} }
