let g:sasmode_version = "0.1"

" Enable SASmode by default
call sasmode#default('g:sasmode', 1)

" DESC: Disable script loading
if !g:sasmode || &cp || &diff
    " Update SASmode status to prevent loading in other files and adding this
    " condition to all of them.
    let g:sasmode = 0
    finish
endif

" Vim Python interpreter. Needs python3 to work.
if !has("python3")
    echom "Python3 support not detected.  SASmode is aborting."
    finish
endif

" OPTIONS: {{{

" Disable pymode warnings
call sasmode#default('g:sasmode_warning', 1)

" Enable/disable python motion operators
" TODO: Leaving this here as a reminder this is an option
" call sasmode#default("g:sasmode_motion", 1)

" Maximal height of sasmode quickfix window
call sasmode#default('g:sasmode_quickfix_maxheight', 6)

" Minimal height of sasmode quickfix window
call sasmode#default('g:sasmode_quickfix_minheight', 3)

" Height of preview window
call sasmode#default('g:sasmode_preview_height', &previewheight)

" Position of preview window
" This is giving problems
"sasmode#default('g:sasmode_preview_position', 'botright')

" Key map for run SAS code
call sasmode#default('g:sasmode_run_bind', '<leader>r')

" Key map for initialize Python
call sasmode#default('g:sasmode_init_bind', '<leader>i')
"
" Key map for connecting to SAS session
call sasmode#default('g:sasmode_connect_bind', '<leader>c')

" Additional python paths
call sasmode#default('g:sasmode_paths', [])

" Initialize Python dependencies whenever any SAS file is opened
call sasmode#default('g:sasmode_autoinit', 0)

" Connect to SAS session whenever any SAS file is opened
call sasmode#default('g:sasmode_autoconnect', 0)

" }}}

" Prepare to plugin loading
if &compatible
    set nocompatible
endif
filetype plugin on

let s:cpo_save = &cpo
set cpo&vim

let &cpo = s:cpo_save
unlet s:cpo_save
