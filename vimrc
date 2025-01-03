
" COMMON SETTINGS  ------------------------------------------------------- {{{

" Basic settings
colorscheme murphy

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
" Indention. See :h indent
" ---------------------------------------
set smartindent
" Load an indent file for the detected file type.
filetype indent on
" Used by >
set shiftwidth=4
" Show tabs by 4 spaces
set tabstop=4
" Pressing tab inserts 4 spaces
set expandtab		


" ---------------------------------------
" Show options in a popupmenu
" ---------------------------------------
set wildmenu
set wildoptions=pum

" ---------------------------------------
" Customize leader key to SPC
" ---------------------------------------
nnoremap <Space> <Nop>
let mapleader = " "

"

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
" Packager had to be installes first
" git clone https://github.com/kristijanhusak/vim-packager ~/.vim/pack/packager/opt/vim-packager
" Load packager only when you need it
function! PackagerInit() abort
    packadd vim-packager
    call packager#init()
    call packager#add('kristijanhusak/vim-packager', { 'type': 'opt' })
"    call packager#add('tpope/vim-fugitive')
    call packager#add('jremmen/vim-ripgrep')
    call packager#add('junegunn/fzf.vim', {'requires': ['junegunn/fzf'] })

    call packager#add('vimwiki/vimwiki')
  
    call packager#add('preservim/vim-markdown')

    call packager#add('SirVer/ultisnips')
    call packager#add('honza/vim-snippets')

    " Loaded only for specific filetypes on demand
    call packager#add('habamax/vim-asciidoctor' )
	call packager#add('godlygeek/tabular')
    call packager#add('yegappan/lsp')


endfunction

" These commands are automatically added when using `packager#setup()`
command! -nargs=* -bar PackagerInstall call PackagerInit() | call packager#install(<args>)
command! -nargs=* -bar PackagerUpdate call PackagerInit() | call packager#update(<args>)
command! -bar PackagerClean call PackagerInit() | call packager#clean()
command! -bar PackagerStatus call PackagerInit() | call packager#status()

" Vim-Asciidoctor --------------- {{{

" Function to create buffer local mappings and add default compiler
let g:asciidoctor_folding = 1
let g:asciidoctor_fold_options = 1
let g:asciidoctor_foldtitle_as_h1 = 1
let g:asciidoctor_fenced_languages = ['java', 'bash', 'javascript', 'xml']
let g:asciidoctor_opener = '!google-chrome-stable'
fun! AsciidoctorMappings()
  nnoremap <buffer> <leader>oo :AsciidoctorOpenRAW<CR>
  nnoremap <buffer> <leader>p :AsciidoctorPasteImage<CR>
endfun

" Call AsciidoctorMappings for all `*.adoc` and `*.asciidoc` files
augroup asciidoctor
  au!
  au BufEnter *.adoc call AsciidoctorMappings()
augroup END

" }}}

" LSP Activation ----------------- {{{
if exists('*lsp#LspAddServer')
packadd lsp
let javaLangserver = $HOME .. '/opt/lspserver/jdt-language-server-1.9.0-202203031534'
let workspaceDir = $HOME .. '/dev/eclipse'
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
\		'-javaagent:' .. workspaceDir .. '/libs/lombok.jar',
\		'-jar', './plugins/org.eclipse.equinox.launcher.gtk.linux.x86_64_1.2.400.v20211117-0650.jar',
\		'-data', workspaceDir .. '/ws',
\		'-configuration', javaLangserver .. '/config_linux'
\		],
\	'syncInit': v:true
\	}
\ ]
  call LspAddServer(lspServers)
endif

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

" Follow Link
nnoremap ü <C-]>	

" Easy jumps on german keyboard
nmap ö [
nmap öö [[
nmap ä ]
nmap ää ]]
nmap öä []
nmap äö ][

" Workaround for braces
inoremap öö [
inoremap ää ]
inoremap ÖÖ {
inoremap ÄÄ }


" Escape from insert mode
inoremap jk <esc>

" ULTISNIPS ------------------------------ {{{
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsListSnippets="<C-ö>"

let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

let g:UltiSnipsEnableSnipMate="0"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" }}}

" }}}

" VIMSCRIPT -------------------------------------------------------------- {{{

" This will enable code folding.
" Use the marker method of folding.
augroup filetype_vim
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
augroup END

" Zettelkasten Standalone ----------------------------------------------- {{{
"
let s:zkhome = "{zkhome}"

" Erzeugt eine Zettelkastennotitzdatei
function! SaveWithTS(directory) range
  let dirname = "!mkdir -p " .. a:directory .. strftime("%Y/%m/%d/") 
    silent execute dirname
    execute "save " . a:directory . strftime("%Y/%m/%d/%H%M%S.adoc")
    redraw!
endfunction

" Erstelle einen Zettelkastenlink
function! s:CreateZkLink()
  norm! gg/^= <cr>
  norm! wv$h"by
  let @a = 'xref:' . s:zkhome . expand('%') . '[' . expand(@b) . ']'
endfunction

" Erstelle einen relativen Zettelkastenlink
" Suche Titlezeile
" Kopiere Titel ins Register b
" Erstelle link im Register a
function! s:CreateRelativeZkLink()
  norm! gg/^= <cr>
  norm! wv$h"by
  let @a = 'xref:' . expand('%') . '[' . expand(@b) . ']'
endfunction


" = Zettelkasten Commands
" Prerequisite: Textformat of notes is ASCIIDOC
" Write a new note
command! -nargs=0 ZkWrite call SaveWithTS('$ZETTELKASTEN_HOME/notizen/')
" Find note by keyword
command! -nargs=+ ZkSearchKeyword :execute 'lvimgrep /^:keywords:.*'.expand('<args>').'/j $ZETTELKASTEN_HOME/notizen/**/*.adoc'
" Find note by title
command! -nargs=+ ZkSearchTitle :execute 'lvimgrep /^= .*'.expand('<args>').'/j  $ZETTELKASTEN_HOME/notizen/**/*.adoc'
" Find note by textbody
command! -nargs=+ ZkSearchBody :execute 'lvimgrep /.*'.expand('<args>').'/j $ZETTELKASTEN_HOME/notizen/**/*.adoc'
" Stellt einen internen Verweis im Register a für diese Datei zu Verfügung
command! -nargs=0 ZkPrepareBacklinkName call s:CreateZkLink()
" Stellt einen relativen internen Verweis im Register a für dies Datei zur Verfügung
command! -nargs=0 ZkPrepareRelativeBacklinkname call s:CreateRelativeZkLink()
" Suche alle Zettel, die auf diesen verweisen
command! -nargs=0 ZkSearchBacklinkNotes call s:CreateZkLink() | :execute 'lvimgrep '. matchstr(@a,'}\zs.*\ze[') .' $ZETTELKASTEN_HOME/notizen/**/*.adoc'

command! -bang -nargs=* ZkListNotes
  \ let spec = {'dir': $ZETTELKASTEN_HOME, 'options': '--tac +s -d : --with-nth 3..'} |
  \ call fzf#vim#grep(
  \   "grep -rn '^= ' $ZETTELKASTEN_HOME/notizen  | sed s/:=\\ /:/g ",
  \   fzf#vim#with_preview(spec,'right','ctrl-/'), <bang>0)


" Suche alle Zettel ohne Verweise
command! -bang -nargs=* ZkListNolinkNotes
  \ let spec = {'dir': $ZETTELKASTEN_HOME, 'options': '--tac +s -d : --with-nth 3..'} |
  \ call fzf#vim#grep(
  \   "$ZETTELKASTEN_HOME/searchForNotesWithoutLinks.sh",
  \   fzf#vim#with_preview(spec,'right','ctrl-/'), <bang>0)

" Liste alle Zettel auf, die kein Schlagwort und auch keine internen Verweise
" enthalten
command! -bang -nargs=0 ZkListNoKeywordAndLinkNotes
  \ let spec = {'dir': $ZETTELKASTEN_HOME, 'options': '--tac +s -d : --with-nth 3..'} |
  \ call fzf#vim#grep(
  \   "$ZETTELKASTEN_HOME/searchForNotesWithoutKeywordsAndLinks.sh",
  \   fzf#vim#with_preview(spec,'right','ctrl-/'), <bang>0)



" }}}

" Zettelkasten and Jekyll ------------------------------------------------ {{{
" More Vimscripts code goes here.
" Jekyll based Zettelkasten

function! SaveJekyllZettelkastenNote(directory) range
  let mkDirname = "!mkdir -p " .. a:directory
   silent execute mkDirname
   execute "save " . a:directory . strftime("%Y-%m-%d-%H%M%S.adoc")
   redraw!
endfunction

command! -nargs=0 JekyllZkSave call SaveJekyllZettelkastenNote('./content/collections/zettelkasten/_posts/')
command! -nargs=+ JekyllZkFindKeywords :execute 'lvimgrep /^:keywords:.*'.expand('<args>').'/j ./content/collections/zettelkasten/**/*.adoc'
command! -nargs=+ JekyllZkTitleSearch :execute 'lvimgrep /^= .*'.expand('<args>').'/j ./content/collections/zettelkasten/**/*.adoc'
command! -nargs=+ JekyllZkFulltextSearch :execute 'lvimgrep /.*'.expand('<args>').'/j ./content/collections/zettelkasten/**/*.adoc'  
command! -bang -nargs=? -complete=dir JekylZkPreviewlist call fzf#vim#files('content/collections/zettelkasten/_posts',fzf#vim#with_preview(),<bang>0)
command! -nargs=1 JekyllZkPostUrl let @a = 'xref:{% page_url /zettelkasten/' . expand('%:t:r') . ' %}[' . expand('<args>') . ']'

" }}}

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
"    command! -bang -nargs=* Rg
"      \ call fzf#vim#grep(
"      \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
"      \   fzf#vim#with_preview(), <bang>0)

    function! RipgrepFzf(query, fullscreen)
      let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
      let initial_command = printf(command_fmt, shellescape(a:query))
      let reload_command = printf(command_fmt, '{q}')
      let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
      call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
    endfunction

    command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" }}}

" Search with Rg ------------------------------------------------------------------- {{{
command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always --ignore-case '.shellescape(<q-args>), 1,
      \   <bang>0 ? fzf#vim#with_preview('up:60%')
      \           : fzf#vim#with_preview('right:50%:hidden', '?'),
      \   <bang>0)

nnoremap <C-p>a :Rg 
" }}}

" Insert Link ------------------------------------------------------------------- {{{
function! ZettelkastenReducer(line)
    let note_path = $ZETTELKASTEN_HOME . "/notizen"
    let file_path = split(a:line[0], ':')[0]
    let title = split(a:line[0], '=')[1]
    let relative_path = substitute(file_path, note_path, "", "")
    return "xref:../../.." . relative_path . "[" . title . "]"
endfunction

augroup zettelkasten_group
    autocmd!
    autocmd BufRead,BufNewFile $ZETTELKASTEN_HOME/notizen/**.adoc inoremap <expr> ## fzf#vim#complete({
            \ 'source': 'rg --line-number --no-heading --ignore-case --max-count 1  "^=.*" $ZETTELKASTEN_HOME/notizen \| sort -t: -k3',
            \ 'options': '-d ":1:=" --with-nth 2.. --prompt "ZettelkastenLink> "',
            \ 'reducer': function('ZettelkastenReducer'),
            \ 'window': {'width': 0.5, 'height': 0.5 }})

autocmd BufRead,BufNewFile $ZETTELKASTEN_HOME/notizen/**.adoc inoremap <expr> <C-q> fzf#vim#complete({
            \ 'source': 'find $ZETTELKASTEN_HOME/quellen -type f',
            \ 'options': '--prompt "Quelle> "',
            \ 'reducer': { l->substitute(l[0], getenv('ZETTELKASTEN_HOME') . "/quellen/", "", "")},
            \ 'window':  {'width': 0.5, 'height': 0.5 }})

augroup END

" }}}

" Zettelkasten Bufferlist ---------------------------------------------------- {{{

function! GetFirstHeaderText(bufno)
    for line in range(1,line('$',bufwinid(a:bufno)))
        let current_line = getbufline(a:bufno,line)[0]
        if current_line =~ '^= '
            return substitute(current_line,'^= ', '','')
        endif
    endfor
    return '' " Keinen Treffer
endfunction

function! GetFirstHeaderFromList(lines)
    for current_line in a:lines
        if current_line =~ '^= '
            return substitute(current_line,'^= ', '','')
        endif
    endfor
    return '' " Keinen Treffer
endfunction
    

function! CustomBufferList()
    for buf in range(1, bufnr('$'))
        if bufexists(buf) && buflisted(buf)
            " Hole den Buffernamen
            let bufname = bufname(buf)
            if bufname == ''
                let firstline = ''
            elseif bufloaded(buf)
                let firstline = GetFirstHeaderText(buf)
            else
                let filecontent = readfile(bufname)
                if empty(filecontent)
                    let firstline = '[Empty File]'
                else
                    let firstline = GetFirstHeaderFromList(filecontent)
                endif
            endif
            " Formatiere die Ausgabe
            echo printf('%3d: %s | %s', buf, bufname == '' ? '[No Name]' : bufname, firstline)
        endif
    endfor
endfunction

command! -bang -nargs=0 Ls call CustomBufferList()
" ---- }}}

" Yaml ------------------------------------------------------------------- {{{
augroup yaml_group
    autocmd!
    autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
augroup END
"  }}}

" asciidoctor ------------------------------------------------------------ {{{
" autocmd FileType asciidoctor setlocal grepprg="grep -n $*"
" }}}

" STATUS LINE ------------------------------------------------------------ {{{

" Status bar code goes here.
 " }}}
