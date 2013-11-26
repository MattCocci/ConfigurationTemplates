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
set scrolloff=8		"When the page begins to scroll, keep a buffer 
			   " beween the cursor and the top or botton of 
			   " the page

set shiftwidth=4	"Changes the size of the tab
set softtabstop=4
set autoindent 
filetype indent on 
set tabstop=4
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
set t_Co=256		" Expands the color set and makes gvim and 
			   " vim look better
set background=dark
"let g:solarized_termcolors=256
colorscheme solarized	" Colorscheme for GVIM
let mapleader=','	" Makes the leader character , instead of \


" Save all backup files with ~ suffix to a central file that's
"   out of view, but there just in case
set backupdir=~/.vimbackups,.


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


" Allow for toggling between color schemes for solarized
map <F9> :set background=light<CR>:let solarized_termtrans=0<CR>:colorscheme solarized<CR>
map <F6> :set background=dark<CR>:let solarized_termtrans=0<CR>:colorscheme solarized<CR>


" All for jumping by display lines, not just physical lines
nnoremap j gj
nnoremap k gk

"=================================================================
"=========== OTHER STUFF I DON'T REALLY USE/KNOW =================
"=================================================================


" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

filetype plugin on


