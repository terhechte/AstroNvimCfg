" Use ,c to copy to the macos clipboard (in terminal)
" This copies the current visual selection (not terminal mouse selection)
noremap <leader>c "+y<CR>gv

" Allow copy paste in neovim
let g:neovide_input_use_logo = 1
map <D-v> "+p<CR>
map! <D-v> <C-R>+
tmap <D-v> <C-R>+
vmap <D-c> "+y<CR> 
