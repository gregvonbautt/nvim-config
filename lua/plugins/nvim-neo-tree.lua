return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", -- optional, but recommended
    },
    lazy = false, -- neo-tree will lazily load itself
    config = function()
      require("neo-tree").setup({
      filesystem = {
        bind_to_cwd = true, -- True by default; keeps neo-tree root and global CWD in sync
        follow_current_file = {
          enabled = true,   -- Focuses and syncs the tree to the file open in your current buffer
        },
      },
    })
    end
  }
}
