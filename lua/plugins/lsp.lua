return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({})
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "ts_ls", "cssls", "rust_analyzer", "arduino_language_server" },
        automatic_enable = false,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
      })

      vim.lsp.config("ts_ls", {
        capabilities = capabilities,
        on_attach = function(client, _bufnr)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end,
        settings = {
          typescript = {
            preferences = {
              includePackageJsonAutoImports = "auto",
              importModuleSpecifierPreference = "relative",
            },
            suggest = {
              autoImports = true,
              includeCompletionsForImportStatements = true,
            },
            inlayHints = {
              parameterNames = { enabled = "all" },
              variableTypes = { enabled = true },
              functionLikeReturnTypes = { enabled = true },
            },
          },
          javascript = {
            preferences = {
              includePackageJsonAutoImports = "auto",
              importModuleSpecifierPreference = "relative",
            },
            suggest = {
              autoImports = true,
              includeCompletionsForImportStatements = true,
            },
          },
        },
      })

      vim.lsp.config("cssls", {
        capabilities = capabilities,
      })

      vim.lsp.config("rust_analyzer", {
        capabilities = capabilities,
      })

      local HOME = vim.fn.expand("~")
      local MY_FQBN = "arduino:avr:uno"
      vim.lsp.config("arduino_language_server", {
        capabilities = capabilities,
        cmd = {
          "arduino-language-server",
          "-cli-config",
          HOME .. "/Library/Arduino15/arduino-cli.yaml",
          "-fqbn",
          MY_FQBN,
        },
      })

      for _, server in ipairs({
        "lua_ls",
        "ts_ls",
        "cssls",
        "rust_analyzer",
        "arduino_language_server",
      }) do
        vim.lsp.enable(server)
      end
    end,
  },
}
