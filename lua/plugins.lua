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

      vim.keymap.set('n', '<leader>td', function()
        if next(require("diffview.lib").views) ~= nil then
          vim.cmd("DiffviewClose")
        else
          vim.cmd("DiffviewOpen")
        end
      end, { desc = 'Toggle DiffView' })

      vim.keymap.set('n', '<leader>th', function()
        if next(require("diffview.lib").views) ~= nil then
          vim.cmd("DiffviewClose")
        else
          vim.cmd("DiffviewFileHistory %")
        end
      end, { desc = 'Toggle file history' })
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
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        current_line_blame = false,
      })

      vim.keymap.set("n", "<leader>tb", function()
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          if vim.bo[vim.api.nvim_win_get_buf(win)].filetype == "gitsigns-blame" then
            vim.api.nvim_win_close(win, true)
            return
          end
        end
        require("gitsigns").blame()
      end, { desc = "Toggle git blame" })
    end
  },

  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup()
    end
  },

  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("bufferline").setup()
    end
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      local wk = require("which-key")
      wk.setup()
      wk.add({
        { "<leader>f", group = "find" },
        { "<leader>t", group = "toggle" },
      })
    end
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup()
    end
  },

  {
   "OXY2DEV/markview.nvim",
    lazy=false,
  }
}
