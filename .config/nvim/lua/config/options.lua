-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- Left column and similar settings
vim.opt.number = true         -- display line numbers
vim.opt.relativenumber = true -- display relative line numbers
vim.opt.numberwidth = 2       -- set width of line number column
vim.opt.signcolumn = "yes"    -- always show sign column
vim.opt.wrap = false          -- display lines as single line
vim.opt.scrolloff = 10        -- number of lines to keep above/below cursor
vim.opt.sidescrolloff = 8     -- number of columns to keep to the left/right of cursor

-- Tab spacing/behavior
vim.opt.expandtab = true   -- convert tabs to spaces
vim.opt.shiftwidth = 2     -- number of spaces inserted for each indentation level
vim.opt.tabstop = 2        -- number of spaces inserted for tab character
vim.opt.softtabstop = 2    -- number of spaces inserted for <Tab> key
vim.opt.smartindent = true -- enable smart indentation
vim.opt.breakindent = true -- enable line breaking indentation

-- Gutter: visualizar tabs reales y espacios sobrantes
vim.opt.list = true
vim.opt.listchars = {
  tab      = "▸ ",
  trail    = "·",
  extends  = "›",
  precedes = "‹",
  nbsp     = "·",
}

-- Indentación por tipo de archivo
vim.cmd("filetype plugin indent on")

local set_indent = function(size)
  return function()
    vim.opt_local.tabstop     = size
    vim.opt_local.shiftwidth  = size
    vim.opt_local.softtabstop = size
    vim.opt_local.expandtab   = true
  end
end

vim.api.nvim_create_autocmd("FileType", {
  pattern  = {
    "html", "css", "scss", "javascript", "javascriptreact",
    "typescript", "typescriptreact", "json", "jsonc",
    "yaml", "lua", "vue", "svelte", "markdown",
  },
  callback = set_indent(2),
})

vim.api.nvim_create_autocmd("FileType", {
  pattern  = { "python", "rust", "go", "java", "c", "cpp" },
  callback = set_indent(4),
})

-- General Behaviors
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.backup = false            -- disable backup file creation
vim.opt.clipboard = "unnamedplus" -- enable system clipboard access
vim.opt.conceallevel = 0          -- so that `` is visible in markdown files
vim.opt.fileencoding = "utf-8"    -- set file encoding to UTF-8
vim.opt.mouse = "a"               -- enable mouse support
vim.opt.showmode = false          -- hide mode display
vim.opt.splitbelow = true         -- force horizontal splits below current window
vim.opt.splitright = true         -- force vertical splits right of current window
vim.opt.termguicolors = true      -- enable term GUI colors
vim.opt.timeoutlen = 1000         -- set timeout for mapped sequences
vim.opt.undofile = true           -- enable persistent undo
vim.opt.updatetime = 100          -- set faster completion
vim.opt.writebackup = false       -- prevent editing of files being edited elsewhere
vim.opt.cursorline = true         -- highlight current line
vim.opt.autoread = true  -- reload file if changed on disk

-- Searching Behaviors
vim.opt.hlsearch = true   -- highlight all matches in search
vim.opt.ignorecase = true -- ignore case in search
vim.opt.smartcase = true  -- match case if explicitly stated

-- ── Atajos de teclado ─────────────────────────────────
local map = vim.keymap.set

map("n", "<Esc>", "<cmd>nohlsearch<CR>")  -- limpiar búsqueda
map("v", "<", "<gv")                       -- indentar sin perder selección
map("v", ">", ">gv")
map("v", "J", ":m '>+1<CR>gv=gv")        -- mover líneas seleccionadas
map("v", "K", ":m '<-2<CR>gv=gv")

