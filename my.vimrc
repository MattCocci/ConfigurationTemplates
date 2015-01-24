" Matt Cocci's .vimrc file 

" To use, copy to
"     for Unix:  ~/.vimrc
"     for MS-DOS and Win32:  $VIM\_vimrc



"===================================================================
"================ PATHOGEN =========================================
"===================================================================

" execute pathogen#infect()
" execute pathogen#helptags()


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
"set nowrap		" Don't wrap lines
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
let mapleader=','	" Makes the leader character , instead of \


" Save all backup files with ~ suffix to a central file that's
"   out of view, but there just in case
set backupdir=~/.vimbackups,.


" Sets folding for indendented blocks for use with python
set foldmethod=indent
set foldlevel=99
set tw=72           " Set width of text to 80
set hidden          " allow hidden buffers

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


"<Ctrl-l> Redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>

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

"===================================================================
"================ COLORS AND SOLARIZED =============================
"===================================================================
"
set t_Co=256		" Expands the color set and makes gvim and 
			   " vim look better
set background=dark
"let g:solarized_termcolors=256
colorscheme solarized	" Colorscheme for GVIM

" Allow for toggling between color schemes for solarized
map <F9> :set background=light<CR>:let solarized_termtrans=0<CR>:colorscheme solarized<CR>
map <F6> :set background=dark<CR>:let solarized_termtrans=0<CR>:colorscheme solarized<CR>

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
