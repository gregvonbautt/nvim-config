return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1001,
    config = function()
      vim.cmd([[colorscheme catppuccin-frappe]])
    end
  },

  {
    "sindrets/diffview.nvim",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    name = "diffview",
    priority = 1000,
    config = function()
      local dv = require("diffview")
      dv.setup({
        -- Force diffview to run git commands relative to the current working directory
        git_cmd = { "git", "-C", "." },
      })

      vim.keymap.set('n', '<leader>td', function() vim.cmd("DiffviewOpen") end, { desc = 'Open DiffView' })
      vim.keymap.set('n', '<leader>tD', function() vim.cmd("DiffviewClose") end, { desc = 'Close DiffView' })
    end
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    lazy = false,
    config = function()
      require("neo-tree").setup({
        filesystem = {
          bind_to_cwd = true,
          follow_current_file = {
            enabled = true,
          },
          filtered_items = {
            visible = true,
          },
        },
      })

      local toggle = function()
        vim.cmd("Neotree toggle")
      end

      vim.api.nvim_create_autocmd("VimEnter", {
        desc = "Always open Neo-tree on startup",
        callback = function()
          vim.cmd("Neotree show")
        end,
      })

      vim.keymap.set('n', '<leader>tt', toggle, { desc = 'Toggle Neotree' })
    end
  },

  {
    'nvim-telescope/telescope.nvim', version = '*',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
    end
  },

  {
   "OXY2DEV/markview.nvim",
    lazy=false,
  }
}
