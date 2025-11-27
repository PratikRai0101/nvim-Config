-- VERY EARLY: Filter noisy lspconfig deprecation messages (apply BEFORE plugins load)
do
  -- safe references to original functions (some may be nil)
  local _notify = vim.notify or function(...) end
  local _echo = vim.api.nvim_echo or function(...) end
  local _err = vim.api.nvim_err_writeln or function(...) end

  local function should_suppress(msg)
    if not msg then return false end
    if type(msg) == "table" then msg = table.concat(msg, " ") end
    if type(msg) ~= "string" then return false end
    if msg:match("lspconfig") and msg:match("deprecated") then
      return true
    end
    if msg:match("Feature will be removed") and msg:match("lspconfig") then
      return true
    end
    return false
  end

  vim.notify = function(msg, ...)
    if should_suppress(msg) then return end
    return _notify(msg, ...)
  end

  vim.api.nvim_echo = function(chunks, hl, opts)
    -- chunks can be a table of {text, hl}
    local s = ""
    if type(chunks) == "table" then
      for _, c in ipairs(chunks) do
        if type(c) == "table" then s = s .. tostring(c[1]) end
      end
    elseif type(chunks) == "string" then
      s = chunks
    end
    if should_suppress(s) then return end
    return _echo(chunks, hl, opts)
  end

  vim.api.nvim_err_writeln = function(msg)
    if should_suppress(msg) then return end
    return _err(msg)
  end
end

-- bootstrap lazy.nvim (unchanged)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then 
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

local opts = {}

require("nvim-config")
require("lazy").setup("plugins")
