-- Bemol multi-project workspace detection.
-- Searches upward for .bemol/ws_root_folders and returns the workspace root
-- and project folder URIs for jdtls.
-- Also patches .project files to replace Gradle nature with Java nature
-- (prevents jdtls from attempting Gradle sync which hangs on Brazil projects).
-- Delete this file to disable bemol integration entirely.

local M = {}

local function ensure_java_nature(project_file)
  local f = io.open(project_file, "r")
  if not f then return end
  local text = f:read("*a")
  f:close()

  local changed = false

  -- Add Java nature if missing
  if not text:find("javanature") then
    text = text:gsub(
      "<natures>",
      "<natures>\n\t\t<nature>org.eclipse.jdt.core.javanature</nature>"
    )
    text = text:gsub(
      "<buildSpec>",
      "<buildSpec>\n\t\t<buildCommand>\n\t\t\t<name>org.eclipse.jdt.core.javabuilder</name>\n\t\t\t<arguments>\n\t\t\t</arguments>\n\t\t</buildCommand>"
    )
    changed = true
  end

  -- Remove Gradle nature and builder entirely
  if text:find("gradleprojectnature") then
    text = text:gsub("\t*<nature>org%.eclipse%.buildship%.core%.gradleprojectnature</nature>\n?", "")
    text = text:gsub("\t*<buildCommand>\n\t*<name>org%.eclipse%.buildship%.core%.gradleprojectbuilder</name>\n\t*<arguments>\n\t*</arguments>\n\t*</buildCommand>\n?", "")
    changed = true
  end

  if changed then
    local out = io.open(project_file, "w")
    if out then
      out:write(text)
      out:close()
    end
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
