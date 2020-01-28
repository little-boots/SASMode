" SASmode core functions

" DESC: Check variable and set default value if it exists
fun! sasmode#default(name, default) "{{{
    if !exists(a:name)
        let {a:name} = a:default
        return 0
    endif
    return 1
endfunction "}}}

" DESC: Import python libs
fun! sasmode#init(plugin_root, paths) "{{{
    call sasmode#wide_message("Loading Python...")

    python3 import sys, saspy, vim
    let command = join(["python3", "try:", "    import pandas", "except ImportError:", "   pass"], "\n")
    execute(command)
    python3 sys.path.insert(0, vim.eval('a:plugin_root'))
    python3 sys.path = vim.eval('a:paths') + sys.path
endfunction "}}}

" TODO: Figure out why this doesn't work
" DESC: Make a connection to the default SAS server
fun! sasmode#connect(...) "{{{
    call sasmode#wide_message("Connecting to SAS...")

    if a:0 > 0
        execute ("python3 sas = saspy.SASsession(". a:0 . ")")
    else
        python3 sas = saspy.SASsession()
    endif
endfunction "}}}

" TODO: Flesh this out (handle log and listing)
" DESC: Run SAS code
fun! sasmode#run(visual) "{{{
    let l:log = []
    let l:list = []

    " Pull text into n buffer, then replace the buffer
    if a:visual
        let l:code = s:getVisualSelection()
    else
        let l:code = join(getline(1, "$"), "\n")
    endif

    call sasmode#wide_message("Code running...")
    
    try
        execute ("python3 sas.submit(r\'\'\'" . shellescape(l:code) . "\'\'\')")
    catch /E234/
        echohl Error | echo "Run-time error." | echohl none
    endtry
endfunction "}}}

" DESC: Make a connection to the default SAS server
fun! sasmode#full_log() "{{{
   python3 print(sas.saslog())
endfunction "}}}

" DESC: Show wide message
fun! sasmode#wide_message(msg) "{{{
    let x=&ruler | let y=&showcmd
    set noruler noshowcmd
    redraw
    echohl Debug | echo strpart("[SASmode] " . a:msg, 0, &columns-1) | echohl none
    let &ruler=x | let &showcmd=y
endfunction "}}}

fun! sasmode#quit() "{{{
    augroup sasmode
        au! * <buffer>
    augroup END
endfunction "}}}

"""""""""""""""""""""""""""
" HELP THE HELPER FUNCTIONS
"""""""""""""""""""""""""""

" I don't think the context is working properly.  This refuses to reset.
" DESC: Grab visually selected text
" Taken from https://stackoverflow.com/questions/1533565/how-to-get-visually-selected-text-in-vimscript
fun! s:getVisualSelection()
    " Why is this not a built-in Vim script function?!
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    return join(lines, "\n")
endfunction

"""""""""""""""""""""""""""""""""""""
" NEED TO UPDATE THIS FOR SAS
"""""""""""""""""""""""""""""""""""""

"" DESC: Show error
"fun! pymode#error(msg) "{{{
"    execute "normal \<Esc>"
"    echohl ErrorMsg
"    echomsg "[Pymode]: error: " . a:msg
"    echohl None
"endfunction "}}}
"
"" DESC: Open quickfix window
"fun! pymode#quickfix_open(onlyRecognized, maxHeight, minHeight, jumpError) "{{{
"    let numErrors = len(filter(getqflist(), 'v:val.valid'))
"    let numOthers = len(getqflist()) - numErrors
"    if numErrors > 0 || (!a:onlyRecognized && numOthers > 0)
"        let num = winnr()
"        botright copen
"        exe max([min([line("$"), a:maxHeight]), a:minHeight]) . "wincmd _"
"        if a:jumpError
"            cc
"        elseif num != winnr()
"            wincmd p
"        endif
"    else
"        cclose
"    endif
"    redraw
"    if numOthers > 0
"        call pymode#wide_message(printf('Quickfix: %d(+%d)', numErrors, numOthers))
"    elseif numErrors > 0
"        call pymode#wide_message(printf('Quickfix: %d', numErrors))
"    endif
"endfunction "}}}
"
"" DESC: Open temp buffer.
"fun! pymode#tempbuffer_open(name) "{{{
"    pclose
"    exe g:pymode_preview_position . " " . g:pymode_preview_height . "new " . a:name
"    setlocal buftype=nofile bufhidden=delete noswapfile nowrap previewwindow
"    redraw
"endfunction "}}}
"
"fun! pymode#save() "{{{
"    if &modifiable && &modified
"        try
"            noautocmd write
"        catch /E212/
"            call pymode#error("File modified and I can't save it. Please save it manually.")
"            return 0
"        endtry
"    endif
"    return expand('%') != ''
"endfunction "}}}
"
"fun! pymode#quit() "{{{
"    augroup pymode
"        au! * <buffer>
"    augroup END
"endfunction "}}}
