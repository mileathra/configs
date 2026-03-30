local lsps = {
    { name = "lua_ls",        enabled = true },
    { name = "rust_analyzer", enabled = true },
    { name = "gopls",         enabled = true },
}

for _, lsp in ipairs(lsps) do
    if not lsp.enabled then
        goto continue
    end
    vim.lsp.enable(lsp.name)

    ::continue::
end

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(event)
        local map = function(keys, func)
            vim.keymap.set("n", keys, func, { buffer = event.buf })
        end

        local ok, builtin = pcall(require, "telescope.builtin")
        if ok then
            map("gd", builtin.lsp_definitions)
            map("gr", builtin.lsp_references)
            map("gI", builtin.lsp_implementations)
            map("<leader>D", builtin.lsp_type_definitions)
        end
        map("gD", vim.lsp.buf.declaration)
        map("<leader>rn", vim.lsp.buf.rename)
        map("<leader>ca", vim.lsp.buf.code_action)
        map("K", vim.lsp.buf.hover)

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                buffer = event.buf,
                callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                buffer = event.buf,
                callback = vim.lsp.buf.clear_references,
            })
        end

        if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
            map("<leader>th", function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            end)
        end
    end,
})
