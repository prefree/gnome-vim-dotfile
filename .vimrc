execute pathogen#infect()
""""""""""""""""""""""""""vundle""""""""""""""""""""""""""""""""""
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
"set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-airline/vim-airline'

call vundle#end()            " required
filetype plugin indent on    " required

"""""""""""""""""""""""solarized theme"""""""""""""""""""""""""
syntax enable
set background=dark
colorscheme solarized

"""""""""""""""""""""""base setting start"""""""""""""""""""""""""
syntax on
set rnu
set ignorecase
set nobackup
set noswapfile
set hlsearch
set cursorline
"highlight CursorLine  ctermbg=DarkCyan ctermfg=black
set cc=81

"disable vi
set nocompatible
set backspace=indent,eol,start

set tabstop=4
set shiftwidth=4
"set fdm=syntax
" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

"""""""""""""""""""""""base setting end"""""""""""""""""""""""""

"""""""""""""""""""""""Taglist start""""""""""""""""""""""""""""
let Tlist_Exit_OnlyWindow = 1
let Tlist_Auto_Open = 1
nnoremap <silent> <F8> :TlistToggle<CR>
"""""""""""""""""""""""Taglist end""""""""""""""""""""""""""""""
" key mappings for NERD Tree
let NERDTreeWinPos = "right"
let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
nnoremap <silent> <F7> :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>
"map <C-e> <plug>NERDTreeToggle<CR>

"""""""""""""""""""""""CtrlP"""""""""""""""""""""""""""""""""""
let g:ctrlp_max_height = 40
let g:ctrlp_match_window = 'top'

set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux

let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

"YouCompleteMe
let g:ycm_server_python_interpreter='/usr/bin/python2.7'
let g:ycm_global_ycm_extra_conf='~/.ycm_extra_conf.py'
let g:ycm_seed_identifiers_with_syntax = 1
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>" |
"
"""""""""""""""""""""""cscope""""""""""""""""""""""""""""""""""
if has("cscope")
    set csprg=/usr/bin/cscope
    set csto=1
    set cst
    set cscopequickfix=s-,c-,d-,i-,t-,e-
    set nocsverb
    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
    endif
    set csverb
endif
"nnoremap <silent> <F3> :cope 20<CR>
nnoremap <silent> <F4> :cclose<CR>

" key mappings for cscope
nmap <leader>s :cs find s <C-R>=expand("<cword>")<CR><CR>:top copen 20<CR>
nmap <leader>g :cs find g <C-R>=expand("<cword>")<CR><CR>:top copen 20<CR>
nmap <leader>c :cs find c <C-R>=expand("<cword>")<CR><CR>:top copen 20<CR>
nmap <leader>t :cs find t <C-R>=expand("<cword>")<CR><CR>:top copen 20<CR>
nmap <leader>e :cs find e <C-R>=expand("<cword>")<CR><CR>:top copen 20<CR>
nmap <leader>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <leader>i :cs find i <C-R>=expand("<cfile>")<CR><CR>
nmap <leader>d :cs find d <C-R>=expand("<cword>")<CR><CR>:top copen 20<CR>


