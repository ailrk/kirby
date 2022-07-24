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
"set term=xterm-256color
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

" Right Click Context Menu (Copy-Cut-Paste)
nnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
inoremap <silent><RightMouse> <Esc>:call GuiShowContextMenu()<CR>
xnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>gv
snoremap <silent><RightMouse> <C-G>:call GuiShowContextMenu()<CR>gv

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
