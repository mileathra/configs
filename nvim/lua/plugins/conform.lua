return {
    src = "https://github.com/stevearc/conform.nvim",
    lazy = false,
    setup = function()
        require("conform").setup({
            notify_on_error = false,
            format_on_save = function(bufnr)
                local disable_filetypes = { sql = true }
                return {
                    timeout_ms = 500,
                    lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
                }
            end,
            formatters_by_ft = {
                lua = { "stylua" },
                json = { "prettier" },
                jsonc = { "prettier" },
                php = { "prettier" },
                html = { "prettier" },
                markdown = { "prettier" },
                yaml = { "prettierv2" },
                javascript = { "prettier" },
                typescript = { "prettier" },
                python = { "black" },
                css = { "prettier" },
                templ = { "templ" },
            },
        })
    end
}
