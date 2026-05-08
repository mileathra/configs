return {
    src = 'https://github.com/stevearc/oil.nvim',
    dependencies = { { src = "https://github.com/nvim-mini/mini.icons" } },

    setup = function()
        require("oil").setup()
    end
}
