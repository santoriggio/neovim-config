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
        ensure_installed = { "lua_ls", "ts_ls", "cssls", "rust_analyzer", "arduino_language_server" },
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
      })

      lsp.cssls.setup({
        capabilities = capabilities,
      })

      lsp.rust_analyzer.setup({
        capabilities = capabilities,
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
