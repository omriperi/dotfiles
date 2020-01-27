let g:python_host_prog = '/usr/bin/python2'

let g:python3_host_prog = '/usr/local/bin/python3'

set nocompatible
 
let s:editor_root=expand("~/.vim")

" From here - handling vunel
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
if has('mac')
    set rtp+=/usr/local/opt/fzf
else 
    set rtp+=~/.fzf
endif
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'junegunn/fzf.vim'
Plugin 'scrooloose/nerdtree'
Bundle 'nathanalderson/yang.vim'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'davidhalter/jedi-vim'
Plugin 'tpope/vim-fugitive'
Plugin 'majutsushi/tagbar'
Plugin 'wsdjeg/flygrep.vim'
Plugin 'dyng/ctrlsf.vim'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'w0rp/ale'
Plugin 'joshdick/onedark.vim'
Plugin 'romainl/vim-qf'
" NCMS
Plugin 'ncm2/ncm2'
Plugin 'roxma/nvim-yarp'
Plugin 'ncm2/ncm2-jedi'
Plugin 'ncm2/ncm2-bufword'
Plugin 'ncm2/ncm2-path'
call vundle#end()    

colorscheme onedark

" ncm2 settings
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=menuone,noselect,noinsert
set shortmess+=c
inoremap <c-c> <ESC>
" make it fast
let ncm2#popup_delay = 5
let ncm2#complete_length = [[1, 1]]
" Use new fuzzy based matches
let g:ncm2#matcher = 'substrfuzzy'

" Disable Jedi-vim autocompletion and enable call-signatures options
let g:jedi#auto_initialization = 1
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#smart_auto_mappings = 0
let g:jedi#popup_on_dot = 0
let g:jedi#completions_command = ""
let g:jedi#show_call_signatures = "1"

" === vim-airline ===
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='onedark'

" Emabling usage of plugins
filetype indent plugin on
 
" FlyGrep
let g:FlyGrep_search_tools = ['ag']
" Enable syntax highlighting
syntax on

" ale
let g:ale_linters = {
\   'python': ['pylint'],
\}
let g:ale_python_pylint_executable = "/usr/local/bin/pylint"
let b:ale_python_pylint_use_global = 1
let g:ale_cache_executable_check_failures = 1


""""" NETRW
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

"Prevent opening a file from fzf inside nerdtree buffer
nnoremap <silent> <expr> <Leader><Leader> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":FZF\<cr>"

" Setting relative number for vim
set relativenumber
 
" Enabling switching of windows without saving
set hidden
 
" Better command-line completion
set wildmenu
 
" Show partial commands in the last line of the screen
set showcmd
 
" Highlight searches (use <C-L> to temporarily turn off highlighting; see the
" mapping of <C-L> below)
set hlsearch
 
" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase
 
" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start
 
" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent
 
" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline
 
" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler
 
" Always display the status line, even if only one window is displayed
set laststatus=2
 
" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm
 
" Use visual bell instead of beeping when doing something wrong
set visualbell
 
" And reset the terminal code for the visual bell. If visualbell is set, and
" this line is also included, vim will neither flash nor beep. If visualbell
" is unset, this does nothing.
set t_vb=
 
" Enable use of the mouse for all modes
set mouse=a
 
" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=2
 
" Display line numbers on the left
set number
 
" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200
 
" Use <F11> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F11>
 
" Indentation options 
set shiftwidth=4
set softtabstop=4
set expandtab

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$

" Smooth scrolling


function! FZFOpen(command_str)
  if (expand('%') =~# 'NERD_tree' && winnr('$') > 1)
    exe "normal! \<c-w>\<c-w>"
  endif
  exe 'normal! ' . a:command_str . "\<cr>"
endfunction

nmap <C-N> :BufExplorer<CR>
nmap ,n :NERDTreeFind<CR>
nmap ,f :call FZFOpen(':FZF')<CR>

" Movement words
nmap ,w viwy<CR>

" Tag Bar
let g:tagbar_left = 1
let g:tagbar_show_linenumbers = 2
nmap ,t :TagbarToggle<CR>

" Quick Fix
map <C-G> :cn<CR>
noremap <c-f> :cp<CR>
map <C-0> :cp<CR>
nnoremap <silent>. <C-G> :cnext<CR><C-w>p



" General Navigation
nmap ,c :bd<CR>

"CtrlSF
nmap ,s <Plug>CtrlSFPrompt
" When using `dd` in the quickfix list, remove the item from the quickfix list.
function! RemoveQFItem()
  let curqfidx = line('.') - 1
  let qfall = getqflist()
  call remove(qfall, curqfidx)
  call setqflist(qfall, 'r')
  execute curqfidx + 1 . "cfirst"
  :copen
endfunction
:command! RemoveQFItem :call RemoveQFItem()
" Use map <buffer> to only map dd in the quickfix window. Requires +localmap
autocmd FileType qf map <buffer> dd :RemoveQFItem<cr>


" Mapping enter to open a new line
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>
"FZF

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'botright vsp' }
