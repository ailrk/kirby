ommand! -nargs=0 RemoveTrailing :%s#\($\n\s*\)\+\%$##

" commands
command! -nargs=1 PSearch vimgrep /<args>/ **/* | cw

" move current window to new tab.
command! -nargs=0 Totab sbp | wincmd p | wincmd T

" " Create a termial  panel
" function! CreateT()
"     if has('nvim')
"         :split
"         :terminal
"     else
"         :terminal
"     endif

"     :winc J
"     :resize 11
" endfunction

" function! VCreateT()
"     if has('nvim')
"         :vsplit
"         :terminal
"     else
"         :vert terminal
"     endif
"     :vert resize 80
" endfunction

function! ToggleQuickFix(full)
  if empty(filter(getwininfo(), 'v:val.quickfix'))
    copen
    if a:full
      :Goyo 100%+100%
    end
  else
    if a:full
      :Goyo
    end
    cclose
  end
endfunction

function! CreateTermialFullScreen()
    :terminal
    :only
endfunction

command! CreateTermial execute "call CreateT()"
command! VCreateTermial execute "call VCreateT()"
command! CreateTermialFullScreen execute "call CreateTermialFullScreen()"

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
command! MD execute "call MdMode()"

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

" command! -nargs=0 QUICKNote :call QuickNote()

function! QuickNote()
  execute "new ~/.note"
endfunction

function! NewFile(fp)
  " open a new file at the current path with name fp
  echom a:fp
  execute "e " . expand("%:h") . "/" . a.fp
endfunction

function! GoogleSearch(searchterm)
  silent! exec "AsyncRun -silent google-chrome-beta \"http://google.com/search?q=" . a:searchterm . "\" &"
endfunction

" highlight hieracy
function! SynGroup()
    let l:s = synID(line('.'), col('.'), 1)
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun


command -nargs=0 HomeManagerSwitch :silent! AsyncRun -silent home-manager switch<cr>
command -nargs=0 HomeManagerSwitchBSPWM :silent! AsyncRun home-manager switch && bspc wm -r && pkill -USR1 sxhkd <cr>

command -nargs=1 Google :call GoogleSearch(<args>)<cr>

let vimrc_nix_path = "$HOME/.config/nixpkgs/home/"
let vimrc_vim_path = g:vimrc_nix_path . "program/editor/neovim/"
let vimrc_bspwm_path = g:vimrc_nix_path . "role/workstation/de/bspwm/bspwmrc"

" Vimrc pointers
command -nargs=0 Vimrc :execute "new! " . g:vimrc_vim_path . "configs/common.vim"
command -nargs=0 VimrcCommon :execute "new! " . g:vimrc_vim_path . "configs/common.vim"
command -nargs=0 VimrcLanguages :execute "new! " . g:vimrc_vim_path . "configs/languages.vim"
command -nargs=0 VimrcLsp :execute "new! " . g:vimrc_vim_path . "configs/lsp.vim"
command -nargs=0 VimrcTheme :execute "new! " . g:vimrc_vim_path . "configs/theme.vim"
command -nargs=0 VimrcUtils :execute "new! " . g:vimrc_vim_path . "configs/utils.vim"
command -nargs=0 VimrcAdhoc :execute "new! " . g:vimrc_vim_path . "configs/adhoc.vim"
command -nargs=0 VimrcMapping :execute "new! " . g:vimrc_vim_path . "lua/mapping.lua"
command -nargs=0 VimrcPlug :execute "new! " . g:vimrc_vim_path . "lua/plug.lua"
command -nargs=0 VimrcPlugConfig :execute "new! " . g:vimrc_vim_path . "lua/plugconfig.lua"

command -nargs=0 VimrcSync :execute "HomeManagerSwitch"

" check current syntax group
command -nargs=0 SynCheckGroup :call SynGroup()<cr>

" bspwm pinteres
command -nargs=0 BspwmReload :silent! AsyncRun -silent bspc wm -r && pkill -USR1 sxhkd
command -nargs=0 BspwmEdit :execute "new! " . g:vimrc_bspwm_path
