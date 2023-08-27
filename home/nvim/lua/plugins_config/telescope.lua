local ok, _ = pcall(require, "telescope")
if ok then
    _.setup()
end

if not ok then
    return
end

local map = vim.keymap.set
local ts = require('telescope.builtin')

-- map('n', "<leader>tt", ts.builin, opts)
map('n', "<leader>ff", ts.find_files, opts)
map('n', "<leader>ff", ts.find_files, opts)
map('n', "<leader>fb", ts.buffers, opts)
map('n', "<leader>lg", ts.live_grep, opts)
map('n', "<leader>ds", ts.lsp_document_symbols, opts)
map('n', "<leader>ws", ts.lsp_workspace_symbols, opts)
map('n', "<leader>td", ts.diagnostics, opts)
