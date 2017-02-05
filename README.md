# vim-gofmt
[![LICENSE](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

vim-gofmt formats Go source code asynchronously with multiple Go formatters.

It's experimental and API may changes, but it should work.

## Usage

### :Fmt

`:Fmt` formats Go source code in current buffer using `g:gofmt_formatters`.

It runs asynchronously and doesn't block editing.

### g:gofmt_formatters

default:

```vim
let g:gofmt_formatters = [
\   { 'cmd': 'gofmt', 'args': ['-s', '-w'] },
\   { 'cmd': 'goimports', 'args': ['-w'] },
\ ]
```

Each formatters are used in consecutively in order of the list.

Example:

```
$ go get -u github.com/rhysd/gofmtrlx
$ go get -u github.com/haya14busa/go-typeconv/cmd/gotypeconv
```

```vim
let g:gofmt_formatters = [
\   { 'cmd': 'gofmtrlx', 'args': ['-s', '-w'] },
\   { 'cmd': 'goimports', 'args': ['-w'] },
\   { 'cmd': 'gotypeconv', 'args': ['-w'] },
\ ]
```

## :bird: Author
haya14busa (https://github.com/haya14busa)
