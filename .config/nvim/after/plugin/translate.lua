if PackerPluginLoaded("translate.nvim") then
vim.cmd([[
nnoremap <space>tre :<C-u>Translate RU -output=floating<CR>
xnoremap <space>tre :Translate RU -output=floating<CR>
nnoremap <space>trs :<C-u>Translate RU -output=split<CR>
xnoremap <space>trs :Translate RU -output=split<CR>
nnoremap <space>tri :<C-u>Translate RU -output=insert<CR>
xnoremap <space>tri :Translate RU -output=insert<CR>
nnoremap <space>trr :<C-u>Translate RU -output=replace<CR>
xnoremap <space>trr :Translate RU -output=replace<CR>

nnoremap <space>tee :<C-u>Translate EN -output=floating<CR>
xnoremap <space>tee :Translate EN -output=floating<CR>
nnoremap <space>tes :<C-u>Translate EN -output=split<CR>
xnoremap <space>tes :Translate EN -output=split<CR>
nnoremap <space>tei :<C-u>Translate EN -output=insert<CR>
xnoremap <space>tei :Translate EN -output=insert<CR>
nnoremap <space>ter :<C-u>Translate EN -output=replace<CR>
xnoremap <space>ter :Translate EN -output=replace<CR>
]])
end
