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
set completeopt=menu,noinsert,noselect

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
" floatterm
"
let g:floaterm_width = 0.8
nmap <leader>a :FloatermToggle<CR>
tnoremap <silent> <leader>a  <C-\><C-n>:FloatermToggle<CR>
tnoremap <Esc> <C-\><C-n>


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
" Telescope
"
" Find files using Telescope command-line sugar.
nnoremap <space>p <cmd>Telescope find_files<cr>
" nnoremap <leader>f <cmd>Telescope file_browser<cr>
nnoremap <space>g   <cmd>Telescope live_grep<cr>
nnoremap <leader>gs <cmd>Telescope git_status<cr>
nnoremap <leader>gc <cmd>Telescope git_commits<cr>
nnoremap <leader>gb <cmd>Telescope git_branches<cr>
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


"
" extra maps
"
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

" highlight hieracy
function! SynGroup()
    let l:s = synID(line('.'), col('.'), 1)
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun


" Vimrc pointers
command -nargs=0 Vimrc :execute "edit! $HOME/.config/nixpkgs/home/program/neovim/init.vim"
command -nargs=0 VimLua :execute "edit! $HOME/.config/nixpkgs/home/program/neovim/lua/main.lua"
command -nargs=0 VimLuaScripts :execute "edit! $HOME/.config/nixpkgs/home/program/neovim/lua"

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
  autocmd FileType markdown set conceallevel=0
  autocmd FileType org set conceallevel=0
augroup end


"
" Haskell
"
augroup hslangs
    autocmd! hslangs


    autocmd Filetype haskell ino <localleader>nt2 newtype _M a = _M {un_M :: _ (_ (_ IO)) a} deriving (Functor, Applicative, Monad, MonadIO, MonadReader _r , MonadWriter _w)
    " haskell
    autocmd FileType haskell,purescript set shiftwidth=2 tabstop=2

    " base
    autocmd Filetype haskell,purescript ino <localleader>rb >>= (\_ -> _)
    autocmd Filetype haskell,purescript ino <localleader>rb' >>= (pure . _)
    autocmd Filetype haskell,purescript ino <localleader>lb (\_ -> _) =<<
    autocmd Filetype haskell,purescript ino <localleader>lb' (pure . _) =<<
    autocmd Filetype haskell,purescript ino <localleader>for forM _ $ do
    autocmd Filetype haskell,purescript ino <localleader>ap _f <$> _a <*> _b
    autocmd Filetype haskell,purescript ino <localleader>ap2 _f <$> _a <*> _b
    autocmd Filetype haskell,purescript ino <localleader>l lift
    autocmd Filetype haskell,purescript ino <localleader>l2 lift . lift
    autocmd Filetype haskell,purescript ino <localleader>t2 (_, _)
    autocmd Filetype haskell,purescript ino <localleader>t3 (_, _, _)
    autocmd Filetype haskell,purescript ino <localleader>_2 _ _
    autocmd Filetype haskell,purescript ino <localleader>_3 _ _ _
    autocmd Filetype haskell,purescript ino <localleader>ev {- $> <cr> <$ -}

    " newtype mtl
    autocmd Filetype haskell ino <localleader>nt newtype _M a = _M {un_M :: _ a} deriving (Functor, Applicative, Monad, MonadIO, MonadReader _r , MonadWriter _w)
    autocmd Filetype haskell ino <localleader>nt1 newtype _M a = _M {un_M :: _ (_ IO) a} deriving (Functor, Applicative, Monad, MonadIO, MonadReader _r , MonadWriter _w)
    autocmd Filetype haskell ino <localleader>nt2 newtype _M a = _M {un_M :: _ (_ (_ IO)) a} deriving (Functor, Applicative, Monad, MonadIO, MonadReader _r , MonadWriter _w)

    " exception
    autocmd Filetype haskell ino <localleader>c (\_ -> _) `catch` \(e :: SomeException) -> _
    autocmd Filetype haskell ino <localleader>cs (\_ -> _) `catches` [Handler _1, Handler _2]

    " lens
    autocmd Filetype haskell,purescript ino <localleader>vi ^.
    autocmd Filetype haskell,purescript ino <localleader>se .~
    autocmd Filetype haskell,purescript ino <localleader>ov %~
    autocmd Filetype haskell,purescript ino <localleader>pvi ^?
    autocmd Filetype haskell,purescript ino <localleader>pse ?~

    " lens stateful
    autocmd Filetype haskell,purescript ino <localleader>sse .=
    autocmd Filetype haskell,purescript ino <localleader>sov %=

    autocmd Filetype haskell ino <localleader>tr trace (": " ++ show _) $
    autocmd Filetype haskell ino <localleader>tm traceM (": " ++ show _)

    " comment
    autocmd Filetype haskell,purescript ino <localleader>@@ {-@ @-}<left><left><left>

    let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
    let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
    let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
    let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
    let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
    let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
    let g:haskell_backpack = 1                " to enable highlighting of backpack keywords
    let g:haskell_classic_highlighting = 1
    let g:haskell_trace_highlight_on = 0

    " highlight trace command
    function! HighlightTrace()
      if g:haskell_trace_highlight_on
        " sy keyword haskellTrace trace
        hi link haskellTrace cleared
        let g:haskell_trace_highlight_on = 0
      else
        sy keyword haskellTrace trace traceId traceShow traceStack traceIO traceM traceShowM traceEvent traceEventIO traceMarker traceMarkerIO
        hi link haskellTrace Operator
        let g:haskell_trace_highlight_on = 1
      endif
    endfunction

    autocmd Filetype haskell nnoremap <silent> <buffer> T :call HighlightTrace() <CR>

augroup end


"
" APL
"
augroup apllang
  au! apllang
  let g:apl_prefix_key = '<M-a>'
  au! BufRead,BufNewFile *.aplf,*aplc,*apln       setfiletype apl
augroup end


"
" latex
"
augroup texconfig
    autocmd! texconfig
    autocmd FileType tex nnoremap <leader>cp :!xelatex %<CR>
    autocmd FileType tex command -nargs=0 LatexCompile :!xelatex %
    autocmd FileType tex nnoremap j gj
    autocmd FileType tex nnoremap k gk
    autocmd FileType tex set linebreak

    autocmd FileType plaintex set filetype=tex
    autocmd FileType tex nnoremap <F5> :setlocal spell! spelllang=en_us<CR>

    let g:tex_flavor='latex'
    let g:vimtex_view_method='zathura'
    let g:vimtex_quickfix_mode=0

    autocmd FileType tex set conceallevel=0
    let g:tex_conceal='abdmg'
    let g:vimtex_compiler_progname = 'nvr'
    "let g:vimtex_latexmk_continuous=1
    let g:vimtex_compiler_latexmk = {'callback' : 0}
    nnoremap <leader>ll :VimtexCompile<CR>
    nnoremap <leader>li :VimtexInfo
    nnoremap <leader>lv :VimtexView<CR>
    nnoremap <Leader>lc :VimtexClean
augroup end


"
" CSS
"
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS noci
inoremap <leader>, <C-x><C-o>

nnoremap <leader>rp :RainbowParenthesesToggle<CR>
function EnableRainbowParenthese()
    :RainbowParenthesesLoadRound
    :RainbowParenthesesActivate
endfunction

"
" markdown
"
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

"
" Automatically remove trailing space
"
autocmd BufWritePre * :%s/\s\+$//e
