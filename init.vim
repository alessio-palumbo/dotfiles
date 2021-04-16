call plug#begin("~/.config/nvim/plugged")
  " Plugin Section

  " Theme
  " Plug 'dracula/vim'
  Plug 'tomasr/molokai'

  " File manager
  Plug 'scrooloose/nerdtree'
  Plug 'ryanoasis/vim-devicons'
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
  "  Plug 'Xuyuanp/nerdtree-git-plugin'

  " Fancy vim startup page
  Plug 'mhinz/vim-startify'

  " Delete buffers
  Plug 'moll/vim-bbye'

  " Fuzzy search
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'

  " Git
  Plug 'tpope/vim-fugitive'

  " Git diff and more
  Plug 'airblade/vim-gitgutter'

  " Wakatime
  Plug 'wakatime/vim-wakatime'

  " Unix commands
  Plug 'tpope/vim-eunuch'
    " :Delete: Delete a buffer and the file on disk simultaneously.
    " :Unlink: Like :Delete, but keeps the now empty buffer.
    " :Move: Rename a buffer and the file on disk simultaneously.
    " :Rename: Like :Move, but relative to the current file's containing directory.
    " :Chmod: Change the permissions of the current file.
    " :Mkdir: Create a directory, defaulting to the parent of the current file.
    " :Cfind: Run find and load the results into the quickfix list.
    " :Clocate: Run locate and load the results into the quickfix list.
    " :Lfind/:Llocate: Like above, but use the location list.
    " :Wall: Write every open window. Handy for kicking off tools like guard.
    " :SudoWrite: Write a privileged file with sudo.
    " :SudoEdit: Edit a privileged file with sudo.

  " Autopair
  Plug 'jiangmiao/auto-pairs'
    " System Shortcuts:
    " <CR>  : Insert new indented line after return if cursor in blank brackets or quotes.
    " <BS>  : Delete brackets in pair
    " <M-p> : Toggle Autopairs (g:AutoPairsShortcutToggle)
    " <M-e> : Fast Wrap (g:AutoPairsShortcutFastWrap)
    " <M-n> : Jump to next closed pair (g:AutoPairsShortcutJump)
    " <M-b> : BackInsert (g:AutoPairsShortcutBackInsert)
    " If <M-p> <M-e> or <M-n> conflict with another keys or want to bind to another keys, add
    " let g:AutoPairsShortcutToggle = '<another key>'
    " to .vimrc, if the key is empty string '', then the shortcut will be disabled.

    " Multi line selection/editing
    " Plug 'mg979/vim-visual-multi', {'branch': 'master'}
    " Basic usage:
    " select words with Ctrl-N (like Ctrl-d in Sublime Text/VS Code)
    " create cursors vertically with Ctrl-Down/Ctrl-Up
    " select one character at a time with Shift-Arrows
    " press n/N to get next/previous occurrence
    " press [/] to select next/previous cursor
    " press q to skip current and get next occurrence
    " press Q to remove current cursor/selection
    " start insert mode with i,a,I,A

  " Surrounding text
  Plug 'tpope/vim-surround'
    " Examples:
    " cs"'   => changes " to '
    " cs'<q> => changes ' to <q>, cst' => revert tag to '
    " ds"    => removes delimiters
    " ysiw]  => wraps entire word with ] (use [ to add space in between)
    " cs]}   => changes ] to } (use { to aadd space in between
    " yssb/yss) => wraps entire line in ) (use ( to add space in between)
    " ysiw<em>  => wraps entire word in between <em> tags
    " V+S<p class="important"> => wraps entire sentence in <p> tag

  " Comment code
  Plug 'scrooloose/nerdcommenter'

  " Airline (disabled as slows things down)
  " Plug 'vim-airline/vim-airline'

  " Lighter airline with tabline
  Plug 'itchyny/lightline.vim'
  Plug 'mengelbrecht/lightline-bufferline'

  " Parenthesis
  Plug 'luochen1990/rainbow'
  let g:rainbow_active = 1

  " Indenting
  " Plug 'yggdroot/indentline'
  " let g:indentLine_setConceal = 0
  " let g:indentLine_char_list = ['|', '¦', '┆', '┊']

  Plug 'nathanaelkane/vim-indent-guides'
  let g:indent_guides_guide_size = 1
    " Use <Leader>ig to toggle (current mapping: nmap <silent> <Leader>ig <Plug>IndentGuidesTogglebu)
    " let g:indent_guides_enabled_on_vim_startup = 1
    " let g:indent_guides_auto_colors = 0
    " autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#00005f   ctermbg=17
    " autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#000087 ctermbg=18
    " autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd guibg=#0087df ctermbg=32
    " autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#005f00 ctermbg=33
    " hi x017_NavyBlue ctermfg=17 guifg=#00005f
    " hi x018_DarkBlue ctermfg=18 guifg=#000087

  " Trailing space
  Plug 'bronson/vim-trailing-whitespace'
    " Usage: FixWhitespace to clear all

  " Css colours
  Plug 'ap/vim-css-color'

  " Code completion
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  let g:coc_global_extensions = [
    \'coc-git',
    \'coc-emmet',
    \'coc-html',
    \'coc-css',
    \'coc-json',
    \'coc-prettier',
    \'coc-eslint',
    \'coc-tsserver',
    \'coc-tslint-plugin',
    \'coc-yank',
    \'coc-pyright'
    \]

  " Format for C languages (C, C++, Obj-C, Js, Java, Ts, Protobuf)
  Plug 'rhysd/vim-clang-format'

  " Tags
  " Plug 'vim-scripts/taglist.vim'

  " Go plugin
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

  " Rust
  Plug 'rust-lang/rust.vim'
  " Plug 'racer-rust/vim-racer'

  " Js, Ts and Jsx
  Plug 'pangloss/vim-javascript'
  Plug 'leafgarland/typescript-vim'
  Plug 'maxmellon/vim-jsx-pretty'

  " Ruby
  Plug 'vim-ruby/vim-ruby'
  Plug 'tpope/vim-rails'

call plug#end()

" ---------------------------------------------
" ### Config Section ###
" ---------------------------------------------

" ---------------------------------------------
" ### Enable theming support
" ---------------------------------------------

if (has("termguicolors"))
  set termguicolors
endif

" ---------------------------------------------
" ### Theme
" ---------------------------------------------

syntax enable
colorscheme molokai
highlight Normal guibg=black guifg=white

" ---------------------------------------------
" Rainbow parens
" ---------------------------------------------

" # Junegunn configs
"let g:rainbow#max_level = 16
"let g:rainbow#pairs = [['(', ')'], ['[', ']']]
"" List of colors that you do not want. ANSI code or #RRGGBB
"let g:rainbow#blacklist = [233, 234]

" ---------------------------------------------
" ### Navigation
" ---------------------------------------------

set tabstop=4
set shiftwidth=4
set expandtab
"set softtabstop=4

" Keep editing line in the center of the screen (excluding terminal)
augroup VCenterCursor
  au!
  au BufEnter,WinEnter,WinNew,VimResized *,*.*
    \ if &buftype != 'terminal' | let &scrolloff=winheight(win_getid())/2 | endif
augroup END

" File specific rules
autocmd FileType json setlocal ts=2 sw=2 expandtab
autocmd FileType javascript setlocal ts=2 sw=2 expandtab
autocmd FileType proto setlocal ts=2 sw=2 expandtab
autocmd FileType go setlocal ts=8 sw=8

" Remap escape
inoremap jk <Esc>
tnoremap jk <C-\><C-n>
inoremap jj <Esc>o
" Add mapping to go to end of line when in insert mode
inoremap <C-e> <C-o>A

" Map save to vscode ctrl+s
inoremap <silent> <C-s> <Esc>:w<Cr>
nnoremap <silent> <C-s> :w<Cr>

" Put a line break under the cursor
nnoremap <silent> <leader>n a<Cr><Esc>

" set diffopt+=verical
set cursorline " highlight line the curson is on
set copyindent " copy original indentation on autoindeting

set number relativenumber
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END

" use enter to clear search highlighting
nnoremap <silent> <CR> :nohlsearch<CR>

" Remap up and down to avoid skipping wrapped lines
nnoremap j gj
nnoremap k gk

" Use C + navigation keys for wider movements.
nnoremap <C-j> }
nnoremap <C-k> {
nnoremap <C-h> 2b
nnoremap <C-l> 2e

" Shortcut to open init.vim
nnoremap <silent> <leader>cf :e $MYVIMRC<CR>

" Clear whitespace
nnoremap <silent> <leader>ww :FixWhitespace<CR>

" Copy\Paste clip shortcuts
vnoremap <silent> <leader>y "+y
vnoremap <silent> <leader>p "+p
nnoremap <silent> <leader>p "+p

if has('unix') && !has('macunix')
  set clipboard=unnamedplus
else
  set clipboard=unnamed
endif

" Enable mouse
set mouse=a

" ---------------------------------------------
" ### General settings
" ---------------------------------------------

" When editing a file, always jump to the last cursor position
autocmd BufReadPost *
  \ if ! exists("g:leave_my_cursor_position_alone") |
  \ if line("'\"") > 0 && line ("'\"") <= line("$") | " use relative number in normal mode
  \ exe "normal g'\"" |
  \ endif |
  \ endif

" Set local directory to the pwd of the open buffer. (This allows both
" terminal and NERDTree to sync with the current file)
autocmd BufEnter * silent! lcd %:p:h

" Remove highlighting or matched parens which is pretty congfusing
" let loaded_matchparen = 1
" Invert current paren  highlighting as it is confusing
hi MatchParen ctermfg=blue ctermbg=black guifg=lightblue guibg=black term=none cterm=none gui=italic

" Use persistent history.
" if !isdirectory("/tmp/.vim-undo-dir")
    " call mkdir("/tmp/.vim-undo-dir", "", 0700)
" endif
" set undodir=/tmp/.vim-undo-dir
set undofile
set noswapfile
set ignorecase "ignore case when searching
set smartcase  "ignore case unless a capital letter is used
set title titlestring=%<%F titlelen=70

"-- Whitespace highlight --
" match ExtraWhitespace /\s\+$/
" autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
" autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
" autocmd InsertLeave * match ExtraWhitespace /\s\+$/
" autocmd BufWinLeave * call clearmatches()

" TODO AutoPairs plugin - Do not use on vim files to avoid commented line to
" collapse on each other when deleting a comment
" au FileType vim let b:AutoPairs = ''

" ---------------------------------------------
" ### Vim-startify
" ---------------------------------------------

let g:startify_session_dir = '~/.config/nvim/session'
let g:startify_session_persistence = 1

" Save session before exit if unsaved, to cater for involontary :q when
" multiple tabs are open. Do not save if only startify buffer is open.
autocmd VimLeave * if (v:this_session == "" && len(getbufinfo({'buflisted':1})) > 0) | :SS! aaa-temp-session | endif

let g:startify_lists = [
  \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
  \ { 'type': 'sessions',  'header': ['   Sessions']       },
  \ { 'type': 'files',     'header': ['   MRU']            },
  \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
  \ { 'type': 'commands',  'header': ['   Commands']       },
  \ ]

let g:startify_bookmarks = [ {'v': '~/.config/nvim/init.vim'}, {'z': '~/.zshrc'} ]

" ---------------------------------------------
" ### NERDTree configs - Ctrl+B to toggle
" ---------------------------------------------

let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''
let NERDTreeHighlightCursorline = 0

" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Toggle NERDTree in current buffer dir.
nnoremap <silent> <C-b> :NERDTreeToggle %<CR>

" Toggle NERDTree in VCS root directory, if available.
" nnoremap <silent> <C-b> :NERDTreeToggle %<CR>

" ---------------------------------------------
"  ### Buffers
" ---------------------------------------------

function! DeleteBuffer()
  if &buftype ==# 'terminal'
    let current_window = winnr()
      Bdelete!
      " Remove current split after closing a split terminal, unless it's the
      " main window.
    if (current_window != 1 && winnr() == current_window) | q! | endif
  else
      Bdelete
  endif
endfunction

map <silent> <leader>q :call DeleteBuffer()<CR>
map <silent> <leader>!q :Bdelete!<CR>

" ---------------------------------------------
"  ### Lightline + Bufferline
" ---------------------------------------------

set noshowmode
set showtabline=2

let g:lightline = {
  \ 'colorscheme': 'one',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'branch', 'readonly', 'filename', 'modified' ] ]
  \ },
  \ 'component_function': {
  \   'branch': 'LightlineFugitive',
  \   'filetype': 'LightlineFiletype',
  \   'fileformat': 'LightlineFileformat',
  \   'readonly': 'LightlineReadonly',
  \   'modified': 'LightlineModified',
  \ },
  \ 'tabline': {
  \   'left': [ ['buffers'] ],
  \   'right': [ ['close'] ]
  \ },
  \ 'component_expand': {
  \   'buffers': 'lightline#bufferline#buffers'
  \ },
  \ 'component_type': {
  \   'buffers': 'tabsel'
  \ },
  \ 'separator': { 'left': '', 'right': '' },
  \ 'subseparator': { 'left': '', 'right': '' }
  \ }

function! LightlineFugitive()
  if exists('*fugitive#head')
    let branch = fugitive#head()
    return branch !=# '' ? ' '.branch : ''
  endif
  return fugitive#head()
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! LightlineFileformat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

function! LightlineModified()
  return &modified ? '●' : ''
endfunction

function! LightlineReadonly()
  return &readonly ? '' : ''
endfunction

let g:lightline#bufferline#show_number = 2
let g:lightline#bufferline#enable_nerdfont = 1
let g:lightline#bufferline#enable_devicons = 1
let g:lightline#bufferline#unicode_symbols = 1
let g:lightline#bufferline#number_map = {
\ 0: '⁰', 1: '¹', 2: '²', 3: '³', 4: '⁴',
\ 5: '⁵', 6: '⁶', 7: '⁷', 8: '⁸', 9: '⁹'}

" Enable click on tabs.
if has('tablineat')
  let g:lightline#bufferline#clickable = 1
  let g:lightline.component_raw = {'buffers': 1}
endif

nmap <Leader>1 <Plug>lightline#bufferline#go(1)
nmap <Leader>2 <Plug>lightline#bufferline#go(2)
nmap <Leader>3 <Plug>lightline#bufferline#go(3)
nmap <Leader>4 <Plug>lightline#bufferline#go(4)
nmap <Leader>5 <Plug>lightline#bufferline#go(5)
nmap <Leader>6 <Plug>lightline#bufferline#go(6)
nmap <Leader>7 <Plug>lightline#bufferline#go(7)
nmap <Leader>8 <Plug>lightline#bufferline#go(8)
nmap <Leader>9 <Plug>lightline#bufferline#go(9)
nmap <Leader>0 <Plug>lightline#bufferline#go(10)

nmap <BS>1 <Plug>lightline#bufferline#delete(1)
nmap <BS>2 <Plug>lightline#bufferline#delete(2)
nmap <BS>3 <Plug>lightline#bufferline#delete(3)
nmap <BS>4 <Plug>lightline#bufferline#delete(4)
nmap <BS>5 <Plug>lightline#bufferline#delete(5)
nmap <BS>6 <Plug>lightline#bufferline#delete(6)
nmap <BS>7 <Plug>lightline#bufferline#delete(7)
nmap <BS>8 <Plug>lightline#bufferline#delete(8)
nmap <BS>9 <Plug>lightline#bufferline#delete(9)
nmap <BS>0 <Plug>lightline#bufferline#delete(10)

nmap <silent><TAB> :bnext<CR>
nmap <silent><S-TAB> :bprev<CR>

" ---------------------------------------------
"  ### Airline + Tabline
" ---------------------------------------------

" Mode is already shown by the airline so hide it
" set noshowmode
" let g:airline_powerline_fonts = 1
" let g:airline_extensions = ['branch', 'tabline']
" let g:airline#extensions#tagbar#enabled = 0
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#buffer_nr_show = 0
" let g:airline#extensions#tabline#buffer_idx_mode = 1
" nmap <leader>1 <Plug>AirlineSelectTab1
" nmap <leader>2 <Plug>AirlineSelectTab2
" nmap <leader>3 <Plug>AirlineSelectTab3
" nmap <leader>4 <Plug>AirlineSelectTab4
" nmap <leader>5 <Plug>AirlineSelectTab5
" nmap <leader>6 <Plug>AirlineSelectTab6
" nmap <leader>7 <Plug>AirlineSelectTab7
" nmap <leader>8 <Plug>AirlineSelectTab8
" nmap <leader>9 <Plug>AirlineSelectTab9
" nmap <leader>- <Plug>AirlineSelectPrevTab
" nmap <leader>= <Plug>AirlineSelectNextTab

" ---------------------------------------------
" ### Split panes
" ---------------------------------------------

" Notes:
" * use :vs# to reopen the last closed split
" * use :<C w> + the following to change windows position:
"   * <C hjkl> to move the current window in the given direction
"   * <C r> to rotate windows
"   * <C q> to close the current split
"   * <C o> to close all split but the current one (:on has the same effect)

" open new split panes to right and below
set splitright
set splitbelow

" use alt+hjkl to move between split/vsplit panels
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
inoremap <A-h> <C-\><C-N><C-w>h
inoremap <A-j> <C-\><C-N><C-w>j
inoremap <A-k> <C-\><C-N><C-w>k
inoremap <A-l> <C-\><C-N><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" ---------------------------------------------
" ### Integrated terminal - Ctrl+N
" ---------------------------------------------

" start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif

" Open terminal split in current directory
function! OpenTerminal()
  split term://zsh
  resize 15
endfunction
" let $LOCAL_DIR=expand('%:p:h')
nnoremap <silent> ts :call OpenTerminal()<CR>

" start terminal in new buffer
nnoremap <silent> tt :edit term://zsh<CR>

" add terminal to tab list
let g:airline#extensions#tabline#ignore_bufadd_pat = '!defx|gundo|nerd_tree|startify|tagbar|undotree|vimfiler'

" turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>

" edit file from the directory the terminal is currently in
tnoremap <C-N> cdv<CR><C-\><C-n>:e<space>
" maintain behavior of mapping above for normal buffer
nnoremap <C-N> :e<space>


" Change terminal window local directory to the terminal working directory
" when called.
fu Tapi_lcd(buf, cwd) abort
    if has('nvim')
        exe 'lcd '..a:cwd
        return ''
    endif
    let winid = bufwinid(a:buf)
    if winid == -1 || empty(a:cwd)
        return
    endif
    call win_execute(winid, 'lcd '..a:cwd)
endfu

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
" ----------------------------------
" let g:terminal_color_0  = '#2e3436'
" let g:terminal_color_1  = '#cc0000'
" let g:terminal_color_2  = '#4e9a06'
" let g:terminal_color_3  = '#c4a000'
let g:terminal_color_4  = '#22A9F1'
" let g:terminal_color_5  = '#75507b'
" let g:terminal_color_6  = '#0b939b'
" let g:terminal_color_7  = '#d3d7cf'
" let g:terminal_color_8  = '#555753'
" let g:terminal_color_9  = '#ef2929'
" let g:terminal_color_10 = '#8ae234'
" let g:terminal_color_11 = '#fce94f'
" let g:terminal_color_12 = '#729fcf'
" let g:terminal_color_13 = '#ad7fa8'
" let g:terminal_color_14 = '#00f5e9'
" let g:terminal_color_15 = '#eeeeec'
" ----------------------------------

" ---------------------------------------------
" ### Fzf
" ---------------------------------------------

" fp => git root of project, ff => current dir, fh => home dir, fr => root dir
nnoremap fp :ProjectFiles<CR>
nnoremap ff :Files<CR>
nnoremap fh :Files $HOME<CR>
nnoremap fr :Files /<CR>

" # require silversearcher-ag
nnoremap fg :ProjectAg<CR>
nnoremap fa :Ag<CR>
nnoremap fi :AgIn<space>

" Check git commit history
nnoremap fc :Commits<CR>
" Check git status
nnoremap fs :GFiles?<CR>

" change default floating window to bottom split
" let g:fzf_layout = { 'down': '~40%' }

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \}

" # require ripgrep
" let $FZF_DEFAULT_COMMAND = 'rg --files --no-ignore-vcs --hidden'
let $FZF_DEFAULT_COMMAND = 'rg --files --follow --hidden --glob !.git'

" Use git root if project is inside a git repo
function! s:find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

command! ProjectFiles execute 'Files' s:find_git_root()

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

" Call ag from git root
command! -nargs=* ProjectAg
  \ call fzf#vim#ag(<q-args>, extend(s:find_git_root(), g:fzf_layout))

" Call ag at the specified subpath/ or git root subpath
function! s:ag_in(...)
  call fzf#vim#ag(join(a:000[1:], ' '), extend({'dir': a:1}, g:fzf_layout))
endfunction

command! -nargs=+ -complete=dir AgIn call s:ag_in(<f-args>)

" ---------------------------------------------
" ### coc.vim default settings
" ---------------------------------------------

" if hidden is not set, TextEdit might fail.
set hidden
" Better display for messages
set cmdheight=2
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=100
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr>
  \ pumvisible() ? coc#_select_confirm() :
  \ "\<C-g>u\<CR>"
" Add the following for formatting code after selection
" \<c-r>=coc#on_enter()\<CR>

" Use `[c` and /`]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos (Use <C-o> to go back, <C-i> to go next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Avoid leaving buffers opened after looking up definitions
function! GoBackAndClose()
  let prev_buffer = bufnr()
  execute "normal \<C-O>"
  let curr_buffer = bufnr()
  if curr_buffer != prev_buffer
    execute "bd " . prev_buffer
  endif
endfunction
" Use gb to go back after go to definition
nnoremap <silent> gb :call GoBackAndClose()<CR>
map gf <C-i>

" Vscode-like multi word selection
" nmap <expr> <silent> <C-d> <SID>select_current_word()
" function! s:select_current_word()
  " if !get(b:, 'coc_cursors_activated', 0)
    " return "\<Plug>(coc-cursors-word)"
  " endif
  " return "*\<Plug>(coc-cursors-word):nohlsearch\<CR>"
" endfunc

" Use U to show documentation in preview window
nnoremap <silent> U :call <SID>show_documentation()<CR>

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" ---------------------------------------------
" ### Coc-plugins
" ---------------------------------------------

" #### MarkMap (Currently not working)
" Create markmap from the whole file
nmap <Leader>m <Plug>(coc-markmap-create)
" Create markmap from the selected lines
vmap <Leader>m <Plug>(coc-markmap-create-v)

" ---------------------------------------------
" ### vim-go
" ---------------------------------------------

" disable vim-go :GoDef short cut (gd)
" this is handled by LanguageClient [LC]
let g:go_def_mapping_enabled = 0

" filetype plugin indent on
set autowrite

" syntax highlighting
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators= 1

" Auto formatting and importing
let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"

" Status line types/signatures
let g:go_auto_type_info = 1

" Add go pls support
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

" Run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

" Map keys for most used commands.
" Ex: `\b` for building, `\r` for running and `\b` for running test.
autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
autocmd FileType go nmap <leader>r  <Plug>(go-run)
" autocmd FileType go nmap <leader>t  <Plug>(go-test)
" Run go test for function under cursor
autocmd FileType go nmap <leader>t  <Plug>(go-test-func)

" Automatically add/remove json tags to Go structs.
autocmd FileType go nmap <silent>tg :GoAddTags<CR>
autocmd FileType go nmap <silent>tr :GoRemoveTags<CR>

" ---------------------------------------------
"  ### git gutter
" ---------------------------------------------

let g:gitgutter_set_sign_backgrounds = 0
let g:gitgutter_show_msg_on_hunk_jumping = 1
nmap ]g <Plug>(GitGutterNextHunk)
nmap [g <Plug>(GitGutterPrevHunk)

" ---------------------------------------------
" ### NERDCommenter
" ---------------------------------------------

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Remap comment toggle
nnoremap <silent> cm :call NERDComment(0,"toggle")<CR>
vnoremap <silent> cm :call NERDComment(0,"toggle")<CR>

" ---------------------------------------------
"  ### NERDTree
" ---------------------------------------------

" NERDTree File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
  exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
  exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')

" ---------------------------------------------
" ############ Neovim Defaults #############
" ---------------------------------------------
" - Syntax highlighting is enabled by default
" - ":filetype plugin indent on" is enabled by default
"
" - 'autoindent' is enabled
" - 'autoread' is enabled
" - 'background' defaults to "dark" (unless set automatically by the terminal/UI)
" - 'backspace' defaults to "indent,eol,start"
" - 'backupdir' defaults to .,~/.local/share/nvim/backup (|xdg|)
" - 'belloff' defaults to "all"
" - 'compatible' is always disabled
" - 'complete' excludes "i"
" - 'cscopeverbose' is enabled
" - 'directory' defaults to ~/.local/share/nvim/swap// (|xdg|), auto-created
" - 'display' defaults to "lastline,msgsep"
" - 'encoding' is UTF-8 (cf. 'fileencoding' for file-content encoding)
" - 'fillchars' defaults (in effect) to "vert:│,fold:·,sep:│"
" - 'formatoptions' defaults to "tcqj"
" - 'fsync' is disabled
" - 'history' defaults to 10000 (the maximum)
" - 'hlsearch' is enabled
" - 'incsearch' is enabled
" - 'langnoremap' is enabled
" - 'langremap' is disabled
" - 'laststatus' defaults to 2 (statusline is always shown)
" - 'listchars' defaults to "tab:> ,trail:-,nbsp:+"
" - 'nrformats' defaults to "bin,hex"
" - 'ruler' is enabled
" - 'sessionoptions' includes "unix,slash", excludes "options"
" - 'shortmess' includes "F", excludes "S"
" - 'showcmd' is enabled
" - 'sidescroll' defaults to 1
" - 'smarttab' is enabled
" - 'startofline' is disabled
" - 'tabpagemax' defaults to 50
" - 'tags' defaults to "./tags;,tags"
" - 'ttimeoutlen' defaults to 50
" - 'ttyfast' is always set
" - 'viewoptions' includes "unix,slash"
" - 'undodir' defaults to ~/.local/share/nvim/undo (|xdg|), auto-created
" - 'viminfo' includes "!"
" - 'wildmenu' is enabled
" - 'wildoptions' defaults to "pum,tagfile"
