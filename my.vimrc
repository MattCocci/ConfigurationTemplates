" Matt Cocci's .vimrc file

" To use, copy to
"     for Unix:  ~/.vimrc
"     for MS-DOS and Win32:  $VIM\_vimrc



"===================================================================
"================ PATHOGEN =========================================
"===================================================================

execute pathogen#infect()
execute pathogen#helptags()


"===================================================================
"================ GENERAL ==========================================
"===================================================================


set nocompatible	      " Use Vim settings, rather than Vi
				 					" settings (much better!). This must
				 					" be first, because it changes other
				 					" options as a side effect.

syntax on					" Allows syntax highlighting
filetype plugin on		" allows plugins & indenting to run
set hlsearch
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set history=500		" keep 50 lines of command line history
set undolevels=500	" Allow lots of undoing
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set wrapscan		" sets the search scan to wrap around the file
set scrolloff=2		"When the page begins to scroll, keep a buffer
			   " beween the cursor and the top or botton of
			   " the page

set shiftwidth=2	"Changes the size of the tab
set softtabstop=2
autocmd FileType make setlocal noexpandtab " Don't make tabs spaces if writing a Makefile
set autoindent
filetype indent on
set tabstop=2
set expandtab
set shiftround
set mouse=a		" Enable the mouse
set number		" Put line numbers
set nowrap		" Don't wrap lines
set linebreak		" Don't break midword when wrapping lines
set ignorecase		" Ignore case in the search string
set smartcase		" UNLESS there are capitals in search string
set noswapfile		" So I'm not bothered by annoying ass swap files
			   "  and recovery prompts every time I try to use
			   "  gvim for latex
set visualbell		" No beeping/sound
set splitbelow		" New splits below current window
set splitright		" New splits to the right
set noerrorbells	" No beeping/sound

" Makes the leader character , instead of \
let mapleader=','

" Save all backup files with ~ suffix to a central file that's
"   out of view, but there just in case
set backupdir=~/.vimbackups,.


" Sets folding for indendented blocks for use with python
set foldmethod=indent
set foldlevel=99
set hidden          " allow hidden buffers

" Set the line width for gq and add a dark line to mark 80 chars
set fo=cq           " Don't wrap automatically, except for comments
set tw=72           " If using gq, rewrap text to 72 chars wide
if (exists('+colorcolumn'))
  set colorcolumn=80
  highlight ColorColumn ctermbg=9
endif

" Set up tex concealing
set cole=2
let g:tex_conceal="adgm"


"===================================================================
"================ OTHER SETTINGS ===================================
"===================================================================

" Spellchecking enabled, but not by default
if version >= 700
	set spl=en spell
	set nospell
endif

" Sets the default filetypes and formats for gvim and latex-suite
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_MultipleCompileFormats='pdf, aux'

" Switch easily between relative and absolute line numbering
function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc
nnoremap <C-n> :call NumberToggle()<cr>


"=================================================================
"=========== REMAPS ==============================================
"=================================================================


"Remap jj to escape insert mode
inoremap jj <Esc>
nnoremap JJJJ <Nop>

" Swap 0 to ^, and vice versa the first character of the line
nnoremap 0 ^
nnoremap ^ 0

" Don't use Ex mode, use Q for formatting
map Q gq


" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" This allows for easier copying to the clipboard by hitting \y
   " while \yy will yank an entire line
noremap <leader>y "+y
noremap <leader>yy "+Y

" This allows for easier pasting from the clipboard by hitting \p
   " also preserves indentation
noremap <leader>p :set paste<CR>:put  *<CR>:set nopaste<CR>

" But because pasting can get weird with autoindenting, you add
" this way to switch to past mode so things don't get autoindented
" and screwed up
set pastetoggle=<F2>


" All for jumping by display lines, not just physical lines
nnoremap j gj
nnoremap k gk
nnoremap 0 g0
nnoremap $ g$

" Shorter split navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Keep codeblocks highlighted when indenting and dedenting
"vnoremap > >gv
"vnoremap < <gv

"===================================================================
"================ COLORS AND SOLARIZED =============================
"===================================================================

set background=dark
colorscheme solarized	" Colorscheme for GVIM

" Highlight all occurrences of the variable under the cursor
function! HighlightUnderCursor()
  " Only do this for certain filetypes when the cursor is held on a a
  " word for 750 units of time
  setl updatetime=750
  autocmd CursorHold *.py,*.m,*.c,*.R
    \ exe printf('match IncSearch /\V\<%s\>/', escape(expand('<cword>'), '/\'))
endfunction
autocmd CursorMoved * call HighlightUnderCursor()

"=======================================================================
"================ syntastic ============================================
"=======================================================================

" Syntax checking on by default; 'active_filetypes' bc syntastic is
" active (by defult) for all filetypes. 'passive_filetypes' has html as
" an example, which turns off syntax checking for html by defualt.
let g:syntastic_mode_map = { 'mode': 'active',
  \ 'active_filetypes': [],
  \ 'passive_filetypes': ['html'] }

" Better :sign interface symbols
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '!'

" Ignore annoying latex errror about @ in macro names that I get because
" of the right-justification of numbers in matrices
let g:syntastic_quiet_messages = { "regex": "Do not use @ in LaTeX macro names"}

"=======================================================================
"================ vim-airline ==========================================
"=======================================================================

" Always open airline, even if windows not split
set laststatus=2

" Set the theme
"let g:airline_theme = 'powerlineish'
"let g:airline_theme = 'wombat'
let g:airline_theme = 'tomorrow'

" With only one tab open, show buffers
let g:airline#extensions#tabline#enabled = 1

" Turn off warnings about trailing whitespace
let g:airline#extensions#whitespace#enabled = 0

" Change the separators
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#right_sep = ' '
let g:airline#extensions#tabline#right_alt_sep = '|'

" Set up the symbols to use
  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif
  "let g:airline_left_sep = '▶'
  "let g:airline_right_sep = '◀'
  let g:airline_left_sep = '»'
  let g:airline_right_sep = '«'
  let g:airline_symbols.linenr = '␤'
  let g:airline_symbols.branch = '⎇'

" Shorter names for the mode I'm in
  let g:airline_mode_map = {
      \ '__' : '-',
      \ 'n'  : 'N',
      \ 'i'  : 'I',
      \ 'R'  : 'R',
      \ 'c'  : 'C',
      \ 'v'  : 'V',
      \ 'V'  : 'V',
      \ '' : 'V',
      \ 's'  : 'S',
      \ 'S'  : 'S',
      \ '' : 'S',
      \ }


"=======================================================================
"== neocomplcache, neosnippet, jedi-vim ================================
"=======================================================================

" General Neocomplecache settings
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1

" Tab to complete down in popup menu; k to complete up
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr> k pumvisible() ? "\<C-P>" : "k"

" Use jedi as the autocomplete function for python files
if !exists('g:neocomplcache_omni_functions')
  let g:neocomplcache_omni_functions = {}
endif
let g:neocomplcache_omni_functions['python'] = 'jedi#completions'

" Don't let jedi auto-select first item by default
let g:jedi#popup_on_dot = 0

" Call omni function when pattern below matches (pattern 'something.').
" This will force neocomplcache to call jedi when you see 'np.' 'sympy.'
" etc in python
if !exists('g:neocomplcache_force_omni_patterns')
  let g:neocomplcache_force_omni_patterns = {}
endif
let g:neocomplcache_force_omni_patterns['python'] = '[^. \t]\.\w*'
let g:neocomplcache_force_overwrite_completefunc = 1

" So jedi-vim doesn't split the current window and show documentation
set completeopt=menuone

""imap neosnippet#expandable() ? "(neosnippet_expand_or_jump)" : pumvisible() ? "" : ""
""smap neosnippet#expandable() ? "(neosnippet_expand_or_jump)" :


"=======================================================================
"== unite.vim ==========================================================
"=======================================================================

" Enable yank history and fuzzy matching
let g:unite_source_history_yank_enable = 1
call unite#filters#matcher_default#use(['matcher_fuzzy'])

" Browse files in current wording directory (non-recursive), with
" settings:
" - Start in insert mode, so typing further refines the candidate list
" - Display right in the same window rather than splitting
" - Show previews of the code you are selecting
nnoremap <space>F :<C-u>Unite -start-insert -no-split -auto-preview -buffer-name=files file<CR>

" Same as above, but recursive
nnoremap <space>f :<C-u>Unite -start-insert -no-split -auto-preview -buffer-name=files file_rec<CR>

" For searching through buffers
nnoremap <space>j :<C-u>Unite -start-insert -no-split -buffer-name=buffer buffer<CR>

" For searching through yank history
nnoremap <leader>uy :<C-u>Unite history/yank<CR>

" Map jj to Escape for unite; TAB to select next; wrapped in a function
" so these mappings are only used when I'm in a unite buffer; otherwise,
" it will try to put (unite_insert_leave) in the document I'm editing
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()"{{{
  imap <buffer> jj <Plug>(unite_insert_leave)
  imap <buffer> <TAB> <Plug>(unite_select_next_line)
endfunction"}}}



"=======================================================================
"================ Julia-Vim ============================================
"=======================================================================


" Ctrl+t to set a latex name to unicode character
inoremap <C-t> <C-X><C-O>

" Turn off suggestions so it doesn't interfere with neocomplcache
let g:latex_to_unicode_suggestions = 0

" Toggling latex to unicode on and off for any arbitrary file type
noremap <expr> <leader>t LaTeXtoUnicode#Toggle()

