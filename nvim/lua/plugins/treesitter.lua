return {
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
    version = 'master',
    setup = function()
        require("nvim-treesitter").setup({
            install_dir = vim.fn.stdpath('data') .. '/site'
        })

        local yaw_root = vim.env.YW_PARSER_PATH
        if yaw_root and vim.fn.isdirectory(yaw_root) == 1 then
            vim.filetype.add({ extension = { yw = "yaw" } })

            pcall(vim.treesitter.language.add, "yaw", {
                path = yaw_root .. "/yaw.so",
            })

            local highlights = yaw_root .. "/queries/highlights.scm"
            if vim.fn.filereadable(highlights) == 1 then
                vim.treesitter.query.set(
                    "yaw",
                    "highlights",
                    table.concat(vim.fn.readfile(highlights), "\n")
                )
            end
        end

        vim.api.nvim_create_autocmd('FileType', {
            pattern = { 'lua', 'c', 'go', 'rust', 'yaw' },
            callback = function() vim.treesitter.start() end,
        })
    end,
}
