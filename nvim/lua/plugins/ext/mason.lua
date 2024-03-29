return {
    {
        "williamboman/mason.nvim",
        version = "*",
        config = function()
            require("mason").setup()
        end,
        priority = 1000 -- load and init this before anything else
    },
    {
        "williamboman/mason-lspconfig.nvim",
        version = "*",
        config = function()
            require("mason-lspconfig").setup({
                automatic_installation = true
            })

            require("mason-lspconfig").setup_handlers({
                -- The first entry (without a key) will be the default handler
                -- and will be called for each installed server that doesn't have
                -- a dedicated handler.
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {}
                end,
                -- Next, you can provide a dedicated handler for specific servers.
                -- For example, a handler override for the `rust_analyzer`:
                -- ["rust_analyzer"] = function ()
                --     require("rust-tools").setup {}
                -- end
            })
        end,
        priority = 999 -- and this after mason
    }
}
