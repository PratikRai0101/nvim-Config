return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason"). setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig"). setup()
    end,
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim", "hrsh7th/cmp-nvim-lsp" },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- shared on_attach for keymaps
      local on_attach = function(client, bufnr)
        local opts = { buffer = bufnr, silent = true }
        vim.keymap. set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap. set("n", "<leader>gd", vim.lsp. buf.definition, opts)
        vim. keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts)
        vim.keymap. set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>d", vim.diagnostic. open_float, opts)
        vim. keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
      end

      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
              workspace = { checkThirdParty = false, library = vim.api. nvim_get_runtime_file("", true) },
              telemetry = { enable = false },
            },
          },
        },
        html = {},
        cssls = {},
        tailwindcss = {},
        ts_ls = {
          settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = "literal",
                includeInlayFunctionParameterTypeHints = true,
              },
            },
            javascript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayFunctionParameterTypeHints = true,
              },
            },
          },
        },
        jsonls = {},
        solargraph = {},
      }

      -- NEW Neovim 0.11+ API
      for name, cfg in pairs(servers) do
        cfg = vim.tbl_deep_extend("force", { capabilities = capabilities, on_attach = on_attach }, cfg or {})
        vim.lsp.config(name, cfg)
        vim.lsp.enable(name)
      end

      vim. diagnostic.config({
        virtual_text = true,
        signs = true,
        update_in_insert = false,
        underline = true,
        severity_sort = true,
        float = { border = "rounded", source = "always" },
      })
    end,
  },
}
