local jdtls = require("jdtls")
local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
local home = os.getenv("HOME")

-- Load optional bemol workspace integration
local ok, bemol = pcall(require, "config.bemol")
local ws_info = ok and bemol.detect(vim.fn.expand("%:p:h")) or nil

local root_dir
if ws_info then
  root_dir = require("jdtls.setup").find_root({ "packageInfo" })
      or vim.fs.root(0, { ".bemol", ".git" })
else
  root_dir = vim.fs.root(0, { ".project", "build.gradle.kts", "build.gradle", "pom.xml", ".git" })
end
if not root_dir then return end

local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
local eclipse_workspace = home .. "/.cache/jdtls/" .. project_name

local config = {
  cmd = { mason_bin .. "/jdtls", "-data", eclipse_workspace },
  root_dir = root_dir,
  init_options = {
    workspaceFolders = ws_info and ws_info.folders or {},
    settings = ws_info and {
      java = {
        import = {
          gradle = { enabled = false },
          maven = { enabled = false },
        },
      },
    } or nil,
  },
  settings = {
    java = {
      eclipse = { downloadSources = true },
      import = {
        gradle = { enabled = not ws_info },
        maven = { enabled = not ws_info },
      },
    },
  },
}

jdtls.start_or_attach(config)
