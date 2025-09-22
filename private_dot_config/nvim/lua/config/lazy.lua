-- Bootstrap lazy.nvim
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

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
      --   -- Core libraries -----------------------------------------------------------
  "nvim-lua/plenary.nvim",
  { "nvim-tree/nvim-web-devicons", lazy = true },  -- icons for many plugins

  -- UI ----------------------------------------------------------------------
  { "nvim-lualine/lualine.nvim",  config = function() require("plugins.ui").lualine() end },
  { "windwp/nvim-autopairs",      config = true },
  -- { "folke/which-key.nvim",       config = true },
  { "goolord/alpha-nvim",         config = function() require("plugins.alpha").setup() end, event = "VimEnter" },

  -- Treesitter --------------------------------------------------------------
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", config = function()
      require("plugins.treesitter").setup()
    end
  },

  -- Telescope ---------------------------------------------------------------
  { "nvim-telescope/telescope.nvim",
    dependencies = { "plenary.nvim" },
    config = function() require("plugins.telescope").setup() end
  },

  -- LSP / Completion --------------------------------------------------------
  { "neovim/nvim-lspconfig",      dependencies = { "cmp-nvim-lsp" } },
  { "williamboman/mason.nvim",    config = true },
  { "williamboman/mason-lspconfig.nvim", config = true },
  { "hrsh7th/nvim-cmp",           config = function() require("plugins.cmp").setup() end },
  "hrsh7th/cmp-nvim-lsp",
  "L3MON4D3/LuaSnip",
  "saadparwaiz1/cmp_luasnip",
  { "nvimtools/none-ls.nvim",     config = true }, -- formatters & linters

  -- Git ---------------------------------------------------------------------
  { "lewis6991/gitsigns.nvim",    config = function() require("plugins.git").gitsigns() end },
  -- "tpope/vim-fugitive",
  -- { "sindrets/diffview.nvim",     cmd = { "DiffviewOpen" } },

  -- Others / misc -----------------------------------------------------------
  -- { "ThePrimeagen/harpoon",       branch = "harpoon2", config = true },
  -- { "numToStr/Comment.nvim",      config = true },
  { "folke/trouble.nvim",         config = true },
  { "nvim-pack/nvim-spectre",     cmd = "Spectre" },

  -- Colour Scheme
  -- { "folke/tokyonight.nvim",      lazy = false, priority = 1000 }, -- colorscheme
    { "ellisonleao/gruvbox.nvim", priority = 1000 , config = true, opts = ...}
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = {
        enabled = true,
        notify = false,
    },

})
