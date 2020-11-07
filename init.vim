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
 Plug 'moll/vim-bbye'

 " Vinegar
 " Plug 'tpope/vim-vinegar'

 " Fuzzy search
 Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
 Plug 'junegunn/fzf.vim'

 " Git
 Plug 'tpope/vim-fugitive'

 " Git diff and more
 Plug 'airblade/vim-gitgutter'

 " Unix commands
  Plug 'tpope/vim-eunuch'

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
 Plug 'mg979/vim-visual-multi', {'branch': 'master'}
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

 Plug 'vim-airline/vim-airline'

 " Parenthesis
 " Plug 'junegunn/rainbow_parentheses.vim'
 Plug 'luochen1990/rainbow'
 let g:rainbow_active = 1

 " Indenting
 Plug 'yggdroot/indentline'

 " Trailing space
 Plug 'bronson/vim-trailing-whitespace'
 " Usage: FixWhitespace to clear all

 " # Emmet html/css/js
 " Plug 'mattn/emmet-vim'
 " # Css colours
 " Plug 'ap/vim-css-color'

 " Code completion
 Plug 'neoclide/coc.nvim', {'branch': 'release'}
 let g:coc_global_extensions = ['coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier', 'coc-tsserver']

 " Go plugin
 Plug 'fatih/vim-go'

 " Rust
 Plug 'rust-lang/rust.vim'
 " Plug 'racer-rust/vim-racer'

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
"set softtabstop=4
"set expandtab=4

" Remap escape
inoremap jk <Esc>

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
nnoremap <silent> <CR> :nohlsearch<CR><CR>

" Remap up and down to avoid skipping wrapped lines
"nnoremap j gj
"nnoremap k gk

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

" Remove highlighting or matched parens which is pretty congfusing
" let loaded_matchparen = 1
" Invert current paren  highlighting as it is confusing
hi MatchParen ctermfg=blue ctermbg=black guifg=lightblue guibg=black term=none cterm=none gui=italic
"-- Whitespace highlight --
" match ExtraWhitespace /\s\+$/
" autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
" autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
" autocmd InsertLeave * match ExtraWhitespace /\s\+$/
" autocmd BufWinLeave * call clearmatches()

" ---------------------------------------------
" ### File explorer configs - Ctrl+B toggle (nerdreee & vim-devicons)
" ---------------------------------------------

let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''

" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Toggle
nnoremap <silent> <C-b> :NERDTreeToggle<CR>

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9

nnoremap <Leader>q :Bdelete<CR>

" ---------------------------------------------
" ### Split panes
" ---------------------------------------------

" Notes:
" * use :vs# to reopen the last closed split
" * use :<C w> + the following to change windows position:
"   * <C hjkl> to move the current window in the given direction
"   * <C r> to rotate windows

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

" open terminal on ctrl+n
function! OpenTerminal()
  split term://zsh
  resize 10
endfunction
nnoremap tt :call OpenTerminal()<CR>

" turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>

" ---------------------------------------------
" Fzf - Ctrl+P to search
" ---------------------------------------------

" nnoremap <C-p> :FZF<CR>
nnoremap f :FZF<CR>
nnoremap F :FZF<Space>

" change default floating window to bottom split
" let g:fzf_layout = { 'down': '~40%' }

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \}


" # require silversearcher-ag
" used to ignore gitignore files
" let $FZF_DEFAULT_COMMAND = 'ag -g ""'
" # require ripgrep
" let $FZF_DEFAULT_COMMAND = 'rg --files --no-ignore-vcs --hidden'
let $FZF_DEFAULT_COMMAND = 'rg --files --follow --hidden -g !.git'

" ---------------------------------------------
" ### coc.vim default settings
" ---------------------------------------------

" if hidden is not set, TextEdit might fail.
set hidden
" Better display for messages
set cmdheight=2
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
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

" Use `[c` and /`]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos (Use <C-o> to go back, <C-i> to go next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

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
autocmd FileType go nmap <leader>t  <Plug>(go-test)

" ---------------------------------------------
" ### Add spaces after comment delimiters by default
" ---------------------------------------------
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Remap comment toggle
nnoremap <silent> cm :call NERDComment(0,"toggle")<CR>
vnoremap <silent> cm :call NERDComment(0,"toggle")<CR>

" ---------------------------------------------
"  ### git gutter
" ---------------------------------------------

let g:gitgutter_set_sign_backgrounds = 0
let g:gitgutter_show_msg_on_hunk_jumping = 1
nmap ]g <Plug>(GitGutterNextHunk)
nmap [g <Plug>(GitGutterPrevHunk)

" ---------------------------------------------
"  ### NERDTree
" ---------------------------------------------

" NERDTress File highlighting
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
