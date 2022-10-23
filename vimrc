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
" set cursorcolumn

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
" Customize leader key to SPC
" ---------------------------------------
nnoremap <space> <noop>
let mapleader = ' '

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

    call packager#add('jremmen/vim-ripgrep')
    call packager#add('junegunn/fzf.vim')

    call packager#add('vimwiki/vimwiki')
    
    call packager#add('preservim/vim-markdown')

    " Loaded only for specific filetypes on demand
    call packager#add('habamax/vim-asciidoctor' )

    call packager#add('yegappan/lsp')


endfunction

" These commands are automatically added when using `packager#setup()`
command! -nargs=* -bar PackagerInstall call PackagerInit() | call packager#install(<args>)
command! -nargs=* -bar PackagerUpdate call PackagerInit() | call packager#update(<args>)
command! -bar PackagerClean call PackagerInit() | call packager#clean()
command! -bar PackagerStatus call PackagerInit() | call packager#status()


" LSP Activation ----------------- {{{
packadd lsp
let javaLangserver = $HOME .. '/opt/lspserver/jdt-language-server-1.9.0-202203031534'
let lspServers = [ 
\	{ 
\	'filetype': ['java'],
\	'path': javaLangserver .. '/bin/jdtls',
\	'args': ['-Declipse.application=org.eclipse.jdt.ls.core.id1',
\		'-Dosgi.bundles.defaultStartLevel=4',
\		'-Declipse.product=org.eclipse.jdt.ls.core.product',
\		'-Dlog.level=ALL',
\		'-noverify',
\		'-Xmx1G',
\		'--add-modules=ALL-SYSTEM',
\		'--add-opens java.base/java.util=ALL-UNNAMED',
\		'--add-opens java.base/java.lang=ALL-UNNAMED',
\		'-jar', './plugins/org.eclipse.equinox.launcher.gtk.linux.x86_64_1.2.400.v20211117-0650.jar',
\		'-data', $HOME .. '/dev/eclipse/ws',
\		'-configuration', javaLangserver .. '/config_linux'
\		],
\	'syncInit': v:true
\	}
\ ]
call LspAddServer(lspServers)

" }}}

" Vimwiki Konfiguration ------------------------------------------------ {{{
"
let g:vimwiki_list = [{'path': '~/dev/wiki/', 'path_html': '~/public_html/', 'syntax': 'markdown', 'ext':'.md', 'links_space_char':'_'}]
" let g:vimwiki_ext2syntax = { '.md':'markdown'}
let g:vimwiki_markdown_link_ext = 1


function! VimwikiLinkHandler(link)
try
  let browser = 'firefox'
  execute browser a:link
  return 1
catch
  echo "This can happen for a variety of reasons ..."
endtry
return 0
endfunction
" }}}

" }}}

" MAPPINGS --------------------------------------------------------------- {{{

" Mappings code goes here.

" edit my vimrc file
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
" source my vimrc file
nnoremap <leader>sv :source $MYVIMRC<cr>

"Surround current word with quotes
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>

" }}}

" VIMSCRIPT -------------------------------------------------------------- {{{

" This will enable code folding.
" Use the marker method of folding.
augroup filetype_vim
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
augroup END


" Erzeugt eine Zettelkastennotitzdatei
function! SaveWithTS(directory) range
  let dirname = "!mkdir -p " .. a:directory .. strftime("%Y/%m/%d/") 
    silent execute dirname
    execute "save " . a:directory . strftime("%Y/%m/%d/%H%M%S.adoc")
    redraw!
endfunction

" = Zettelkasten Commands
" Prerequisite: Textformat of notes is ASCIIDOC
" Write a new note
command! -nargs=0 Zkw call SaveWithTS('./notizen/')
" Find note by keyword
command! -nargs=+ Zkfk :execute 'lvimgrep /^:keywords:.*'.expand('<args>').'/j ./notizen/**/*.adoc'
" Find note by title
command! -nargs=+ Zkft :execute 'lvimgrep /^= .*'.expand('<args>').'/j ./notizen/**/*.adoc'
" Find note by textbody
command! -nargs=+ Zkfb :execute 'lvimgrep /.*'.expand('<args>').'/j ./notizen/**/*.adoc'

" More Vimscripts code goes here.

" }}}

" STATUS LINE ------------------------------------------------------------ {{{

" Status bar code goes here.

" }}}
