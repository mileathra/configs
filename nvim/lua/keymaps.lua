vim.g.mapleader = " "

vim.keymap.set("n", "<leader>cs", "<cmd>nohlsearch<CR>")

local on_jump = function(_, bufnr)
    vim.diagnostic.open_float({
        bufnr = bufnr,
        scope = 'cursor',
        focus = false,
    })
end

vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1, on_jump = on_jump }) end)
vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1, on_jump = on_jump }) end)

vim.keymap.set("n", "<C-h>", "<C-w><C-h>")
vim.keymap.set("n", "<C-l>", "<C-w><C-l>")
vim.keymap.set("n", "<C-j>", "<C-w><C-j>")
vim.keymap.set("n", "<C-k>", "<C-w><C-k>")

vim.keymap.set("n", "<C-w>", "<C-w>w")

vim.cmd([[cnoreabbrev wq; wq]])
vim.cmd([[cnoreabbrev w; w]])
