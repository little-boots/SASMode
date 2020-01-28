" Vim syntax file
" Language:     SAS
" Maintainer:   Zhen-Huan Hu <wildkeny@gmail.com>
" Original Maintainer: James Kidd <james.kidd@covance.com>
" Version:      3.0.0
" Last Change:  Aug 26, 2017
"

if version < 600
  syntax clear
elseif exists('b:current_syntax')
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

syn case ignore

" Define default highlighting
"hi def link sasComment Comment

" Syncronize from beginning to keep large blocks from losing
" syntax coloring while moving through code.
syn sync fromstart

let b:current_syntax = "sas"

" Default
" syn match defaultNote '^[^ 0-9].*$\{-}'  
syn match defaultNote '^.*$\{-}'  

" TODO: Add recognized SAS output (e.g., proc datasets)
" TODO: Alternatively, have NOTE (etc.) output end with new text or two blank rows?

" GridHelper markup
syn region ghMarkup start='!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!' end='!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'

" System markup
syn region codeNumbers start='^\d\+\s\+[+!]\?' end='$\{-}' matchgroup=codeNumbers contains=codeLine
syn region codeLine start='^\d\+\s\+[+!]\?'ms=e+1 end='$\{-}' contained
syn match pageBreak '^\?.*The SAS System\s\+.*\d\{4}$'

" Special cases that may start with a number
" syn match numberNote '\d\+ rows.*$\{-}' contains=pageBreak

" Log Notes/Warnings/Errors
syn region sasNote start='^NOTE:\?' skip='^.*The SAS System\s\+.*\d\{4}$' end='^\S'me=s-1 end='^\s*\n\s*\n'me=s-1 matchgroup=sasNote contains=noteText,pageBreak
syn region sasWarning start='^WARNING:\?' skip='^.*The SAS System\s\+.*\d\{4}$' end='^\S'me=s-1 end='^\s*\n\s*\n'me=s-1 matchgroup=sasWarning contains=noteText,pageBreak
syn region sasError start='^ERROR:\?' skip='^.*The SAS System\s\+.*\d\{4}$' end='^\S'me=s-1 end='^\s*\n\s*\n'me=s-1 matchgroup=sasError contains=noteText,pageBreak
syn region noteText start='^\(NOTE\|WARNING\|ERROR\):\?'hs=e+1 skip='^.*The SAS System\s\+.*\d\{4}$' end='^\S'me=s-1 end='^\s*\n\s*\n'me=s-1 contains=adverseNote,pageBreak contained
syn match adverseNote 'uninitialized\|repeats of\|not found\|not valid\|invalid\|overwritten\|division by zero\|converted to character\|truncated\|more than one\|missing values were generated\|special note\|\<w\.d\>' contained

" Figure out how to get NOTE: to display differently if there's an adverse error
"syn match adverseNoteHeader 'NOTE: \(.*uninitialized\|repeats of\|not found\|not valid\|invalid\|overwritten\|division\ by\ zero\|converted\ to\ character\|truncated\|more\ than\ one\|missing\ values\ were\ generated\|special\ note\|\<w\.d\>.*$\)\@='


hi def link pageBreak NonText
hi def link codeNumbers LineNr
hi def link codeLine Normal
hi def link adverseNote htmlBoldUnderline
hi def link noteText htmlBold
hi def link numberNote ModeMsg
hi def link sasNote Constant
hi def link sasWarning WarningMsg
hi def link sasError Error
hi def link ghMarkup Title
hi def link defaultNote ModeMsg
"hi def link adverseNoteHeader Error

let &cpo = s:cpo_save
unlet s:cpo_save
