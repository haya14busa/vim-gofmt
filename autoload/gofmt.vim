"=============================================================================
" FILE: autoload/gofmt.vim
" AUTHOR: haya14busa
" License: MIT license
"=============================================================================
scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim

function! gofmt#fmt(formatters) abort
  if empty(a:formatters)
    return
  endif
  let fmts = deepcopy(a:formatters)
  for i in range(len(fmts)-1)
    let fmts[i].next = fmts[i+1]
  endfor
  call s:fmt(fmts[0])
endfunction

function! s:fmt(formatter) abort
  let t = tempname()
  let tmpfile = t . '.go'
  call rename(t, tmpfile)
  call writefile(getline(1, '$'), tmpfile)

  let handler = s:handler.new()
  let handler.formatter = a:formatter
  let handler.changedtick = b:changedtick
  let handler.winsaveview = winsaveview()
  let handler.tmpfile = tmpfile

  let cmd = [a:formatter.cmd] + a:formatter.args + [tmpfile]
  call job_start(cmd, {
  \   'err_cb': handler.on_err,
  \   'exit_cb': handler.on_exit,
  \ })
endfunction

let s:handler = {}

function! s:handler.new() abort
  return deepcopy(s:handler)
endfunction

function! s:handler.on_exit(...) abort
  if b:changedtick != self.changedtick
    return s:fmt(self.formatter)
  endif
  :% delete
  call setline(1, readfile(self.tmpfile))
  call winrestview(self.winsaveview)
  call delete(self.tmpfile)
  if has_key(self.formatter, 'next')
    call s:fmt(self.formatter.next)
  endif
endfunction

function! s:handler.on_err(_, msg) abort
  echom printf('fmt err: %s', a:msg)
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
" __END__
" vim: expandtab softtabstop=2 shiftwidth=2 foldmethod=marker
