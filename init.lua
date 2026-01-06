-- ===============================
-- Bootstrap lazy.nvim
-- ===============================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-- ===============================
-- Plugins
-- ===============================
require("lazy").setup({

  {
     "navarasu/onedark.nvim",
     lazy = false,
     priority = 1000,
  },

  -- Tree-sitter
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

  -- UI (minimal)
  "nvim-lualine/lualine.nvim",
  "folke/which-key.nvim",

  -- Git
  "tpope/vim-fugitive",

  -- Small QoL
  "windwp/nvim-autopairs",
		     })

-- ===============================
-- Core options
-- ===============================
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true

vim.opt.expandtab = true
vim.opt.shiftwidth = 8
vim.opt.tabstop = 8
vim.opt.smartindent = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.undofile = true
vim.opt.backup = false
vim.opt.swapfile = false

vim.cmd("colorscheme onedark")

-- ===============================
-- Tree-sitter
-- ===============================
local ok_ts, ts_configs = pcall(require, "nvim-treesitter.configs")
if ok_ts then
  ts_configs.setup({
    ensure_installed = {
      "c", "cpp", "lua", "python", "go",
      "verilog", "bash", "json", "yaml",
      "markdown"
    },
    highlight = { enable = true },
    indent = { enable = true },
  })

  -- Folding: Tree-sitter driven
  vim.opt.foldmethod = "expr"
  vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
  vim.opt.foldlevel = 99
else
  vim.opt.foldmethod = "manual"
end

-- ===============================
-- UI
-- ===============================
require("lualine").setup({
  options = { theme = "auto", section_separators = "", component_separators = "" }
})

require("which-key").setup({})
require("nvim-autopairs").setup({})
