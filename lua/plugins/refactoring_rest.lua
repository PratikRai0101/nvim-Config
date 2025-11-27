return {
  -- refactoring.nvim (requires plenary + treesitter)
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("refactoring").setup({})

      -- example visual-mode mapping: extract function
      vim.api.nvim_set_keymap(
        "v",
        "<leader>re",
        ":<C-U>lua require('refactoring').refactor('Extract Function')<CR>",
        { noremap = true, silent = true }
      )

      -- example normal-mode mapping to prompt refactors (if you wire up a menu)
      vim.api.nvim_set_keymap(
        "n",
        "<leader>rR",
        ":lua require('telescope').extensions.refactoring.refactors()<CR>",
        { noremap = true, silent = true }
      )
    end,
  },

  -- rest.nvim (HTTP client)
  {
    "NTBBloodbath/rest.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("rest-nvim").setup({
        -- example settings (customize as you like)
        result_split_horizontal = false,
        result_split_in_place = false,
        skip_ssl_verification = false,
        highlight = {
          enabled = true,
          timeout = 150,
        },
      })

      -- example mapping to run the request under the cursor
      vim.keymap.set("n", "<leader>rr", "<Plug>RestNvim", { silent = true })
    end,
  },
}
