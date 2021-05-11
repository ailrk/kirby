local api = vim.api

local M = {}

function M.makeScratch()
    api.nvim_command('enew')
    vim.bo[0].buftype=nofile
    vim.bo[0].bufhidden=hide
end

return M
