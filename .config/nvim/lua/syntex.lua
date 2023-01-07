local au = require('au')

-- Syntex integration
vim.cmd [[
" Core functions
function! Synctex()
    let vimura_param = " --synctex-forward " . line('.') . ":" . col('.') . ":" . expand('%:p') . " " . substitute(expand('%:p'),"tex$","pdf", "")
    call jobstart("vimura neovim" . vimura_param)
    redraw!
endfunction

function! OpenZathura()
    let position = line('.') . ":" . col('.') . ":" . expand('%:p') . " "
    call jobstart("zathura -x 'nvr --remote +%{line} %{input}' --synctex-forward " . position . " " . substitute(expand('%:p'),"tex$","pdf", ""))
endfunction
]]
au.BufWritePost = { -- Autogeneratex pdf on saving latex
    '*.tex',
    'silent! execute "!pdflatex -synctex=1 % >/dev/null 2>&1" | redraw!'
}
