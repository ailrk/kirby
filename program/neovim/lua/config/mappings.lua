local function trim(s) return s:match '^%s*(.*%S)' or '' end

local function make_maps(mode, config)
    return function(maps)
        for _, v in ipairs(maps) do
            local from, to = unpack(v)
            vim.api.nvim_set_keymap(mode, trim(from), trim(to), config)
        end
    end
end

local normal_maps = make_maps('n', {noremap = true, silent = true})
local local_maps = make_maps('i', {noremap = true, silent = true})

-- general inop maps
local_maps {
    -- strings are trimed
    {[[ "         ]], [[ ""<left>      ]]},
    {[[ {         ]], [[ {}<left>      ]]},
    {[[ (         ]], [[ ()<left>      ]]},
    {[[ [         ]], [[ []<left>      ]]},
    {[[ {<CR>     ]], [[ {<CR>}<ESC>O  ]]},
    {[[ {;<CR>    ]], [[ {<CR>};<ESC>O ]]},
    {[[ <leader>L ]], [[ λ             ]]},
}


-- general inop maps
normal_maps {
    -- line number
    {[[ <leader>N  ]], [[ :set number!           ]]}, -- easy to config
    {[[ <leader>ev ]], [[ :split $MYVIMRC<cr>    ]]},
    {[[ <leader>sv ]], [[ :source $MYVIMRC<cr>   ]]}, -- coc.nvim extension
    {[[ <leader>fm ]], [[ :Format<cr>            ]]},

    -- remove trailing empty line
    {[[ <leader>rt ]], [[ :RemoveTrailing<cr>    ]]},
    {[[ <C-t>      ]], [[ :tabnew<cr>       ]]},
    {[[ <C-h>     ]],  [[ gT         ]]},
    {[[ <C-l>     ]],  [[ gt         ]]},
}
