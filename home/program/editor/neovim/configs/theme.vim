" set colorscheme
colorscheme vim-monochrome-waifu
" colorscheme default

set background=dark
" colorscheme solarized

" Popup menu
hi Pmenu ctermbg=238 ctermfg=254
hi PmenuSbar ctermbg=none
hi PmenuThumb ctermbg=none


" gutter
hi SignColumn ctermbg=none ctermfg=none
hi SyntasticErrorSign ctermbg=none  ctermfg=3
hi SyntasticWarningSign ctermbg=none ctermfg=3
hi htmlBold ctermbg=none ctermfg=none

hi ColorColumn ctermbg=white

" hight search
hi Search ctermfg=4 ctermbg=16

" trivial stuffs.
hi htmlUnderline ctermbg=none ctermfg=none
hi htmlUnderlineItalic ctermbg=none ctermfg=none


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

" Telescope
hi link TelescopePreviewLine Search
hi link TelescopeSelection Search

" hi TelescopePreviewMatch xxx links to Search


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
