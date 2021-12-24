augroup set_shiftwidth
    autocmd! set_shiftwidth
  autocmd FileType purescript set shiftwidth=2 tabstop=2
  autocmd FileType javascript set shiftwidth=2 tabstop=2
  autocmd FileType json set shiftwidth=2 tabstop=2
  autocmd FileType koka set shiftwidth=2 tabstop=2
  autocmd FileType typescript set shiftwidth=2 tabstop=2
  autocmd FileType typescriptreact set shiftwidth=2 tabstop=2
  autocmd FileType ocaml set shiftwidth=2 tabstop=2
  autocmd FileType scheme set shiftwidth=2 tabstop=2
  autocmd FileType c set shiftwidth=4 tabstop=4
  autocmd FileType cuda set shiftwidth=4 tabstop=4
  autocmd FileType cpp set shiftwidth=4 tabstop=4
  autocmd FileType markdown set conceallevel=0
  autocmd FileType org set conceallevel=0
  autocmd BufWritePre * %s/\s\+$//eg
augroup end

augroup hslangs
    autocmd! hslangs
    " haskell
    autocmd FileType haskell,purescript set shiftwidth=2 tabstop=2

    " base
    autocmd Filetype haskell,purescript ino <localleader>F <$>
    autocmd Filetype haskell,purescript ino <localleader>Fl <$
    autocmd Filetype haskell,purescript ino <localleader>Fr $>
    autocmd Filetype haskell,purescript ino <localleader>Ff <&>
    autocmd Filetype haskell,purescript ino <localleader>rb >>=
    autocmd Filetype haskell,purescript ino <localleader>lb =<<
    autocmd Filetype haskell,purescript ino <localleader>rbb >>= (\a -> undefined)
    autocmd Filetype haskell,purescript ino <localleader>from <-
    autocmd Filetype haskell,purescript ino <localleader>A <*>
    autocmd Filetype haskell,purescript ino <localleader>alt <\|>
    autocmd Filetype haskell,purescript ino <localleader>to ->
    autocmd Filetype haskell,purescript ino <localleader>to2 _a -> _b -> _c
    autocmd Filetype haskell,purescript ino <localleader>to3 _a -> _b -> _c -> _d
    autocmd Filetype haskell,purescript ino <localleader>lfish <=<
    autocmd Filetype haskell,purescript ino <localleader>rfish >=>
    autocmd Filetype haskell,purescript ino <localleader>of $
    autocmd Filetype haskell,purescript ino <localleader>tra traverse
    autocmd Filetype haskell,purescript ino <localleader>fol foldr _f _b _xs
    autocmd Filetype haskell,purescript ino <localleader>fom foldMap _f _xs
    autocmd Filetype haskell,purescript ino <localleader>ap _f <$> _a <*> _b
    autocmd Filetype haskell,purescript ino <localleader>ap2 _f <$> _a <*> _b <*> _c
    autocmd Filetype haskell,purescript ino <localleader>ap3 _f <$> _a <*> _b <*> _c <*> _d
    autocmd Filetype haskell,purescript ino <localleader>lift2 lift . lift
    autocmd Filetype haskell,purescript ino <localleader>lift3 lift . lift  . lift
    autocmd Filetype haskell,purescript ino <localleader>lift4 lift . lift  . lift . lift
    autocmd Filetype haskell,purescript ino <localleader>_2 _ _
    autocmd Filetype haskell,purescript ino <localleader>_3 _ _ _
    autocmd Filetype haskell,purescript ino <localleader>_4 _ _ _ _
    autocmd Filetype haskell,purescript ino <localleader>_5 _ _ _ _ _
    autocmd Filetype haskell,purescript ino <localleader>_6 _ _ _ _ _ _
    autocmd Filetype haskell,purescript ino <localleader>ev {- $> <cr> <$ -}

    " comments
    autocmd Filetype haskell,purescript ino <localleader>--- --------------------------------------------------------------------------------
    " refs
    autocmd Filetype haskell,purescript ino <localleader>rioref readIORef _ref
    autocmd Filetype haskell,purescript ino <localleader>wioref writeIORef _a _ref
    autocmd Filetype haskell,purescript ino <localleader>mioref modifyIORef _f _ref
    autocmd Filetype haskell,purescript ino <localleader>rstref readSTRef _ref
    autocmd Filetype haskell,purescript ino <localleader>wstref writeSTRef _a _ref
    autocmd Filetype haskell,purescript ino <localleader>mstref modifySTRef _f _ref
    autocmd Filetype haskell,purescript ino <localleader>rmvar readMVar _mv
    autocmd Filetype haskell,purescript ino <localleader>wmvar writeMVar _a _mv
    autocmd Filetype haskell,purescript ino <localleader>mmvar modifyMVar _f _mv

    " lens
    autocmd Filetype haskell,purescript ino <localleader>vi ^.
    autocmd Filetype haskell,purescript ino <localleader>se .~
    autocmd Filetype haskell,purescript ino <localleader>ov %~
    autocmd Filetype haskell,purescript ino <localleader>pvi ^?
    autocmd Filetype haskell,purescript ino <localleader>pse ?~

    " lens stateful
    autocmd Filetype haskell,purescript ino <localleader>sse .=
    autocmd Filetype haskell,purescript ino <localleader>sov %=

    autocmd Filetype haskell ino <localleader>ret return $
    autocmd Filetype haskell ino <localleader>trc trace (": " ++ show "") $

    " comment
    autocmd Filetype haskell,purescript ino <localleader>@@ {-@ @-}<left><left><left>

    " haskell import
    autocmd Filetype haskell ino <localleader>immonad import Control.Monad
    autocmd Filetype haskell ino <localleader>immapp import Control.Applicative
    autocmd Filetype haskell ino <localleader>imtext import qualified Data.Text as T

    " ALEFix
    " autocmd FileType haskell nnoremap <leader>fm :ALEFix<CR>

    let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
    let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
    let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
    let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
    let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
    let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
    let g:haskell_backpack = 1                " to enable highlighting of backpack keywords
    let g:haskell_classic_highlighting = 1

    " fix highlight
    " autocmd Filetype haskell sy keyword haskellTrace trace traceId traceShow traceStack traceIO traceM traceShowM traceEvent traceEventIO traceMarker traceMarkerIO
    " autocmd Filetype haskell hi link haskellType Constant
    " autocmd Filetype haskell hi link haskellTrace Operator

    " autocmd Filetype haskell sy keyword haskellMonadic join >>= >=> <=< >> << lift liftIO liftM traverse traverse_ traverseM mapM mapM_
    " autocmd Filetype haskell sy keyword haskellImperative newIORef readIORef writeIORef modifyIORef modifyIORef' atomicModifyIORef atomicModifyIORef' atomicWriteIORef mkWeakIORef newEmptyMVar newMVar takeMVar putMVar readMVar swapMVar newSTRef readSTRef writeSTRef writeSTRef modifySTRef

    " autocmd Filetype haskell hi link haskellMonadic Constant
    " autocmd Filetype haskell hi link haskellImperative Constant

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

" ocaml
augroup ocamlsetup
  set rtp+=~/.opam/default/share/merlin/vim
  au FileType ocaml nnoremap <silent> <buffer> K :MerlinTypeOf<CR>
  au FileType ocaml vnoremap <silent> <buffer> K :MerlinTypeOfSel<CR>
  au FileType ocaml vnoremap <silent> <buffer> gd :MerlinLocate<CR>
  au FileType ocaml vnoremap <silent> <buffer> rn :MerlinRename
augroup end

function! EnableRanbowParenthesesWrapper()
  :execute 'try | call EnableRainbowParenthese() | catch | | endtry'
endfunction

augroup luap
  autocmd! luap
  autocmd FileType lua nnoremap <leader>fm :call LuaFormat()<cr>
augroup end

augroup lispy
    autocmd! lispy
    autocmd FileType scheme call EnableRanbowParenthesesWrapper()
    autocmd FileType lisp call EnableRanbowParenthesesWrapper()
    autocmd FileType closure call EnableRanbowParenthesesWrapper()
augroup end

augroup cppconfig
    autocmd! cppconfig
    autocmd BufRead, BufNewFile CMakeLists.txt :set filetype=cmake
    autocmd FileType cpp set commentstring=//%s
augroup end

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

augroup agdalang
  au! agdalang
  au! Filetype agda syn match agdaRewritingRelation "[^\s]⇝[^\s]"
  au! Filetype agda hi link agdaRewritingRelation ErrorMsg
augroup end

augroup apllang
  au! apllang
  let g:apl_prefix_key = '<M-a>'
  au! BufRead,BufNewFile *.aplf,*aplc,*apln       setfiletype apl
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
augroup end



" CSS
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS noci
inoremap <leader>, <C-x><C-o>

nnoremap <leader>rp :RainbowParenthesesToggle<CR>
function EnableRainbowParenthese()
    :RainbowParenthesesLoadRound
    :RainbowParenthesesActivate
endfunction

" Racket
" function RacketAutoComplete()
"     :silent !gen-rkt-symbols
"     if filereadable("/tmp/racket-dict.vim")
"         :set dictionary+=/tmp/racket-dict.vim
"     endif
" endfunction
" autocmd FileType racket call RacketAutoComplete()

" markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

" c#
let g:OmniSharp_server_use_mono = 1

" sql
let g:ftplugin_sql_omni_key = '<Plug>DisableSqlOmni'