return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({})
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "ts_ls", "cssls", "rust_analyzer", "arduino_language_server", "eslint" },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lsp = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      lsp.lua_ls.setup({
        capabilities = capabilities,
      })

      lsp.ts_ls.setup({
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          -- Disabilita formattazione se hai altri formatter
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end,
        settings = {
          typescript = {
            -- Abilita la risoluzione automatica degli alias
            preferences = {
              includePackageJsonAutoImports = "auto",
              importModuleSpecifierPreference = "relative",
            },
            -- Configurazione per la risoluzione dei path
            suggest = {
              autoImports = true,
              includeCompletionsForImportStatements = true,
            },
            -- Abilita la risoluzione dei path dal tsconfig.json
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

      lsp.cssls.setup({
        capabilities = capabilities,
      })

      lsp.rust_analyzer.setup({
        capabilities = capabilities,
      })

      lsp.eslint.setup({
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          -- ESLint può formattare, ma di solito si preferisce Prettier
          client.server_capabilities.documentFormattingProvider = false
        end,
        settings = {
          -- Configurazione per la risoluzione degli alias
          workingDirectory = { mode = "auto" },
          codeAction = {
            disableRuleComment = {
              enable = true,
              location = "separateLine"
            }
          },
          format = false, -- Usa Prettier per il formatting
        },
      })

      local MY_FQBN = "arduino:avr:uno"
      local ESP8266_FQBN = "esp8266:esp8266:nodemcu"
      local HOME = vim.fn.expand("~")
      lsp.arduino_language_server.setup({
        capabilities = capabilities,
        cmd = {
          "arduino-language-server",
          "-cli-config", HOME .. "/Library/Arduino15/arduino-cli.yaml",
          "-fqbn",
          MY_FQBN,
        }
      })
    end,
  },
}
