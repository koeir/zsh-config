set         tabstop=4
set         shiftwidth=4

inoremap    jj <Esc>

syntax      on
colorscheme retrobox

augroup MyHighlights
    autocmd!
    autocmd ColorScheme * hi Normal ctermbg=NONE guibg=NONE
    autocmd ColorScheme * hi NonText ctermbg=NONE guibg=NONE
augroup END
