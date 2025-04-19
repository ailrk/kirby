" lua require("init")

lua require'main'

" set the runtime path to include Vundle and initialize set rtp+=~/.vim/autoload/plug.vim
set encoding=utf-8
set fileencoding=utf-8
" leader key
let mapleader=","

" independent setting
""syntax off
set display+=lastline               "show all wrapped lines.
set tabstop=4
set shiftwidth=4
set expandtab
set smartindent
set cmdheight=2
set shell=fish
set t_Co=256
set splitbelow
set splitright
set scrolloff=5
"set colorcolumn=80
set cursorline
set signcolumn=yes
set hlsearch                        "gutter
set ruler
set backspace=indent,eol,start      "fix backspace
set laststatus=2                    "statusline
set statusline=%f%=%y\ \@%l,\ total:\ \%L,\ In:\ \%p%%
set matchpairs+=<:>
set exrc                            "local setting
set number
set mouse=a



" Set Editor Font
if exists('g:GuiFont')
    " Use GuiFont! to ignore font errors
    let g:GuiFont="Everson Mono:h16"
endif

" Disable GUI Tabline
if exists('g:GuiTabline')
    let g:GuiTabline=0
endif

" Disable GUI Popupmenu
if exists('g:GuiPopupmenu')
    let g:GuiPopupmenu=0
endif

" Enable GUI ScrollBar
if exists('g:GuiScrollBar')
    let g:GuiScrollBar=1
endif

" ignore binaries
set wildignore+=*.pyc,*.o,*.obj,*.svn,*.swp,*.class,*.hg,*.DS_Store,*.min.*,*.fasl,*.bci,*.bin,*.com,*.hi,*.cmo,*.cmi,*.agdai

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c
set completeopt=menu,menuone,noinsert,noselect

"
" NerdTree
"
nnoremap <C-e> :NERDTreeToggle<CR>
let NERDTreeRespectWildIgnore=1
let g:NERDTreeWinSize = 30
nnoremap <space>n  <cmd>NERDTreeFind<cr>

"
" ultisnips
"
let g:UltiSnipsExpandTrigger="<c-j>"


" floatterm
"
let g:floaterm_width = 0.8
nmap <leader>a :FloatermToggle<CR>
tnoremap <silent> <leader>a  <C-\><C-n>:FloatermToggle<CR>
tnoremap <Esc> <C-\><C-n>


"
" Telescope
"
" Find files using Telescope command-line sugar.
nnoremap <space>p <cmd>Telescope find_files<cr>
" nnoremap <leader>f <cmd>Telescope file_browser<cr>
nnoremap <space>g   <cmd>Telescope live_grep<cr>
nnoremap <space>d   <cmd>Telescope diagnostics<cr>
nnoremap <space>h   <cmd>Telescope oldfiles<cr>
nnoremap <space>t   <cmd>Telescope<cr>
nnoremap <leader>c  <cmd>Telescope commands<cr>
nnoremap <leader>B  <cmd>Telescope buffers<cr>
nnoremap <leader>H  <cmd>Telescope help_tags<cr>
nnoremap <leader>M  <cmd>Telescope marks<cr>
nnoremap <leader>R  <cmd>Telescope registers<cr>
nnoremap <leader>D  <cmd>Telescope lsp_document_symbols<cr>
nnoremap <leader>T  <cmd>Telescope lsp_dynamic_workspace_symbols<cr>
nnoremap <space>s   <cmd>SessionSearch<cr>
nnoremap <C-s>      <cmd>SessionSave<cr>


nmap # <nop>
nnoremap # <cmd>Telescope grep_string<cr>


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


" highlight hieracy
function! SynGroup()
    let l:s = synID(line('.'), col('.'), 1)
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun

" check current syntax group
command -nargs=0 SynCheckGroup :call SynGroup()<cr>

colorscheme vim-monochrome-waifu
" colorscheme off

set background=dark

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntax Modification


"
" gutter
"
hi SignColumn ctermbg=none ctermfg=none
hi SyntasticErrorSign ctermbg=none  ctermfg=3
hi SyntasticWarningSign ctermbg=none ctermfg=3
hi htmlBold ctermbg=none ctermfg=none
hi ColorColumn ctermbg=white

"
" hight search
"
hi Search ctermfg=232 ctermbg=243
"hi CursorLine cterm=none ctermbg=252
hi Visual ctermfg=255 ctermbg=250
hi CursorLineNr  cterm=none ctermfg=none gui=none guifg=none

"
" trivial stuffs.
"
hi htmlUnderline ctermbg=none ctermfg=none
hi htmlUnderlineItalic ctermbg=none ctermfg=none
hi Vertsplit cterm=none

"
"
" Telescope
"
hi link TelescopePreviewLine Search
hi link TelescopeSelection Search

"
" nvim LSP
"
hi link LspDiagnosticsDefaultHint NonText
hi link LspDiagnosticsDefaultInformation NonText
hi link LspDiagnosticsDefaultWarning NonText
hi link LspDiagnosticsDefaultError ErrorMsg
hi link LspCodeLens NonText

"
" NERDTree
"
hi! link Directory Type

" Never wnat a split bar styling
""hi VerSplit cterm=None

" Transparent background
hi Normal guibg=none ctermbg=none


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autocmd
"

augroup set_shiftwidth
  autocmd! set_shiftwidth
  autocmd FileType javascript set shiftwidth=2 tabstop=2
  autocmd FileType json set shiftwidth=2 tabstop=2
  autocmd FileType koka set shiftwidth=2 tabstop=2
  autocmd FileType typescript set shiftwidth=2 tabstop=2
  autocmd FileType typescriptreact set shiftwidth=2 tabstop=2
  autocmd FileType c set shiftwidth=4 tabstop=4
  autocmd FileType cuda set shiftwidth=4 tabstop=4
  autocmd FileType lua set shiftwidth=2 tabstop=2
  autocmd FileType nix set shiftwidth=2 tabstop=2
  autocmd FileType haskell set shiftwidth=2 tabstop=2
  autocmd FileType just set shiftwidth=2 tabstop=2
  autocmd FileType markdown set conceallevel=0
  autocmd FileType org set conceallevel=0
augroup end


"
" Automatically remove trailing space
"
autocmd BufWritePre * :%s/\s\+$//e
