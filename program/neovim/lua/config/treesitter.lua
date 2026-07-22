-- =============================================================================
-- MAIN TREE-SITTER INITIALIZATION & AUTOMATIC PARSER INSTALLATION
-- =============================================================================

-- Safely initialize the plugin runtime
local status_ts, ts = pcall(require, 'nvim-treesitter')
if status_ts then
    ts.setup({
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        }
    })

    -- Core alternative to 'ensure_installed': Diff and install missing parsers
    local required_parsers = {
        "haskell", "c", "lua", "vim", "query", "markdown",
        "markdown_inline", "yaml", "nix", "toml", "html", "rust", "python",
        "javascript", "typescript", "ocaml", "lean", "bash", "fish", "css",
    }

    local status_config, ts_config = pcall(require, 'nvim-treesitter.config')
    if status_config then
        local installed_parsers = ts_config.get_installed()
        local to_install = {}

        for _, parser in ipairs(required_parsers) do
            if not vim.tbl_contains(installed_parsers, parser) then
                table.insert(to_install, parser)
            end
        end

        if #to_install > 0 then
            -- Safely trigger parser generation without hard-crashing
            pcall(ts.install, to_install)
        end
    end
end


vim.cmd("syntax enable")

vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
        if vim.bo[args.buf].buftype ~= "" then return end

        local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
        if not lang then return end

        local ok = pcall(vim.treesitter.language.add, lang)
        if ok then
            -- capture the error if we don't have the parser.
            pcall(vim.treesitter.start, args.buf, lang)
        end
    end,
})


-- =============================================================================
-- NATIVE INCREMENTAL SELECTION KEYMAPS
-- =============================================================================

-- Core alternative mapping to the legacy incremental_selection configuration block
vim.keymap.set("n", "<c-space>", function()
    local ok, inc = pcall(require, 'nvim-treesitter.incremental_selection')
    if ok then inc.init_selection() end
end, { desc = "TS Init Selection" })

vim.keymap.set("x", "<c-space>", function()
    local ok, inc = pcall(require, 'nvim-treesitter.incremental_selection')
    if ok then inc.node_incremental() end
end, { desc = "TS Increment Selection" })


-- =============================================================================
-- TREESITTER TEXTOBJECTS SETUP
-- =============================================================================

-- Configured inside its own isolated, standalone module namespace
local status_to, to = pcall(require, 'nvim-treesitter-textobjects')
if status_to then
    to.setup({
        select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to matching text objects
            keymaps = {
                ['aa'] = '@parameter.outer',
                ['ia'] = '@parameter.inner',
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',
                ['ab'] = '@block.outer',
                ['ib'] = '@block.inner',
            },
        },
    })
end
