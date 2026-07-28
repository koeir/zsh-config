inoremap        jj <Esc>

set             tabstop=4
syntax          on

colorscheme retrobox

augroup MyHighlights
    autocmd!
    autocmd ColorScheme * hi Normal ctermbg=NONE guibg=NONE
    autocmd ColorScheme * hi NonText ctermbg=NONE guibg=NONE
augroup END
