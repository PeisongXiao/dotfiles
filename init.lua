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

  -- LSP
  "neovim/nvim-lspconfig",

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

-- Folding: Tree-sitter driven
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99
vim.cmd("colorscheme onedark")

-- ===============================
-- Tree-sitter
-- ===============================
require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "c", "cpp", "lua", "python", "go",
    "verilog", "bash", "json", "yaml",
    "markdown"
  },
  highlight = { enable = true },
  indent = { enable = true },
					})

-- ===============================
-- LSP
-- ===============================
local capabilities = vim.lsp.protocol.make_client_capabilities()

local servers = {
  clangd = {},
  pyright = {},
  gopls = {},
  verible = {},
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
        },
      },
    },
  },
}

for name, opts in pairs(servers) do
  vim.lsp.config[name] = {
    capabilities = capabilities,
    settings = opts.settings,
    flags = {
      debounce_text_changes = 200,
    },
  }
end

vim.lsp.enable({
  "clangd",
  "pyright",
  "gopls",
  "verible",
  "lua_ls",
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    vim.bo[args.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
  end,
})

-- ===============================
-- Diagnostics
-- ===============================
vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
})

-- ===============================
-- UI
-- ===============================
require("lualine").setup({
  options = { theme = "auto", section_separators = "", component_separators = "" }
})

require("which-key").setup({})
require("nvim-autopairs").setup({})
