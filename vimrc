" Basic settings
colorscheme industry

" COMMON SETTINGS  ------------------------------------------------------- {{{

" Disable compatibility with vi which can cause unexpected issues.
if &compatible
	set nocompatible
endif
"
" Enable type file detection. Vim will be able to try to detect the type of file in use.
filetype on

" Enable plugins and load plugin for the detected file type.
filetype plugin on


" Turn syntax highlighting on.
syntax on

" Highlight cursor line underneath the cursor horizontally.
set cursorline

" Highlight cursor line underneath the cursor vertically.
set cursorcolumn

" Show matching words during a search.
"set showmatch

" Use highlighting when doing a search.
"set hlsearch


" ---------------------------------------
" Indention
" ---------------------------------------
set smartindent
" Load an indent file for the detected file type.
filetype indent on
set shiftwidth=2

" ---------------------------------------
" Enable folder based configuration
" ---------------------------------------

silent! so .vimlocal

" Enable linenumbers
set relativenumber
" Enable current line number
set number
 
" Enable auto completion menu after pressing TAB.
" set wildmenu

" Make wildmenu behave like similar to Bash completion.
" set wildmode=list:longest

" There are certain files that we would never want to edit with Vim.
" Wildmenu will ignore files with these extensions.
" set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" }}}

" PLUGINS ---------------------------------------------------------------- {{{

" Load packager only when you need it
function! PackagerInit() abort
	packadd vim-packager
	call packager#init()
	call packager#add('kristijanhusak/vim-packager', { 'type': 'opt' })

	" Loaded only fpr specific filetypes on demand
	call packager#add('habamax/vim-asciidoctor' )

endfunction

" These commands are automatically added when using `packager#setup()`
command! -nargs=* -bar PackagerInstall call PackagerInit() | call packager#install(<args>)
command! -nargs=* -bar PackagerUpdate call PackagerInit() | call packager#update(<args>)
command! -bar PackagerClean call PackagerInit() | call packager#clean()
command! -bar PackagerStatus call PackagerInit() | call packager#status()



" }}}

" MAPPINGS --------------------------------------------------------------- {{{

" Mappings code goes here.

" }}}

" VIMSCRIPT -------------------------------------------------------------- {{{

" This will enable code folding.
" Use the marker method of folding.
augroup filetype_vim
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
augroup END

" More Vimscripts code goes here.

" }}}

" STATUS LINE ------------------------------------------------------------ {{{

" Status bar code goes here.

" }}}
