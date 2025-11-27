return{
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = { 
      'nvim-lua/plenary.nvim',
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
      "nvim-telescope/telescope-file-browser.nvim",
    },
    config = function()
      local builtin = require("telescope.builtin")
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      
      telescope.setup({
        defaults = {
          wrap_results = true,
          layout_strategy = "horizontal",
          layout_config = { prompt_position = "top" },
          sorting_strategy = "ascending",
          winblend = 0,
          mappings = {
            n = {},
          },
        },
        pickers = {
          diagnostics = {
            theme = "ivy",
            initial_mode = "normal",
            layout_config = {
              preview_cutoff = 9999,
            },
          },
        },
        extensions = {
          file_browser = {
            theme = "dropdown",
            hijack_netrw = true,
            mappings = {
              ["n"] = {
                ["N"] = telescope.extensions.file_browser.actions.create,
                ["h"] = telescope.extensions.file_browser.actions.goto_parent_dir,
              },
            },
          },
        },
      })

      -- Load extensions
      telescope.load_extension("fzf")
      telescope.load_extension("file_browser")

      -- Your original keymaps
      vim. keymap.set('n', '<C-p>', builtin.find_files, {})
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})

      -- Additional keymaps from JazzyGrim
      vim.keymap. set('n', ';f', function()
        builtin.find_files({ no_ignore = false, hidden = true })
      end, { desc = "Find files" })

      vim. keymap.set('n', ';r', builtin.live_grep, { desc = "Live grep" })
      vim.keymap.set('n', '\\\\', builtin.buffers, { desc = "List buffers" })
      vim. keymap.set('n', ';;', builtin.resume, { desc = "Resume telescope" })
      vim.keymap.set('n', ';e', builtin.diagnostics, { desc = "Diagnostics" })
      vim. keymap.set('n', ';s', builtin.treesitter, { desc = "Treesitter symbols" })
      
      vim.keymap.set('n', 'sf', function()
        telescope.extensions.file_browser.file_browser({
          path = "%:p:h",
          cwd = vim.fn.expand("%:p:h"),
          respect_gitignore = false,
          hidden = true,
          grouped = true,
          previewer = false,
          initial_mode = "normal",
          layout_config = { height = 40 },
        })
      end, { desc = "File browser" })
    end
  },
  {
     "nvim-telescope/telescope-ui-select.nvim",
    config = function()
    require("telescope").setup ({
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        }
       }
      }
    })
    require("telescope").load_extension("ui-select")
    end
  },
}
