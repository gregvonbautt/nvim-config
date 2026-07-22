return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1001,
    config = function()
      vim.cmd([[colorscheme catppuccin-mocha]])
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
        window = {
          position = "current",
        },
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

      vim.keymap.set('n', '<leader>tt', function()
        vim.cmd("Neotree toggle")
      end, { desc = 'Toggle Neotree' })
    end
  },

  {
    'nvim-telescope/telescope.nvim', version = '*',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function()
      require('telescope').setup({
        defaults = {
          path_display = { "filename_first" },
          mappings = {
            i = {
              ["<C-p>"] = require('telescope.actions.layout').toggle_preview,
            },
            n = {
              ["<C-p>"] = require('telescope.actions.layout').toggle_preview,
            },
          },
        }
      })
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
      require("lualine").setup({
        sections = {
          lualine_c = { { "filename", path = 1 } },
        },
      })
    end
  },

  {
   "OXY2DEV/markview.nvim",
    lazy=false,
  },

  -- Mason (installs LSP servers)
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  -- Java LSP (nvim-jdtls, configured in ftplugin/java.lua)
  { "mfussenegger/nvim-jdtls" },

  -- Completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        snippet = {
          expand = function(args) require("luasnip").lsp_expand(args.body) end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
          ["<C-d>"] = cmp.mapping.scroll_docs(4),
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        },
      })
    end,
  },
}
