""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" NerdTree
"
nnoremap <C-e> :NERDTreeToggle<CR>
let NERDTreeRespectWildIgnore=1
let g:NERDTreeWinSize = 30

nnoremap <leader>Nf <cmd>NERDTreeFind<cr>
nnoremap <leader>Nr <cmd>NERDTreeRefreshRoot<cr>
nnoremap <leader>Nc <cmd>NERDTreeCWD <cr>

"
" ultisnips
"
let g:UltiSnipsExpandTrigger="<c-j>"

"
"ctags setting
"
set tags=./.tags;,.tags
let c_no_curly_error=1

"
" fzf
"
let g:fzf_colors =
            \ { 'fg':      ['fg', 'Normal'],
            \ 'bg':      ['bg', 'Normal'],
            \ 'hl':      ['fg', 'Comment'],
            \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
            \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
            \ 'hl+':     ['fg', 'Statement'],
            \ 'info':    ['fg', 'PreProc'],
            \ 'border':  ['fg', 'Ignore'],
            \ 'prompt':  ['fg', 'Conditional'],
            \ 'pointer': ['fg', 'Exception'],
            \ 'marker':  ['fg', 'Keyword'],
            \ 'spinner': ['fg', 'Label'],
            \ 'header':  ['fg', 'Comment'] }

"
" AsyncRun
"
let g:asyncrun_open = 12

"
" floatterm
"
let g:floaterm_width = 0.8
let g:floaterm_wdith = 0.8
nmap <C-n> :FloatermToggle<CR>
nmap <localleader>0 :FloatermNew<CR>
nmap <localleader>9 :FloatermSend<space>

"
" Vista
"
nmap <leader>V :Vista<CR>
let g:vista_icon_indent = ["|->", "─>"]
let g:vista_default_executive = 'coc'
let g:vista#renderer#enable_icon = 0


"
" vim-slime
"
let g:slime_python_ipython = 1
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": ":0.1"}
let g:slime_paste_file = "$HOME/.slime_paste"
let g:slime_no_mappings = 1
nmap <Plug>NoSlimeParagraphSend <Plug>SlimeParagraphSend
xmap <localleader>2 <Plug>SlimeRegionSend
nmap <localleader>2 <Plug>SlimeParagraphSend
nmap <localleader>@ :%SlimeSend<CR>

"
" Indent guide
"
let g:indent_guides_enable_on_vim_startup = 0
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=255
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=none
nnoremap <leader>ig :IndentGuidesToggle<CR>


"
" Telescope
"
" Find files using Telescope command-line sugar.
nnoremap <C-p> <cmd>Telescope find_files<cr>
" nnoremap <leader>f <cmd>Telescope file_browser<cr>
nnoremap <space>g <cmd>Telescope live_grep<cr>
nnoremap <leader>B <cmd>Telescope buffers<cr>
nnoremap <leader>H <cmd>Telescope help_tags<cr>
nnoremap <leader>M <cmd>Telescope marks<cr>
nnoremap <leader>R <cmd>Telescope registers<cr>
nnoremap <leader>D <cmd>Telescope lsp_document_symbols<cr>
nnoremap <leader>A <cmd>Telescope lsp_code_actions<cr>

"
" auto-session
"
nnoremap <leader>SS <cmd>SearchSession<cr>
nnoremap <leader>SV <cmd>SaveSession<cr>
nnoremap <leader>SR <cmd>RestoreSession<cr>
nnoremap <leader>SD <cmd>DeleteSession<cr>
nnoremap <leader>Nt <cmd>NERDTree<cr>


nmap # <nop>
nnoremap # <cmd>Telescope grep_string<cr>


"
" Slimv
"
let g:slimv_ctags = "ctags"
let g:slimv_disable_scheme = 0
let g:slimv_indent_disable = 1

"
" Scratch
"
nnoremap <leader>sc <cmd>Scratch<cr>
vnoremap <leader>sc <cmd>ScratchSelection<cr>

"
" System copy
"

let g:system_copy#copy_command='xclip -sel clibpoard'
let g:system_copy#paste_command='xclip -sel clibpoard -o'

"
" System copy
"
let g:goyo_width = 150
let g:goyo_height = 150

" " for writing
" nnoremap <space>P :Goyo 100<cr>

" " for quickfix
" nnoremap <space>p :Goyo <cr>
