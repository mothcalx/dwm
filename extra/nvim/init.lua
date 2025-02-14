-- init.lua

vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
    config = function()
      require "options"
    end,
  },

  { import = "plugins" },

  {
  "nvim-neo-tree/neo-tree.nvim",
  lazy = false,
  branch = "v3.x",
  config = function()
      require('neo-tree').setup {
        filesystem = {
        filtered_items = {
        visible = false,
        hide_dotfiles = false,
        hide_gitignored = true,
          },
      never_show = { ".git" },
        },
    }
    end,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
    }
  },

  {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    config = function()
      require('nvim-tree').setup {
         --empty
      }
    end,
  },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "nvchad.autocmds"

vim.wo.relativenumber = true

vim.schedule(function()
  require "mappings"
end)

vim.cmd [[
nnoremap \ :Neotree toggle<cr>
]]

