""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Profiling
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Run the following commands in order to check what's making your vim slow.
" :profile start profile.log
" :profile func *
" :profile file *
"" At this point do slow actions
" :profile pause

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim-plug Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" :PlugList, :PlugInstall, :PlugClean, :PlugSearch
set nocompatible
filetype off

call plug#begin()
" NOTE that some of these plugins will not properly work if
" the editor is not macvim.
" Use 'brew install macvim --with-override-system-vim' command
" to properly install macvim on OSX.

" Installing YCM - install again if 'ycm server shut down' error occurs
" cd ~/.vim/bundle/YouCompleteMe
" ./install.py --clang-completer --tern-completer
" or, to enable all features,
" ./install.py --all
Plug 'Valloric/YouCompleteMe'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'  " themes for airline
Plug 'edkolev/tmuxline.vim'  " apply airline-synced theme to tmux
Plug 'junegunn/fzf'  " fuzzy finder
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'  " surround functions
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'ntpeters/vim-better-whitespace'  " whitespace hleper
Plug 'mileszs/ack.vim'  " use silver searcher
Plug 'altercation/vim-colors-solarized'  " solarized colorscheme for vim
Plug 'w0rp/ale'  " asynchronous linter - vim8 required - use either syntastic or ale not both

" All of your plugins must be added before the following line
call plug#end()
filetype plugin on
filetype indent on
syntax enable

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Basic Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" formattings and editor functionalities
set number  " line number
" `relativenumber` disabled due to slow scrolling (multiple regex function execution happening)
" set relativenumber  
set autoindent
set cindent
set tabstop=2  " tab = 2 spaces
set expandtab  " expand tab into spaces
set shiftwidth=2
set shiftround  " round indents to multiple of shiftwidth
set ruler  " indicate current position of cursor
set showcmd	 " show incomplete commands
set wildmenu  " allow autocompletion with <tab>
set encoding=utf-8
set term=xterm-256color  " enables airline within tmux
set backspace=2  " make backspace work normally
set showmatch  " show matching brackets when text indicator is over them
set mat=2  " 0.2sec to blink on matching brackets
set laststatus=2  " show status line at all times
set scrolloff=5
set title  " change terminal's title
set mouse=a  " enable mouse in all modes

" no annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=  " visual bell

" searching
set smartcase
set hlsearch  " highlight search (:noh<cr> to disable)
set incsearch  " immediately highlight seraches
" map <space> to search, Ctrl-<space> to backwards search
" map <space> /
" map <c-space> ?

" advanced
set autowrite  " auto write when going off to other files
set autoread  " auto read in when modified outside
set nobackup
set noswapfile  " no .swp files!
" hides buffers instead of closing - doesn't force you to apply the changes
set hidden
set lazyredraw  " buffers screen updates for fast scrolling
" the below two options will show certain characters (tabs, trailing
" spaces, extends, nbsp) with provided characters
set list
set listchars=tab:>-
set ttyfast  " used for fast redrawing (*removed feature in NeoVim)

" misc
set history=700  " remember up to n histories
set timeoutlen=500  " timeout length on mappings and key codes
" marks remembered for last 100 files, 3000 line limit to yank,
" registers with more than 100kB text are skipped
set viminfo='100,<3000,s100

" Return to last edit position when opening files (You want this!)
" WOWW
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" locality and security
set exrc  " if found, use local .vimrc
set secure  " restrict some commands in non-default .vimrc

set nopaste  " default is nopaste
set pastetoggle=<F10>  " map paste toggle key
" this is set because 'paste' disables all mappings

" disable sound on errors on MacVim
if has("gui_macvim")
    autocmd GUIEnter * set vb t_vb=
endif

" if ag is available, use it over :grep
" use :copen, :cn, :cp, :cclose, :cr<num> to navigate / open quickfix
" also find :cdo, :argdo, :bufdo for executions across files
" NOTE: navigation using :cn or :cp will not work
" if ag-backed grep is applied on a single file '%' (current file),
" because ag will not show the file name.
" use :vimgrep or simply search using '/'
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor\ --column
  set grepformat=%f:%l:%c%m
endif

" collect open buffers
function! BuffersList()
  let all = range(0, bufnr('$'))
  let res = []
  for b in all
    if buflisted(b)
      call add(res, bufname(b))
    endif
  endfor
  return res
endfunction

" [!] prevents vimgrep from moving cursor to the first matching result
function! GrepBuffers(expression)
  exec 'vimgrep!/'.a:expression.'/ '.join(BuffersList())
endfunction

" bind K to grep word under cursor for all open buffers
nnoremap K :call GrepBuffers("<C-R><C-W>")<CR>

" Delete trailing white space on save!!!
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.c,*.cc,*.js,*.py,*.sh,*.json,*.cpp,*.go,*.h,*.hpp,*hs :call CleanExtraSpaces()
endif

" dependencies and paths
set tags=./tags,tags,../tags,../../tags
" set path variable for searching include files
set path=.,..,/usr/local/include,/Library/Frameworks
" search sub-directories recursively from current working directory when finding files
set path+=**
" ignore when searching files
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/\.git/*,*DS_Store*,*/node_modules/*  " OSX/Linux

" must have solarized.vim file in '~/.vim/colors' directory
" can be done by installing 'altercation/vim-colors-solarized' package
let g:solarized_termcolors=256  " needed for terminal vims (non-GUI vims)
set background=dark
colorscheme solarized

" TIPS
" <using help>
" for vim-script keywords:
" :h 'expandtab'
"
" <show end of line>
" :set list (:set nolist to disable)
"
" <inserting digraphs>
" :dig or i_CTRL-k
"
" view contents in macro
" :put <register>
"
" see histories
" command line history
" :his c
" command line history window
" q:
" search history
" :his s
"
" set the previous context mark
" m` or m'
" mark position at register a
" :ma a
" move position to register a
" `a
" go to previous context mark
" '' or ``
"
" finding file (vim default)
" :find .vimrc
"
" view the full path of file
" :echo expand("%:p")
" only the name
" :echo expand("%")
" 
" opening quickfix
" :cc
"
" opening location list
" :lopen

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" goes down one 'visual' line
nmap j gj
" goes up one 'visual' line
nmap k gk
nmap <F2> :bp<CR>
nmap <F3> :bn<CR>
nmap <F4> :make!<CR>
nmap <F6> :NERDTreeToggle<CR>
nmap <F7> :nohl<CR>
nmap <F8> :!ctags -R .<CR>
" or use a command
command! MakeTags !ctags -R .
" use ^] to jump immediately, use g^] for ambiguous tags

" leader mapping
let mapleader = ","
let g:mapleader = ","

" map Ctrl-c to behave the same as <ESC> (<C-c> will not trigger InsertLeave event)
" <Esc> is pressed twice since it will wait for 'timeoutlen' millisecs
" in case there is a mapping with <Esc>.
inoremap <C-c> <Esc><Esc>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" snippets!!
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" invoke read command, (with no extra line '-1') and move the cursor
" to wanted position
nnoremap ,html :-1read $HOME/.vim/skel/html<CR>3jwf>a
" python main
nnoremap ,pyma :-1read $HOME/.vim/skel/pymain<CR>jA
" python docstring
nnoremap ,pydoc :-1read $HOME/.vim/skel/pydoc<CR>j


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Nerdtree Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let NERDTreeIgnore=['\.pyc$', '\~$']  " ignore these files in NERDTree


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" YouCompleteMe Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" YCM has to be compiled before using!
" use --clang-compeleter option
"
" maps GoTo command. It goes to most reasonable of eithr : declaration or
" definition.
" It populates vim's jumplist so that we can go back and forward using
" <C-O> and <C-I>, respectively.
nnoremap <leader>jd :YcmCompleter GoTo<CR>
nnoremap <leader>jr :YcmCompleter GoToReference<CR>
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_key_list_select_completion=['<TAB>', '<Down>']
let g:ycm_key_list_previous_completion=['<S-TAB>', '<Up>']
let g:ycm_key_detailed_diagnostics='<leader>d'
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_confirm_extra_conf = 1
let g:ycm_python_binary_path = 'python3'  " semanic completion based on executable interpreter
let g:ycm_server_python_interpreter = '/usr/local/bin/python3'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" airline settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Enable ycm support
let g:airline#extensions#ycm#enabled = 1
" set error count prefix >
let g:airline#extensions#ycm#error_symbol = 'E:'
" set warning count prefix >
let g:airline#extensions#ycm#warning_symbol = 'W:'
" theme
let g:airline_theme='luna'
" compatible with fugitive
let g:airline#extension#branch#enabled = 1


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" [LEGACY - 2018.06] tmuxline settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" enable all display options
" let g:tmuxline_preset = 'full'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" better whitespace option
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
highlight ExtraWhitespace ctermbg=0xFF0000


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" [LEGACY - 2018.06] ctrlp options
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" cache for performance
" let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
" use system ag when available - THIS IS SICK!
" if executable('ag')
"   let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
" endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ack.vim options
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" use ag instead of ack if available
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
" uncomment below if you don't want to jump to first result instantly
" cnoreabbrev Ack Ack!
" nnoremap <leader>a :Ack!<Space>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" syntastic settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" below are default settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

