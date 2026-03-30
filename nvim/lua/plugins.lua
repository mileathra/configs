local plugins = {
    { name = "everforest",  enabled = true, description = "colorscheme" },
    { name = "treesitter",  enabled = true, description = "syntax highlighting" },
    { name = "transparent", enabled = true, description = "makes the background transparent" },
    { name = "telescope",   enabled = true, description = "navigate between and within buffers" },
    { name = "nvim_cmp",    enabled = true, description = "completions" },
    { name = "conform",     enabled = true, description = "format-on-save" },
}

local enabled = {}
local deps = {}
for _, plugin in ipairs(plugins) do
    if not plugin.enabled then
        goto continue
    end

    local source = require("plugins/" .. plugin.name)
    table.insert(enabled, source)

    if source.dependencies then
        for _, dep in ipairs(source.dependencies) do
            table.insert(deps, dep)
        end
    end
    ::continue::
end

local load_plugins = function(plugin_table)
    vim.pack.add(plugin_table)
    for _, plugin in ipairs(plugin_table) do
        if plugin.setup then
            plugin.setup()
        end
    end
end

load_plugins(deps)
load_plugins(enabled)
