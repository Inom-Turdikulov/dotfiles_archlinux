-- Zathura is a pdf viewer with nvr integration

vim.cmd([[
    function! OpenZathura()
    let position = line('.') . ":" . col('.') . ":" . expand('%:p') . " "
    call jobstart("zathura -x 'nvr --remote +%{line} %{input}' --synctex-forward " . position . " " . substitute(expand('%:p'),"tex$","pdf", ""))
    endfunction

    " Universal keybinding to open zathura and sync with vim
    map <leader><Enter> :call OpenZathura()<cr>

    " Generate pdf on save tex file using pdflatex
    autocmd BufWritePost *.tex term pdflatex -synctex=1 %
]])

