
local map = vim.keymap.set
local opts = {}

-- Fugitive Maps
map('n', "<leader>gg", ":Git<CR>", opts)
map('n', "<leader>gb", ":Git blame<CR>", opts)
map('n', "<leader>gl", ":Git log<CR>", opts)
map('n', "<leader>gp", ":Git pull<CR>", opts)
map('n', "<leader>gP", ":Git push<CR>", opts)
map('n', "<leader>gF", ":Git fetch<CR>", opts)

require('gitsigns').setup{
    numhl = true,
    -- word_diff = true,
    current_line_blame = true,
}
