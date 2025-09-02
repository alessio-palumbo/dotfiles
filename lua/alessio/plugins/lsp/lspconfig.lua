return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local lspconfig = require("lspconfig")
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    local servers = {
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
          },
        },
      },
      gopls = {
        settings = {
          gopls = {
            analyses = { unusedparams = true },
            staticcheck = true,
          },
        },
      },
      emmet_ls = {
        filetypes = { "html", "css", "javascriptreact", "typescriptreact", "svelte" },
        init_options = {
          html = {
            options = {
              ["bem.enabled"] = true,
            },
          },
        },
      },
      pyright = {
        settings = {
          pyright = {
            autoImportCompletions = true,
          },
          python = {
            analysis = {
              autoSearchPaths = true,
              diagnosticMode = "workspace",
              typeCheckingMode = "basic",
              useLibraryCodeForTypes = true,
            },
          },
        },
      },
    }

    -- Setup each LSP server
    for server_name, config in pairs(servers) do
      config.capabilities = capabilities
      lspconfig[server_name].setup(config)
    end
  end,
}
