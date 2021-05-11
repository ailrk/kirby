" set the runtime path to include Vundle and initialize set rtp+=~/.vim/autoload/plug.vim
set encoding=utf-8
set fileencoding=utf-8
" leader key
let mapleader=","

" independent setting
""syntax off
set display+=lastline               "show all wrapped lines.
set tabstop=2
set shiftwidth=2
set expandtab
set smartindent
set cmdheight=2
set shell=/usr/bin/zsh
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
set mouse=a
set exrc                            "local setting

" ignore binaries
set wildignore+=*.pyc,*.o,*.obj,*.svn,*.swp,*.class,*.hg,*.DS_Store,*.min.*,*.fasl,*.bci,*.bin,*.com,*.hi,*.cmo,*.cmi,*.agdai

let c_no_curly_error=1

" my commands
command! -nargs=0 RemoveTrailing :%s#\($\n\s*\)\+\%$##

call plug#begin('~/.vim/plugged')

Plug 'junegunn/vim-plug'
Plug 'tpope/vim-fugitive'
""Plug 'git://git.wincent.com/command-t.git'
Plug 'rstacruz/sparkup', {'rtp': 'vim/'}
""Plug 'mattn/webapi-vim'
""Plug 'mattn/gist-vim'

" big plugs
Plug 'w0rp/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" convenient
Plug 'Yggdroot/indentline'
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-commentary'
Plug 'kien/rainbow_parentheses.vim'
Plug 'liuchengxu/vista.vim'
Plug 'itchyny/calendar.vim'
Plug 'vimwiki/vimwiki'
Plug 'vim-scripts/DrawIt'
Plug 'nvim-lua/completion-nvim'
Plug 'https://github.com/nathanaelkane/vim-indent-guides'
Plug 'voldikss/vim-floaterm'

Plug 'jummy233/glyphs-vim'
"Plug '/home/jimmy/newDisk/Repo/glyphs-vim'
Plug 'tjdevries/coc-zsh'
""Plug 'francoiscabrol/ranger.vim'

Plug 'junegunn/fzf.vim'

" language
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'lervag/vimtex'
Plug 'mattn/emmet-vim'
Plug 'wlangstroth/vim-racket'
Plug 'tshirtman/vim-cython'
Plug 'purescript-contrib/purescript-vim'
Plug 'neovimhaskell/haskell-vim'
Plug 'anntzer/vim-cython'
Plug 'pangloss/vim-javascript'
Plug 'plasticboy/vim-markdown'
Plug 'meck/vim-brittany'
""Plug 'OmniSharp/omnisharp-vim'
""Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'derekelkins/agda-vim'
Plug 'whonore/Coqtail'
Plug 'kovisoft/slimv'
""Plug 'puremourning/vimspector'
Plug 'https://github.com/jez/vim-better-sml'
Plug 'https://github.com/octol/vim-cpp-enhanced-highlight'

" functional
Plug 'skywind3000/asyncrun.vim'

" editing
Plug 'jpalardy/vim-slime'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'roosta/vim-srcery'
Plug 'dylanaraps/wal.vim'
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'

" colorscheme
Plug 'chriskempson/base16-vim'
Plug 'morhetz/gruvbox'

Plug 'kristijanhusak/vim-carbon-now-sh'

call plug#end()


" mapping
ino " ""<left>
" ino ` ``<left>
ino { {}<left>
ino ( ()<left>
ino [ []<left>
ino {<CR> {<CR>}<ESC>O
ino {;<CR> {<CR>};<ESC>O
ino <leader>( (
ino <leader>{ {
ino <leader>( (
ino <leader>[ [
ino <leader>; ::
ino <leader>< <><left>
" ino <leader>` `
ino <leader>" "
ino <leader>L λ

" the main exit key.
" inoremap jk <esc>
" inoremap kj <esc>
" inoremap jl <esc>
" inoremap lj <esc>

inoremap <expr> <C-Space> pumvisible() \|\| &omnifunc == '' ?
\ "\<lt>C-n>" :
\ "\<lt>C-x>\<lt>C-o><c-r>=pumvisible() ?" .
\ "\"\\<lt>c-n>\\<lt>c-p>\\<lt>c-n>\" :" .
\ "\" \\<lt>bs>\\<lt>C-n>\"\<CR>"
imap <C-@> <C-Space>

" clipboard
vno <leader>y :!xclips<CR>
"line number
nnoremap <leader>N :set number!<CR>

" terminal
" nnoremap <leader>1 :VCreateTermial<CR>
" nnoremap <leader>2 :CreateTermial<CR>
" nnoremap <leader>3 :tab terminal<CR>

" easy to config
nnoremap <leader>ev :split $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" coc.nvim config
" restart mapping
nnoremap <leader>rb :CocRebuild<CR>
nnoremap <leader>rs :CocRestart<CR>

" ad hoc formatter
nnoremap <leader>fm :Format<CR>

" remove tailing empty iine
nnoremap <leader>rt :RemoveTrailing<CR>
"autocmd FileType haskell nnoremap <leader>fm :%!stylish-haskell<CR>

let g:brittany_on_save = 0

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)

nmap <leader>cl <Plug>(coc-codelens-action)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
" ctrl p
nnoremap <c-p> :<C-u>CocList files<CR>
" Mru
nnoremap <silent> <space>m :<C-u>CocList mru<CR>
" buffer
nnoremap <silent> <space>b :<C-u>CocList buffers<CR>
" grep""
nnoremap <silent> <space>g :<C-u>CocList grep<CR>
" End Coc.nvim config


" Start autocmd for language specific configurations.
augroup hslangs
    autocmd! hslangs
    " haskell
    autocmd FileType haskell,purescript set shiftwidth=2 tabstop=2

    " base
    autocmd Filetype haskell,purescript ino <localleader>f <$>
    autocmd Filetype haskell,purescript ino <localleader>F <&>
    autocmd Filetype haskell,purescript ino <localleader>B >>=
    autocmd Filetype haskell,purescript ino <localleader>A <*>

    " lens
    autocmd Filetype haskell,purescript ino <localleader>v ^.
    autocmd Filetype haskell,purescript ino <localleader>s .~
    autocmd Filetype haskell,purescript ino <localleader>o %~
    autocmd Filetype haskell,purescript ino <localleader>p ^?

    " lens stateful
    autocmd Filetype haskell,purescript ino <localleader>ss .=
    autocmd Filetype haskell,purescript ino <localleader>so %=

    autocmd Filetype haskell,purescript ino <localleader>\| <\|>
    let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
    let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
    let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
    let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
    let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
    let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
    let g:haskell_backpack = 1                " to enable highlighting of backpack keywords
    let g:haskell_classic_highlighting = 1
augroup end


" ocaml
augroup ocamlsetup
  set rtp+=~/.opam/default/share/merlin/vim
  au FileType ocaml nnoremap <silent> <buffer> K :MerlinTypeOf<CR>
  au FileType ocaml vnoremap <silent> <buffer> K :MerlinTypeOfSel<CR>
  au FileType ocaml vnoremap <silent> <buffer> gd :MerlinLocate<CR>
  au FileType ocaml vnoremap <silent> <buffer> rn :MerlinRename
augroup end

augroup vimbettersml
  au!

  " ----- Keybindings -----
  au FileType sml nnoremap <silent> <buffer> K :SMLTypeQuery<CR>
  au FileType sml nnoremap <silent> <buffer> gd :SMLJumpToDef<CR>

  " open the REPL terminal buffer
  au FileType sml nnoremap <silent> <buffer> <leader>c :SMLReplStart<CR>
  " close the REPL (mnemonic: k -> kill)
  au FileType sml nnoremap <silent> <buffer> <leader>q :SMLReplStop<CR>
  " build the project (using CM if possible)
  au FileType sml nnoremap <silent> <buffer> <leader>F :SMLReplBuild<CR>
  " for opening a structure, not a file
  au FileType sml nnoremap <silent> <buffer> <leader>o :SMLReplOpen<CR>
  " use the current file into the REPL (even if using CM)
  au FileType sml nnoremap <silent> <buffer> <leader>L :SMLReplUse<CR>
  " clear the REPL screen
  au FileType sml nnoremap <silent> <buffer> <leader>- :SMLReplClear<CR>
  " set the print depth to 100
  au FileType sml nnoremap <silent> <buffer> <leader>d :SMLReplPrintDepth<CR>

  " send
  au FileType sml nnoremap <silent> <buffer> <leader>e :SMLReplSend

  " ----- Other settings -----
  " Uncomment to try out conceal characters
  au FileType sml setlocal conceallevel=0

  " Uncomment to try out same-width conceal characters
  let g:sml_greek_tyvar_show_tick = 0

  au FileType sml setlocal complete+=k~/.vim/mine/sml-autocomplete.txt

augroup end


augroup lispy
    autocmd FileType lisp,racket,scheme vno <leader>fm :!scmindent %<CR>
    " slimv
    let g:slimv_ctags = "ctags"
    let g:slimv_disable_scheme = 1
    autocmd FileType racket call EnableRainbowParenthese()
    autocmd FileType lisp call EnableRainbowParenthese()
    autocmd FileType clojure call EnableRainbowParenthese()
augroup end

augroup cppconfig
    autocmd! cppconfig
    autocmd FileType cpp set commentstring=//%s
augroup end

" latex
augroup texconfig
    autocmd! texconfig
    autocmd FileType tex nnoremap <leader>cp :!xelatex %<CR>
    autocmd FileType tex command -nargs=0 LatexCompile :!xelatex %
    autocmd FileType tex nnoremap j gj
    autocmd FileType tex nnoremap k gk
    autocmd FileType tex set linebreak

    autocmd FileType plaintex set filetype=tex
    autocmd FileType tex nnoremap <F5> :setlocal spell! spelllang=en_us<CR>
augroup end

autocmd FileType purescript set shiftwidth=2 tabstop=2
autocmd FileType javascript set shiftwidth=2 tabstop=2
autocmd FileType json set shiftwidth=2 tabstop=2
autocmd FileType typescript set shiftwidth=2 tabstop=2
autocmd FileType typescriptreact set shiftwidth=2 tabstop=2
autocmd FileType ocaml set shiftwidth=2 tabstop=2
autocmd FileType racket set shiftwidth=2 tabstop=2
autocmd FileType scheme set shiftwidth=2 tabstop=2
" autocmd FileType c set shiftwidth=4 tabstop=4
" autocmd FileType cuda set shiftwidth=4 tabstop=4
" autocmd FileType cpp set shiftwidth=4 tabstop=4
autocmd FileType markdown set conceallevel=0
autocmd FileType org set conceallevel=0
autocmd BufWritePre * %s/\s\+$//eg

" End language specific config

" Vim org mod Config
" let g:org_aggressive_conceal = 0
" let g:org_agenda_files = ['~/org/index.org']

" Vim wiki
" let g:vimwiki_list = [{'path': '~/.vimwiki',
"             \ 'syntax': 'markdown', 'ext': '.md'}]

" ultisnips
let g:UltiSnipsExpandTrigger="<c-j>"

"ctags setting
set tags=./.tags;,.tags

" Languages

" CSS
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS noci
inoremap <leader>, <C-x><C-o>

" lisp
nnoremap <leader>rp :RainbowParenthesesToggle<CR>
function EnableRainbowParenthese()
    :RainbowParenthesesLoadRound
    :RainbowParenthesesActivate
endfunction

function RacketAutoComplete()
    :silent !gen-rkt-symbols
    if filereadable("/tmp/racket-dict.vim")
        :set dictionary+=/tmp/racket-dict.vim
    endif
endfunction
autocmd FileType racket call RacketAutoComplete()

" markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

" c#
let g:OmniSharp_server_use_mono = 1


" sql
let g:ftplugin_sql_omni_key = '<Plug>DisableSqlOmni'

" c++
autocmd BufRead, BufNewFile CMakeLists.txt :set filetype=cmake


" Termdebug
autocmd FileType cpp :packadd termdebug
autocmd FileType c :packadd termdebug
autocmd FileType rust :packadd termdebug
autocmd FileType python :packadd termdebug
let g:termdebug_wide = 1

" vimsepctor debug
" let g:vimspector_enable_mappings = "HUMAN"
" nnoremap <localleader>dd :call vimspector#Launch()<CR>
" nnoremap <localleader>dp :call vimspector#Pause()<CR>
" nnoremap <localleader>d0 :call vimspector#Stop()<CR>

" nnoremap <localleader>dx :VimspectorReset<CR>
" nnoremap <localleader>dw :VimspectorWatch
" nnoremap <localleader>de :VimspectorEval
" nnoremap <localleader>do :VimspectorShowOutput

" nnoremap <localleader><space> :call vimspector#ToggleBreakpoint()<CR>
" nnoremap <localleader>c :call vimspector#Continue()<CR>
" nnoremap <localleader>s :call vimspector#StepInto()<CR>
" nnoremap <localleader>n :call vimspector#StepOver()<CR>
" nnoremap <localleader>u :call vimspector#StepOut()<CR>
" nnoremap <localleader>r :call vimspector#RunToCursor()<CR>

" End Languages

" vimtex
" let g:Tex_MultipleCompileFormats = 'pdf'
" let g:Tex_DefaultTargetFormat = 'pdf'
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
" nnoremap <leader>ltoc :VimtexTocToggle
" nnoremap <Leader>le :VimtexErrors


" ALE
nnoremap <leader>ad :ALEDetail<CR>
let g:ale_linters_explicit = 0
let g:ale_completion_delay = 500
let g:ale_echo_delay = 20
let g:ale_lint_delay = 500
let g:ale_echo_msg_format = '[%linter%] %code: %%s'
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:ale_sign_error = '*'
let g:ale_sign_warning = '~'

let g:ale_linters = {
            \ 'c' : ['cppcheck'],
            \ 'cpp' : ['cppcheck'],
            \ 'python' : ['flake8', 'mypy'],
            \ 'lua' : ['luac'],
            \ 'java' : [],
            \ 'javascript': ['eslint', 'tsserver'],
            \ 'typescript': ['eslint', 'tsserver'],
            \ 'rust' : [],
            \ 'cs' : ['OmniSharp'],
            \ 'haskell' : [],
            \ 'asm' : [],
            \ 'ocaml' : ['merlin'],
            \ 'r' : []
            \}

let g:ale_fixers =  {
      \ 'haskell' : ["stylish-haskell"]
      \ }

autocmd FileType haskell nnoremap <leader>fm :ALEFix<CR>

let g:ale_c_gcc_options = '-Wall -O2 -std=c11'
let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++17'
let g:ale_c_cppcheck_options = ''
let g:ale_cpp_cppcheck_options = ''
let g:ale_lua_luacheck_options = '-d'

" highlight cError ctermfg=none
highlight ALEErrorSign ctermbg=none  ctermfg=3
highlight ALEWarningSign ctermbg=none ctermfg=1

" vista.vim
let g:vista_icon_indent = ["|->", "─>"]
let g:vista_default_executive = 'coc'
let g:vista#renderer#enable_icon = 0

" Indent guide
let g:indent_guides_enable_on_vim_startup = 0
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=255
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=none
nnoremap <leader>ig :IndentGuidesToggle<CR>

" Indent line. Trigger on mode change.
"let &stl.='%{RedrawStatuslineColors(mode())}'
let g:indentLine_color_term = 233
let g:indentLine_setConceal = 0
let g:indentLine_enabled = 0

" function! RedrawStatuslineColors(mode)
"     if a:mode == 'v'
"       :IndentGuidesEnable
"     else
"       :IndentGuidesDisable
"     endif
" endfunction

" file explorer
" nerdTree
nnoremap <C-e> :NERDTreeToggle<CR>
nnoremap <localleader>ff :NERDTreeFind<CR>
let NERDTreeRespectWildIgnore=1

let g:NERDTreeWinSize = 30
let g:netrwon = 1
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 2
let g:netrw_winsize = 30

" nnoremap <C-e> :CocCommand explorer<CR>
"

"" leaderF
"let g:Lf_WindowHeight = '0.2'
""let g:Lf_WindowPosition = 'popup'
""let g:Lf_PreviewInPopup = 1
"nnoremap <C-f> :LeaderfFunction!<CR>
"nnoremap <C-p> :LeaderfFile<CR>
"nnoremap <C-t> :LeaderfBufTag<CR>
"nnoremap <C-h> :LeaderfBuffer<CR>
"nnoremap <C-i> :LeaderfRgInteractive<CR>

" AsyncRun
let g:asyncrun_open = 12

" vim-slime
let g:slime_python_ipython = 1
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": ":0.1"}
let g:slime_paste_file = "$HOME/.slime_paste"
let g:slime_no_mappings = 1
nmap <Plug>NoSlimeParagraphSend <Plug>SlimeParagraphSend

" TODO I want to disable vim slime when using slimv
xmap <localleader>s <Plug>SlimeRegionSend
nmap <localleader>s <Plug>SlimeParagraphSend
nmap <localleader>S :%SlimeSend<CR>

" floatterm
nmap <C-n> :FloatermToggle<CR>
nmap <C-h> :FloatermNew<CR>
nmap <C-m> :FloatermNext<CR>
nmap <space>n :CocList floaterm<CR>

" Vista
nmap <leader>V :Vista<CR>

" commands
command -nargs=1 PSearch vimgrep /<args>/ **/* | cw

" move current window to new tab.
command -nargs=0 Totab sbp | wincmd p | wincmd T

" Create a termial  panel
function! CreateT()
    if has('nvim')
        :split
        :terminal
    else
        :terminal
    endif

    :winc J
    :resize 11
endfunction

function! VCreateT()
    if has('nvim')
        :vsplit
        :terminal
    else
        :vert terminal
    endif
    :vert resize 80
endfunction

function! CreateTermialFullScreen()
    :terminal
    :only
endfunction

command CreateTermial execute "call CreateT()"
command VCreateTermial execute "call VCreateT()"
command CreateTermialFullScreen execute "call CreateTermialFullScreen()"

" Markdown auto line change for Goyo
function! MdMode()
    :Goyo 80
    ino " "
    ino ' '
    nnoremap j gj
    nnoremap k gk
    nnoremap q qq
    ino ' '<right>
    set nonu
    set colorcolumn=0
    set wrap linebreak nolist
endfunction
command MD execute "call MdMode()"

" extend Glyphm shorcut
let g:glyphs_vim_extend_glyphs = {
            \ "1" : "₁", "2" : "₂", "3" : "₃", "4" : "₄",
            \ "5" : "₅", "6" : "₆", "7" : "₇", "8" : "₈",
            \ "9" : "₉", "0" : "₀", "=1" : "¹", "=2" : "²",
            \ "=3" : "³", "=4" : "⁴", "=5" : "⁵",
            \ "=6" : "⁶", "=7" : "⁷", "=8" : "⁸", "=9" : "⁹",
            \ "=0" : "⁰", "=+" : "⁺", "=-" : "⁻", "==" : "⁼",
            \ "=(" : "⁽", "=)" : "⁾",
            \}

command! -nargs=0 QUICKNote :call QuickNote()

function! QuickNote()
  execute "new ~/.note"
endfunction

function! NewFile(fp)
  " open a new file at the current path with name fp
  echom a:fp
  execute "e " . expand("%:h") . "/" . a.fp
endfunction

" color
augroup mycolors
    autocmd! mycolors
    " highlight group
    autocmd ColorScheme * highlight Normal ctermbg=none
    autocmd ColorScheme * highlight NonText ctermbg=none

    " hightlight 80 column and cursors
    if exists('+colorcolumn')
        autocmd ColorScheme * hi ColorColumn ctermbg=236
        autocmd ColorScheme * hi CursorLine ctermbg=236
    else
        au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80.\+',-1)
    endif

    " set statusline
    if exists('+statusline')
        autocmd ColorScheme * hi StatusLine  ctermfg=1 ctermbg=16
        autocmd ColorScheme * hi StatusLineNC  ctermfg=237 ctermbg=244

        autocmd ColorScheme * hi StatusLineTerm  ctermfg=236 ctermbg=102
        autocmd ColorScheme * hi StatusLineTermNC  ctermfg=13 ctermbg=236
        autocmd ColorScheme * hi VertSplit ctermbg=none
    endif


    " Popup menu
    " additional
    autocmd ColorScheme * hi Pmenu ctermbg=235
    autocmd ColorScheme * hi PmenuSbar ctermbg=none
    autocmd ColorScheme * hi PmenuThumb ctermbg=none

    " gutter
    autocmd ColorScheme * hi SignColumn ctermbg=none ctermfg=none
    autocmd ColorScheme * hi SyntasticErrorSign ctermbg=none  ctermfg=3
    autocmd ColorScheme * hi SyntasticWarningSign ctermbg=none ctermfg=3
    autocmd ColorScheme * hi htmlBold ctermbg=none ctermfg=none


    " hight search
    autocmd ColorScheme * hi Search ctermfg=4 ctermbg=16

    " trivial stuffs.
    autocmd ColorScheme * hi htmlUnderline ctermbg=none ctermfg=none
    autocmd ColorScheme * hi htmlUnderlineItalic ctermbg=none ctermfg=none

    " vimwiki title
    hi link VimwikiHeader2 Boolean
    hi link VimwikiHeader3 Type

    " set colorscheme
    colorscheme gruvbox
    set background=dark
    hi Comment cterm=bold

    " modify gruvbox sign
    hi GruvboxRedSign ctermfg=167 ctermbg=none guifg=#fb4934 guibg=#3c3836
    hi GruvboxGreenSign ctermfg=142 ctermbg=none guifg=#b8bb26 guibg=#3c3836
    hi GruvboxYellowSign ctermfg=214 ctermbg=none guifg=#fabd2f guibg=#3c3836
    hi GruvboxBlueSign ctermfg=109 ctermbg=none guifg=#83a598 guibg=#3c3836
    hi GruvboxPurpleSign ctermfg=175 ctermbg=none guifg=#d3869b guibg=#3c3836
    hi GruvboxAquaSign ctermfg=108 ctermbg=none guifg=#8ec07c guibg=#3c3836
    hi GruvboxOrangeSign ctermfg=208 ctermbg=none guifg=#fe8019 guibg=#3c3836


    " visual mode color. Gruvbox will force this setting
    " so it should be set after setting colorscheme
    hi Visual cterm=none ctermbg=4

    " Cocnvim
    hi CocUnderline cterm=none
    hi CocErrorHighlight cterm=none
    hi CocWarningHighlight cterm=none
    hi CocHintHighlight cterm=none
    hi CocInfoHighlight cterm=none

    " ALE info
    hi ALEError cterm=none
    hi ALEWarning cterm=none
    hi ALEInfo cterm=none
augroup end

