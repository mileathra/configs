return {
    src = "https://github.com/nvim-telescope/telescope.nvim",
    event = "VimEnter",
    dependencies = {
        { src = "https://github.com/nvim-lua/plenary.nvim" },
        { src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
    },
    setup = function()
        local telescope = require("telescope")
        local layout_actions = require("telescope.actions.layout")
        local themes = require("telescope.themes")

        telescope.setup({
            defaults = {
                preview = {
                    treesitter = true,
                },
                mappings = {
                    i = {
                        ["<C-y>"] = layout_actions.toggle_preview,
                    },
                },
            },
            extensions = {
                ["ui-select"] = themes.get_dropdown(),
            },
        })

        telescope.load_extension("ui-select")

        local builtin = require("telescope.builtin")

        local map = vim.keymap.set
        map("n", "<leader>ff", builtin.find_files)
        map("n", "<leader>sw", builtin.grep_string)
        map("n", "<leader>fs", builtin.live_grep)
        map("n", "<leader>sd", builtin.diagnostics)
        map("n", "<leader>sr", builtin.resume)
        map("n", "<leader>s.", builtin.oldfiles)
        map("n", "<leader><leader>", builtin.buffers)

        map("n", "<leader>/", function()
            builtin.current_buffer_fuzzy_find(themes.get_dropdown({
                winblend = 10,
                previewer = false,
            }))
        end)

        map("n", "<leader>s/", function()
            builtin.live_grep({
                grep_open_files = true,
                prompt_title = "Live Grep in Open Files",
            })
        end)
    end,
}
