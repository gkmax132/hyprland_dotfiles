-----------------------------------------------------------
-- 📦 Plugins (Packer)
-----------------------------------------------------------
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

require("packer").startup(function(use)
    use "wbthomason/packer.nvim"

    -- UI
    use "navarasu/onedark.nvim"
    use "nvim-lualine/lualine.nvim"
    use "nvim-tree/nvim-tree.lua"
    use "nvim-tree/nvim-web-devicons"

    -- Fuzzy finder
    use { "nvim-telescope/telescope.nvim", requires = { "nvim-lua/plenary.nvim" } }

    -- Syntax highlighting
    use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
    use "windwp/nvim-ts-autotag"

    -- LSP
    use "neovim/nvim-lspconfig"

    -- Completion
    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-nvim-lsp"

    -- Autopairs
    use "windwp/nvim-autopairs"

    if packer_bootstrap then
        require("packer").sync()
    end
end)

-----------------------------------------------------------
-- ⚙️ Settings
-----------------------------------------------------------
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.mouse = "a"
vim.opt.showmode = false
-- vim.opt.clipboard = "unnamedplus"

-----------------------------------------------------------
-- 🎨 Colorscheme + Прозрачность
-----------------------------------------------------------
vim.cmd("colorscheme onedark")

-- Убираем фон для основных элементов
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" }) -- Неактивные окна
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" }) -- Плавающие окна
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
vim.api.nvim_set_hl(0, "CursorLine", { bg = "none" }) -- Подсветка текущей строки без фона
vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })

-----------------------------------------------------------
-- ⌨️ Keybindings
-----------------------------------------------------------
vim.g.mapleader = " "
local keymap = vim.keymap

keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

-----------------------------------------------------------
-- 🌲 Treesitter
-----------------------------------------------------------
require("nvim-treesitter.configs").setup({
    ensure_installed = { "lua", "javascript", "typescript", "html", "css", "python" },
    highlight = { enable = true },
    autotag = { enable = true },
})

-----------------------------------------------------------
-- 📊 Lualine
-----------------------------------------------------------
require("lualine").setup({
    options = {
        theme = "onedark",
        section_separators = '',
        component_separators = '',
        -- Убираем фон Lualine
        disabled_filetypes = {},
    },
    sections = {
--        lualine_a = { { 'mode', fmt = function(str) return str:sub(1,1) end } },
        lualine_b = { 'branch', 'diff' },
        lualine_c = { 'filename' },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
    },
})

-- Прозрачность для Lualine
vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "none" })

-----------------------------------------------------------
-- 📁 NvimTree
-----------------------------------------------------------
require("nvim-tree").setup({
    view = {
        side = "left",
        width = 30,
    },
    renderer = {
        highlight_git = true,
        icons = {
            show = {
                git = true,
                folder = true,
                file = true,
            },
        },
    },
})

-- Прозрачность для NvimTree
vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "none" })
vim.api.nvim_set_hl(0, "NvimTreeEndOfBuffer", { bg = "none" })

-----------------------------------------------------------
-- 🔍 Telescope
-----------------------------------------------------------
require("telescope").setup({
    defaults = {
        -- Прозрачность для Telescope
        borderchars = { " ", " ", " ", " ", " ", " ", " ", " " }, -- Убираем границы
    },
})

-- Прозрачность для Telescope
vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "none" })

-----------------------------------------------------------
-- 🔧 Autopairs
-----------------------------------------------------------
require("nvim-autopairs").setup()

-----------------------------------------------------------
-- 🌐 LSP (без Mason)
-----------------------------------------------------------
local lspconfig = require("lspconfig")

-- Lua
lspconfig.lua_ls.setup({
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" }
            }
        }
    }
})

-- TypeScript / JavaScript
lspconfig.ts_ls.setup({})

-- Python
lspconfig.pyright.setup({})

-----------------------------------------------------------
-- 🤖 Completion
-----------------------------------------------------------
local cmp = require("cmp")

cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
    }),
    sources = {
        { name = "nvim_lsp" },
    },
    window = {
        completion = cmp.config.window.bordered({ border = "none" }), -- Убираем границы
        documentation = cmp.config.window.bordered({ border = "none" }),
    },
})

-- Прозрачность для автодополнения
 vim.api.nvim_set_hl(0, "CmpNormal", { bg = "none" })
