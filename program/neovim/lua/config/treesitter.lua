-- =============================================================================
-- TREE-SITTER (main branch)
-- =============================================================================
local required_parsers = {
    "haskell", "c", "lua", "vim", "vimdoc", "query", "markdown",
    "markdown_inline", "yaml", "nix", "toml", "html", "rust", "python",
    "javascript", "typescript", "ocaml", "bash", "fish", "css", "java", "perl",
}

local ok_ts, ts = pcall(require, 'nvim-treesitter')
if ok_ts then
    ts.setup{}
    ts.install(required_parsers)
end


local indent_blacklist = {
    haskell = true,
    -- python = true,
    -- nix = true,
}

vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
        if vim.bo[args.buf].buftype ~= "" then return end
        local ft = vim.bo[args.buf].filetype
        local lang = vim.treesitter.language.get_lang(ft)
        if not lang then return end
        if pcall(vim.treesitter.start, args.buf, lang) then
            if not indent_blacklist[ft] and vim.treesitter.query.get(lang, "indents") then
                vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end
        end
    end,
})
