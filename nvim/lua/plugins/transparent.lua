return {
    src = "https://github.com/xiyaowong/transparent.nvim",
    setup = function()
        require("transparent").setup({
            extra_groups = {
                "Normal",
                "NormalFloat",
            },
        })
    end
}
