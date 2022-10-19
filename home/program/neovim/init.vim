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
" AsyncRun
"
let g:asyncrun_open = 12

"
" floatterm
"
let g:floaterm_width = 0.8
let g:floaterm_wdith = 0.8
nmap <C-n> :FloatermToggle<CR>
nmap <localleader>] :FloatermNew<CR>
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

let g:auto_session_pre_save_cmds = ["tabdo NERDTreeClose"]
nnoremap <leader>SS <cmd>SearchSession<cr>
nnoremap <leader>SV <cmd>SaveSession<cr>
nnoremap <leader>SR <cmd>RestoreSession<cr>
nnoremap <leader>SD <cmd>DeleteSession<cr>


nmap # <nop>
nnoremap # <cmd>Telescope grep_string<cr>


"
" renamer
"

nnoremap <silent> <leader>rn <cmd>lua require('renamer').rename()<cr>
vnoremap <silent> <leader>rn <cmd>lua require('renamer').rename()<cr>

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

" colorscheme vim-monochrome-waifu
" colorscheme off
colorscheme macvim-light

set background=light

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntax Modification

"
" Popup menu
"
hi Pmenu ctermbg=254 ctermfg=0
hi PmenuSbar ctermbg=none
hi PmenuThumb ctermbg=none


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
hi CursorLine cterm=none ctermbg=252 
hi Visual ctermfg=255 ctermbg=250
hi CursorLineNr  cterm=none ctermfg=none gui=none guifg=none

"
" trivial stuffs.
"
hi htmlUnderline ctermbg=none ctermfg=none
hi htmlUnderlineItalic ctermbg=none ctermfg=none


"
" Cocnvim
"
hi CocUnderline cterm=none
hi CocErrorHighlight cterm=none
hi CocWarningHighlight cterm=none
hi CocHintHighlight cterm=none
hi CocInfoHighlight cterm=none

"
" ALE info
"
hi ALEError cterm=none
hi ALEWarning cterm=none
hi ALEInfo cterm=none

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

" Never wnat a split bar styling
hi VerSplit cterm=None

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


" autocmd BufWritePre * %s/\s\+$//eg

"
" Haskell
"
augroup hslangs
    autocmd! hslangs


    autocmd Filetype haskell ino <localleader>nt2 newtype _M a = _M {un_M :: _ (_ (_ IO)) a} deriving (Functor, Applicative, Monad, MonadIO, MonadReader _r , MonadWriter _w)
    " haskell
    autocmd FileType haskell,purescript set shiftwidth=2 tabstop=2

    " base
    autocmd Filetype haskell,purescript ino <localleader>f <$>
    autocmd Filetype haskell,purescript ino <localleader>fl <$
    autocmd Filetype haskell,purescript ino <localleader>fr $>
    autocmd Filetype haskell,purescript ino <localleader>f' <&>
    autocmd Filetype haskell,purescript ino <localleader>rb >>= (\_ -> _)
    autocmd Filetype haskell,purescript ino <localleader>rb' >>= (pure . _)
    autocmd Filetype haskell,purescript ino <localleader>lb (\_ -> _) =<<
    autocmd Filetype haskell,purescript ino <localleader>lb' (pure . _) =<<
    autocmd Filetype haskell,purescript ino <localleader>A <*>
    autocmd Filetype haskell,purescript ino <localleader>A' <\|>
    autocmd Filetype haskell,purescript ino <localleader>to2 _a -> _b -> _c
    autocmd Filetype haskell,purescript ino <localleader>to3 _a -> _b -> _c -> _d
    autocmd Filetype haskell,purescript ino <localleader>lfsh _ <=< _
    autocmd Filetype haskell,purescript ino <localleader>rfsh _ >=> _
    autocmd Filetype haskell,purescript ino <localleader>for forM _ $ do
    autocmd Filetype haskell,purescript ino <localleader>trv traverse _f _
    autocmd Filetype haskell,purescript ino <localleader>for_ forM _ $ do
    autocmd Filetype haskell,purescript ino <localleader>trv_ traverse_ _f _
    autocmd Filetype haskell,purescript ino <localleader>fdr foldr _f _b _xs
    autocmd Filetype haskell,purescript ino <localleader>fdl foldl _f _b _xs
    autocmd Filetype haskell,purescript ino <localleader>fdm foldMap _f _xs
    autocmd Filetype haskell,purescript ino <localleader>ap _f <$> _a <*> _b
    autocmd Filetype haskell,purescript ino <localleader>ap2 _f <$> _a <*> _b
    autocmd Filetype haskell,purescript ino <localleader>ap3 _f <$> _a <*> _b <*> _c
    autocmd Filetype haskell,purescript ino <localleader>ap4 _f <$> _a <*> _b <*> _c <*> _d
    autocmd Filetype haskell,purescript ino <localleader>ap5 _f <$> _a <*> _b <*> _c <*> _d <*> _e
    autocmd Filetype haskell,purescript ino <localleader>l lift
    autocmd Filetype haskell,purescript ino <localleader>l2 lift . lift
    autocmd Filetype haskell,purescript ino <localleader>t2 (_, _)
    autocmd Filetype haskell,purescript ino <localleader>t3 (_, _, _)
    autocmd Filetype haskell,purescript ino <localleader>t4 (_, _, _, _)
    autocmd Filetype haskell,purescript ino <localleader>t5 (_, _, _, _, _)
    autocmd Filetype haskell,purescript ino <localleader>_2 _ _
    autocmd Filetype haskell,purescript ino <localleader>_3 _ _ _
    autocmd Filetype haskell,purescript ino <localleader>_4 _ _ _ _
    autocmd Filetype haskell,purescript ino <localleader>_5 _ _ _ _ _
    autocmd Filetype haskell,purescript ino <localleader>ev {- $> <cr> <$ -}

    " newtype mtl
    autocmd Filetype haskell ino <localleader>nt newtype _M a = _M {un_M :: _ a} deriving (Functor, Applicative, Monad, MonadIO, MonadReader _r , MonadWriter _w)
    autocmd Filetype haskell ino <localleader>nt1 newtype _M a = _M {un_M :: _ (_ IO) a} deriving (Functor, Applicative, Monad, MonadIO, MonadReader _r , MonadWriter _w)
    autocmd Filetype haskell ino <localleader>nt2 newtype _M a = _M {un_M :: _ (_ (_ IO)) a} deriving (Functor, Applicative, Monad, MonadIO, MonadReader _r , MonadWriter _w)


    " comments
    autocmd Filetype haskell,purescript ino <localleader>--- --------------------------------------------------------------------------------

    " refs
    autocmd Filetype haskell ino <localleader>rio readIORef _ref
    autocmd Filetype haskell ino <localleader>wio writeIORef _a _ref
    autocmd Filetype haskell ino <localleader>mio modifyIORef _f _ref
    autocmd Filetype haskell ino <localleader>rst readSTRef _ref
    autocmd Filetype haskell ino <localleader>wst writeSTRef _a _ref
    autocmd Filetype haskell ino <localleader>mst modifySTRef _f _ref
    autocmd Filetype haskell ino <localleader>rmv readMVar _mv
    autocmd Filetype haskell ino <localleader>wmv writeMVar _a _mv
    autocmd Filetype haskell ino <localleader>mmv modifyMVar _f _mv
    autocmd Filetype haskell ino <localleader>rtv readTVar _mv
    autocmd Filetype haskell ino <localleader>wtv writeTVar _a _mv
    autocmd Filetype haskell ino <localleader>mtv modifyTVar _f _mv

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
" ocaml
"
augroup ocamlsetup
  set rtp+=~/.opam/default/share/merlin/vim
  au FileType ocaml set shiftwidth=2 tabstop=2
  au FileType ocaml nnoremap <silent> <buffer> K :MerlinTypeOf<CR>
  au FileType ocaml vnoremap <silent> <buffer> K :MerlinTypeOfSel<CR>
  au FileType ocaml vnoremap <silent> <buffer> gd :MerlinLocate<CR>
  au FileType ocaml vnoremap <silent> <buffer> rn :MerlinRename
augroup end

function! EnableRanbowParenthesesWrapper()
  :execute 'try | call EnableRainbowParenthese() | catch | | endtry'
endfunction

"
" Lua
"
augroup luap
  au! luap
  au FileType lua nnoremap <leader>fm :call LuaFormat()<cr>
augroup end

"
" lisp
"
augroup lispy
    au! lispy
    au FileType scheme set shiftwidth=2 tabstop=2
    au FileType lisp set shiftwidth=2 tabstop=2
    au FileType closure call EnableRanbowParenthesesWrapper()
    au FileType lisp call EnableRanbowParenthesesWrapper()
    au FileType closure call EnableRanbowParenthesesWrapper()
augroup end

"
" F#
"
augroup fsharplang
    au! fsharplang
    au FileType fsharp set shiftwidth=2 tabstop=2
    au FileType fsharp setl commentstring=(*%s*)
    au Filetype fsharp ino <localleader>l1 (fun _a -> _z)
    au Filetype fsharp ino <localleader>l2 (fun _a _b -> _z)
    au Filetype fsharp ino <localleader>l3 (fun _a _b _c -> _z)
    au Filetype fsharp ino <localleader>l4 (fun _a _b _c _d -> _z)
    au Filetype fsharp ino <localleader>l5 (fun _a _b _c _d _e -> _z)
    au Filetype fsharp ino <localleader>f <bar>> Seq.map _fn
    au Filetype fsharp ino <localleader>fdl <bar>> Seq.fold _fn _base
    au Filetype fsharp ino <localleader>fi <bar>> Seq.filter _fn
    au Filetype fsharp ino <localleader>ta <bar>> Seq.toArray
    au Filetype fsharp ino <localleader>tl <bar>> Seq.toList
    au Filetype fsharp ino <localleader>sq <bar>> Task.seq
    au Filetype fsharp ino <localleader>sc <bar>> String.concat ""
    au Filetype fsharp ino <localleader>dv <bar>> Option.defaultValue _v
    au Filetype fsharp ino <localleader>mb <bar>> Option.bind _v
    au Filetype fsharp ino <localleader>if if _c then _t else _f
    au Filetype fsharp ino <localleader>mc match _p with
    au Filetype fsharp ino <localleader>lc let _f = function
augroup end

"
" elm
"
augroup elmlang
    au! elmlang
    au FileType elm set shiftwidth=2 tabstop=2
    au Filetype elm ino <localleader>l1 (\ _a -> _z)
    au Filetype elm ino <localleader>l2 (\ _a _b -> _z)
    au Filetype elm ino <localleader>l3 (\ _a _b _c -> _z)
    au Filetype elm ino <localleader>l4 (\ _a _b _c _d -> _z)
    au Filetype elm ino <localleader>l5 (\ _a _b _c _d _e -> _z)
    au Filetype elm ino <localleader>l6 (\ _a _b _c _d _e _f -> _z)
    au Filetype elm ino <localleader>l7 (\ _a _b _c _d _e _f _g -> _z)
    au Filetype elm ino <localleader>l8 (\ _a _b _c _d _e _f _g _h -> _z)
    au Filetype elm ino <localleader>l9 (\ _a _b _c _d _e _f _g _h _i -> _z)
    au Filetype elm ino <localleader>f <bar>> List.map _fn
    au Filetype elm ino <localleader>fdl <bar>> List.fold _fn _base
    au Filetype elm ino <localleader>fi <bar>> List.filter _fn
    au Filetype elm ino <localleader>mb <bar>> Maybe.andThen _v
    au Filetype elm ino <localleader>if if _c then _t else _f
    au Filetype elm ino <localleader>mc case _p of
augroup end

"
" C++
"
augroup cppconfig
    autocmd! cppconfig
    autocmd FileType cpp set shiftwidth=4 tabstop=4
    autocmd BufRead, BufNewFile CMakeLists.txt :set filetype=cmake
    autocmd FileType cpp set commentstring=//%s
augroup end

"
" SML
"
augroup smllang
  au! smllang
  au! BufRead,BufNewFile *.sig       setfiletype sml
  au! FileType sml set conceallevel=0

  au FileType sml nnoremap <silent> <buffer> K :SMLTypeQuery<CR>
  au FileType sml nnoremap <silent> <buffer> gd :SMLJumpToDef<CR>

  " open the REPL terminal buffer
  au FileType sml nnoremap <silent> <buffer> <leader>is :SMLReplStart<CR>
  " close the REPL (mnemonic: k -> kill)
  au FileType sml nnoremap <silent> <buffer> <leader>ik :SMLReplStop<CR>
  " build the project (using CM if possible)
  au FileType sml nnoremap <silent> <buffer> <leader>ib :SMLReplBuild<CR>
  " for opening a structure, not a file
  au FileType sml nnoremap <silent> <buffer> <leader>io :SMLReplOpen<CR>
  " use the current file into the REPL (even if using CM)
  au FileType sml nnoremap <silent> <buffer> <leader>iu :SMLReplUse<CR>
  " clear the REPL screen
  au FileType sml nnoremap <silent> <buffer> <leader>ic :SMLReplClear<CR>
  " set the print depth to 100
  au FileType sml nnoremap <silent> <buffer> <leader>ip :SMLReplPrintDepth<CR>
augroup end

"
" agda
"
augroup agdalang
  au! agdalang
  au! Filetype agda syn match agdaRewritingRelation "[^\s]⇝[^\s]"
  au! Filetype agda hi link agdaRewritingRelation ErrorMsg
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
" c#
"
let g:OmniSharp_server_use_mono = 1

"
" sql
"
let g:ftplugin_sql_omni_key = '<Plug>DisableSqlOmni'
