return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        -- Lua
        null_ls.builtins.formatting.stylua,
        
        -- Python
        null_ls.builtins.formatting.black,
        null_ls.builtins. formatting.isort,
        
        -- Ruby
        null_ls.builtins.diagnostics.rubocop,
        null_ls.builtins. formatting.rubocop,
        
        -- Web (JavaScript, TypeScript, CSS, HTML, JSON, etc.)
        null_ls. builtins.formatting.prettier. with({
          filetypes = {
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "vue",
            "css",
            "scss",
            "less",
            "html",
            "json",
            "jsonc",
            "yaml",
            "markdown",
            "graphql",
          },
        }),
      },
    })
    
    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, { desc = "Format file" })
  end,
}
