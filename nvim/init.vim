""
" Make it simple as possible. You will not be able to use all of the prepared features.
" Make it explicit as possible. Plugins for completion will be with you.
"

""
" Path
"
let g:python3_host_prog="$VIRTUAL_ENV/bin/python3"

""
" Plugin w/vim-plug
"
call plug#begin('~/.config/nvim/plugged')
Plug 'davidhalter/jedi-vim'
Plug 'scrooloose/nerdtree'
Plug 'cohama/lexima.vim'
call plug#end()

" NERDTree
set modifiable

""
" Encoding
"
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis,cp932
set fileformats=unix,dos,mac

""
" Visualization
"

" Color Scheme
colorscheme iceberg

" Syntax analysis
filetype on
syntax on

" Row number
set number
set cursorline

" Multibyte letters
set ambiwidth=double

" Invisible letters
set list
set listchars=tab:-\ ,trail:_,eol:$,extends:>,precedes:<,nbsp:%

" Spaces & Tab visualization
if has("syntax")
  " For POD-bug
  syn sync fromstart
  function! ActivateInvisibleIndicator()
    " '　' for Em space 
    syntax match InvisibleJISX0208Space "　" display containedin=ALL
    highlight InvisibleJISX0208Space term=underline ctermbg=darkblue guibg=darkgray gui=underline
  endfunction
  augroup invisible
    autocmd! invisible
    autocmd BufNew,BufRead * call ActivateInvisibleIndicator()
  augroup END
endif

""
" Accessibility
"

" Clipboard accessibility
"set clipboard=unnamed,autoselect   "for classic vim
set clipboard+=unnamedplus          "for neovim

" Backspace-setting
set backspace=indent,eol,start

" Indent
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent

" Disable auto-indent when pasting
if &term =~ "xterm"
    let &t_ti .= "\e[?2004h"
    let &t_te .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    noremap <special> <expr> <Esc>[200~ XTermPasteBegin("0i")
    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
    cnoremap <special> <Esc>[200~ <nop>
    cnoremap <special> <Esc>[201~ <nop>
endif

""
" Python
"

" Indent
autocmd FileType python setl autoindent
autocmd FileType python setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType python setl tabstop=8 expandtab shiftwidth=4 softtabstop=4
