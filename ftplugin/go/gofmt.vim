"=============================================================================
" FILE: ftplugin/go/gofmt.vim
" AUTHOR: haya14busa
" License: MIT license
"=============================================================================
scriptencoding utf-8
if expand('%:p') ==# expand('<sfile>:p')
  unlet! b:did_ftplugin_go_gofmt
endif
if exists('b:did_ftplugin_go_gofmt')
  finish
endif
let b:did_ftplugin_go_gofmt = 1
let s:save_cpo = &cpo
set cpo&vim

let s:default_formatters = [
\   { 'cmd': 'gofmt', 'args': ['-s', '-w'] },
\   { 'cmd': 'goimports', 'args': ['-w'] },
\ ]

command! Fmt call gofmt#fmt(get(g:, 'gofmt_formatters', s:default_formatters))

let &cpo = s:save_cpo
unlet s:save_cpo
" __END__
" vim: expandtab softtabstop=2 shiftwidth=2 foldmethod=marker
