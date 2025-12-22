-- autosave.lua
local M = {}

local function save_if_needed()
  if vim.bo.modified and not vim.bo.readonly and vim.fn.expand("%") ~= "" then
    local save_status, err = pcall(vim.api.nvim_command, 'silent! write')
    if save_status then
      print("Autosaved: " .. vim.fn.expand("%:t"))
    else
      print("Autosave failed: " .. tostring(err))
    end
  end
end

function M.setup()

  -- Create an autocommand group
  local status, _ = pcall(vim.api.nvim_create_augroup, "Autosave", { clear = true })
  if not status then
    print("Error creating autocommand group")
    return
  end

  -- Create autocommands for various events
  local events = { "FocusLost", "BufLeave", "InsertLeave" }
  for _, event in ipairs(events) do
    status, _ = pcall(vim.api.nvim_create_autocmd, event, {
      group = "Autosave",
      callback = save_if_needed,
    })

    if not status then
      print("Error creating autocommand for " .. event)
      return
    end
  end

  print("Autosave Is On")
end

return M

