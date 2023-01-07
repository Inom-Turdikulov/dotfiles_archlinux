require('options')
require('plugins')
require('mappings')
require('syntex')

if vim.env.CONDA_PREFIX then
  vim.g.python3_host_prog = vim.env.CONDA_PREFIX .. '/bin/python'
end

-- Automatic actions
local au = require('au')

-- Cyrylic langmap
vim.cmd [[
:set langmap=ФЕЧСЛУПЬДНТГРОЖЕЙЫВАШМЦЯЩИ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фечслупьднтгрожейывашмцящи;abcdefghijklmnopqrstuvwxyz
]]

-- Save latest position
vim.cmd [[
autocmd BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif
]]

-- fix nvim size when run in term
vim.cmd [[
autocmd VimEnter * :silent exec "!kill -s SIGWINCH $PPID"
]]

-- Autoreload
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})

-- -- Autoformat on save
-- au.BufWritePre = {
--     '*.py,*.c',
--     function()
--         vim.lsp.buf.formatting()
--     end,
-- }

vim.cmd[[
nnoremap <silent><buffer> <space>aa :call CreateNotes()<cr>

nmap <silent><buffer> <leader>ar
      \ <cmd>call medieval#eval('', #{
      \   after: { _x, _y -> personal#markdown#place_signs() }
      \ })<cr>

function! CreateNotes() abort " {{{1
  " Create notes from list of question/answers
  "
  " <category>
  " tags: list (default = category)
  " Q: ...
  " ...
  " A: ...
  " ...
  " tags: new list
  " Q: ...
  " A: ...
  "
  if getline('.') =~# '^\s*$' | return | endif

  " Avoid folds messing things up
  setlocal nofoldenable

  let l:template = join([
        \ '# Note',
        \ 'model: Basic',
        \ 'tags: {tags}',
        \ '',
        \ '## Front',
        \ '**{category}**',
        \ '',
        \ '{q}',
        \ '',
        \ '## Back',
        \ '{a}',
        \], "\n")

  let l:lnum_start = search('^\n\zs\|\%^', 'ncb')
  if l:lnum_start > line('.')
    let l:lnum_start = line('.')
  endif

  let l:lnum_end = search('\n$\|\%$', 'nc')
  if l:lnum_end - 1 <= l:lnum_start | return | endif

  let l:lines = getline(l:lnum_start, l:lnum_end)

  let l:category = remove(l:lines, 0)
  let l:template = substitute(l:template, '{category}', l:category, 'g')
  let l:tags = substitute(trim(split(l:category, '/')[0]), ' ', '-', '')

  let l:current = {}
  let l:list = []
  for l:line in l:lines
    if l:line =~# '^tags\?:'
      let l:tags = matchstr(l:line, '^tags\?: \zs.*')
      continue
    endif

    if l:line =~# '^Q:'
      if !empty(l:current)
        call add(l:list, l:current)
        let l:current = {}
      endif
      let l:current.tags = l:tags
      let l:current.q = [matchstr(l:line, '^Q: \zs.*')]
      let l:current.pointer = l:current.q
    elseif l:line =~# '^A:'
      let l:current.a = [matchstr(l:line, '^A: \zs.*')]
      let l:current.pointer = l:current.a
    else
      let l:current.pointer += [l:line]
    endif
  endfor

  if !empty(l:current)
    call add(l:list, l:current)
  endif

  if line('$') == l:lnum_end
    call append(line('$'), '')
  endif

  " Remove existing lines
  silent execute l:lnum_start . ',' . l:lnum_end 'd'

  " Add new notes
  for l:e in l:list
    let l:q = escape(join(l:e.q, "\n"), '\')
    let l:a = escape(join(l:e.a, "\n"), '\')

    let l:new = copy(l:template)
    let l:new = substitute(l:new, '{tags}', l:e.tags, 'g')
    let l:new = substitute(l:new, '{q}', l:q, 'g')
    let l:new = substitute(l:new, '{a}', l:a, 'g')
    let l:new = substitute(l:new, "  \n", "\n\n", 'g')
    call append(line('.')-1, split(l:new, "\n") + [''])
  endfor
  silent execute line('.') . 'd'

  keepjumps call cursor(l:lnum_start, 1)

  update
endfunction

" }}}1
]]
