local vim = vim
local cmd = vim.cmd

vim.g.mapleader = " "

local opt = vim.opt;

opt.clipboard = "unnamedplus" -- Sync with system clipboard
opt.number = true
opt.relativenumber = true

opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4

opt.grepprg = "rg --vimgrep"

opt.laststatus = 3 -- Universal status

-- set winbar item: help, modified, file, quickfix list
-- opt.winbar = [[%h%m%t]]
opt.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
-- opt.winbar = "%!nvim_treesitter#statusline()"

cmd([[ set dir=~/.local/tmp ]])

-- Smartcase for search --
cmd([[set ignorecase smartcase]])

-- Highlight on yank --
cmd([[au TextYankPost * silent! lua vim.highlight.on_yank()]])

-- Automatically safe session if it is a session
-- local function defSession()
--     IsSession = 1
-- end

-- cmd([[autocmd SessionLoadPost * lua defSession()]])
-- cmd([[autocmd ExitPre * if exists("IsSession") && IsSession | mksession! | endif]])

-- Mappings --
local map = vim.keymap.set

-- Reload config --
map('n', "<Leader>vr", ":source $XDG_CONFIG_HOME/nvim/init.lua<CR>", {})

-- Save on Ctrl-s --
map('n', "<C-S>", ":w<CR>", {})

-- Exit terminal mode with ESC
cmd([[tnoremap <Esc> <C-\><C-n>]])


-- Splits & tabs --
cmd([[map <leader>wn :tabnew<CR>:e ./<CR>]])
cmd([[map <leader>wv :vsplit<CR>:e ./<CR>]])

-- Use ctrl-[hjkl] to select the active split! --
cmd([[nmap <silent> <c-h> :wincmd h<CR>]])
cmd([[nmap <silent> <c-j> :wincmd j<CR>]])
cmd([[nmap <silent> <c-k> :wincmd k<CR>]])
cmd([[nmap <silent> <c-l> :wincmd l<CR>]])
cmd([[tnoremap <c-h> <C-\><C-N><C-w>h]])
cmd([[tnoremap <c-j> <C-\><C-N><C-w>j]])
cmd([[tnoremap <c-k> <C-\><C-N><C-w>k]])
cmd([[tnoremap <c-l> <C-\><C-N><C-w>l]])
cmd([[inoremap <c-h> <C-\><C-N><C-w>h]])
cmd([[inoremap <c-j> <C-\><C-N><C-w>j]])
cmd([[inoremap <c-k> <C-\><C-N><C-w>k]])
cmd([[inoremap <c-l> <C-\><C-N><C-w>l]])

-- Use ctrl-[hjkl] to select the active split! --
cmd([[nmap <silent> <c-h> :wincmd h<CR>]])
cmd([[nmap <silent> <c-j> :wincmd j<CR>]])
cmd([[nmap <silent> <c-k> :wincmd k<CR>]])
cmd([[nmap <silent> <c-l> :wincmd l<CR>]])

cmd([[tnoremap <c-h> <C-\><C-N><C-w>h]])
cmd([[tnoremap <c-j> <C-\><C-N><C-w>j]])
cmd([[tnoremap <c-k> <C-\><C-N><C-w>k]])
cmd([[tnoremap <c-l> <C-\><C-N><C-w>l]])
cmd([[inoremap <c-h> <C-\><C-N><C-w>h]])
cmd([[inoremap <c-j> <C-\><C-N><C-w>j]])
cmd([[inoremap <c-k> <C-\><C-N><C-w>k]])
cmd([[inoremap <c-l> <C-\><C-N><C-w>l]])

-- Navigate --
cmd([[noremap <C-A-j> :bnext<CR>]])
cmd([[noremap <C-A-k> :bprevious<CR>]])
cmd([[noremap <C-A-l> :tabnext<CR>]])
cmd([[noremap <C-A-h> :tabprevious<CR>]])

-- Allow gf to follow files that don't exist
cmd([[map gf :edit <cfile><cr>]])
