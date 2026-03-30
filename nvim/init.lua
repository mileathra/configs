local modules = { "opts", "keymaps", "lsp", "plugins" }

for _, module in ipairs(modules) do
    require(module)
end
