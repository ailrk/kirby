" lua require("init")

lua require'plug'
" source $HOME/.config/nvim/plug.vim
source $HOME/.config/nvim/common.vim

" source $HOME/.config/nvim/lsp.vim
" source $HOME/.config/nvim/mapping.vim

lua require'mapping'

source $HOME/.config/nvim/debug.vim
source $HOME/.config/nvim/adhoc.vim
source $HOME/.config/nvim/utils.vim

" make sure plugin configs override default configs
lua require'plugconfig'

source $HOME/.config/nvim/theme.vim
source $HOME/.config/nvim/languages.vim
