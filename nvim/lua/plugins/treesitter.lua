return {
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
    version = 'master',
    setup = function()
        require("nvim-treesitter").setup({
            install_dir = vim.fn.stdpath('data') .. '/site'
        })
    end,
}
