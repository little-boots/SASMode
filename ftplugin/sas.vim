" Vim filetype plugin file
" Language: SAS
" Maintainer: Chris Glessner <christopher_glessner@rhoworld.com>
" Homepage: (None)
" Last Change:	Wed, Jun 19, 2019 02:12PM

" Pymode had something like this, but I don't think I need it
" runtime ftplugin/sasmode.vim

" For the code below, I think I should use the code I already have (or something similar)
" I'm hoping it's not necessary to escape anything... though I could be wrong.

" Auto-load Python
if g:sasmode_autoinit || g:sasmode_autoconnect
    call sasmode#init(expand('<sfile>:p:h:h:h'), g:sasmode_paths)
endif

" Auto-connect SAS
if g:sasmode_autoconnect
    call sasmode#init(expand('<sfile>:p:h:h:h'), g:sasmode_paths)
    call sasmode#connect()
endif


" Run SAS code {{{

" TODO: See if you can use range more intelligently

command! -buffer -nargs=0 -range=% SASmodeRun call sasmode#run(0)
command! -buffer -nargs=0 -range=% SASmodeRunVisual call sasmode#run(1)

exe "nnoremap <silent> <buffer> " g:sasmode_run_bind ":SASmodeRun<CR>"
exe "vnoremap <silent> <buffer> " g:sasmode_run_bind ":SASmodeRunVisual<CR>"
" }}}
