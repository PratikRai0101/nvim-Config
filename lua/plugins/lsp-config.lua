return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- list the servers you want
      local servers = { "solargraph", "html", "lua_ls" }

      -- define configs for each server
      for _, server in ipairs(servers) do
        vim.lsp.config(server, {
          capabilities = capabilities,
        })
      end

      -- enable them
      vim.lsp.enable(servers)

      -- LSP keymaps (buffer-local, on attach)
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(ev)
          local opts = { buffer = ev.buf }
          vim.keymap.set("n", "K",         vim.lsp.buf.hover,        opts)
          vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition,   opts)
          vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references,   opts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action,  opts)
        end,
      })
    end,
  },
}

