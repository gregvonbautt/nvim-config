-- Bemol multi-project workspace detection.
-- Searches upward for .bemol/ws_root_folders and returns the workspace root
-- and project folder URIs for jdtls.
-- Also patches .project files to ensure Java nature exists (required for
-- jdtls Eclipse importer to recognize Gradle-based projects).
-- Delete this file to disable bemol integration entirely.

local M = {}

local function ensure_java_nature(project_file)
  local content = io.open(project_file, "r")
  if not content then return end
  local text = content:read("*a")
  content:close()

  if text:find("javanature") then return end
  if not text:find("gradleprojectnature") then return end

  text = text:gsub(
    "<natures>",
    "<natures>\n\t\t<nature>org.eclipse.jdt.core.javanature</nature>"
  )
  text = text:gsub(
    "<buildSpec>",
    "<buildSpec>\n\t\t<buildCommand>\n\t\t\t<name>org.eclipse.jdt.core.javabuilder</name>\n\t\t\t<arguments>\n\t\t\t</arguments>\n\t\t</buildCommand>"
  )

  local out = io.open(project_file, "w")
  if out then
    out:write(text)
    out:close()
  end
end

function M.detect(start_dir)
  local dir = start_dir
  while dir ~= "/" do
    local ws_file = dir .. "/.bemol/ws_root_folders"
    if vim.fn.filereadable(ws_file) == 1 then
      local folders = {}
      for line in io.lines(ws_file) do
        table.insert(folders, "file://" .. line)
        ensure_java_nature(line .. "/.project")
      end
      return { root = dir, folders = folders }
    end
    dir = vim.fn.fnamemodify(dir, ":h")
  end
  return nil
end

return M
