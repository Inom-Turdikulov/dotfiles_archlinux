if PackerPluginLoaded("zeavim.vim") then
    vim.cmd [[
        nmap <leader>zh <Plug>Zeavim
        vmap <leader>zh <Plug>ZVVisSelection
    ]]
end
