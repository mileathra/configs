return {
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
    version = 'master',
    setup = function()
        require("nvim-treesitter").setup({
            install_dir = vim.fn.stdpath('data') .. '/site'
        })

        vim.api.nvim_create_autocmd('FileType', {
            pattern = { 'lua', 'c', 'go', 'rust' },
            callback = function() vim.treesitter.start() end,
        })
    end,
}
