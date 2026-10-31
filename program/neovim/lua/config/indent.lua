-- Fix haskell indent line in the middle of a block
function _G.HaskellIndent()
    local lnum = vim.v.lnum
    if vim.fn.getline(lnum):match("^%s*$") and vim.fn.getline(lnum - 1):match("^%s*$") then
        local nxt = vim.fn.nextnonblank(lnum + 1)
        if nxt > 0 then return vim.fn.indent(nxt) end
        local prev = vim.fn.prevnonblank(lnum - 1)
        if prev > 0 then return vim.fn.indent(prev) end
    end
    return vim.fn.GetHaskellIndent()
end

vim.api.nvim_create_autocmd("FileType", {
    pattern = "haskell",
    callback = function(args)
        vim.bo[args.buf].indentexpr = "v:lua.HaskellIndent()"
    end,
})
