vim.cmd [[
    let g:mkdx#settings     = { 'highlight': { 'enable': 0 },
                            \ 'enter': { 'shift': 1 },
                            \ 'map': { 'enable': 1 },
                            \ 'links': { 'external': { 'enable': 1 } },
                            \ 'toc': { 'text': 'Table of Contents', 'update_on_write': 1 },
                            \ 'fold': { 'enable': 1 },
                            \ 'table': { 'align': {
                                \ 'left':    [],
                                \ 'center':  [],
                                \ 'right':   [],
                                \ 'default': 'left' } } }
    let g:polyglot_disabled = ['markdown'] " for vim-polyglot users, it loads Plasticboy's markdown
]]


