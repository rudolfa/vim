" Java specific keymappings

" ide 
" Display the list of registered LSP servers : (l)sp (m)eta (s)how (s)ervers
nnoremap <leader>lmss :LspShowServers<cr>
" Show server capabilities : (l)sp (m)eta (s)how (s)erver (c)apabilities
nnoremap <leader>lmssc :LspShowServerCapabilities<cr>
" Goto Definition
nnoremap gd :LspGotoDefinition<cr>
" Goto Declaration
nnoremap gD :LspGotoDeclaration<cr>
" Goto Type definition
nnoremap gt :LspGotoTypeDef<cr>
" Goto Implementation
nnoremap gi :LspGotoImpl<cr>

" Peek Definition
nnoremap <leader>lpd :LspPeekDefinition<cr>
" Peek Declaration
nnoremap <leader>lpD :LspPeekDeclaration<cr>
" Peek Typedefinition
nnoremap <leader>lpt :LspPeekTypeDef<cr>
" Peek Implementation
nnoremap <leader>lpi :LspPeekImpl<cr>
" Peek references
nnoremap <leader>lpr :LspPeekReferences<cr>

" Show signature
nnoremap <leader>lss :LspShowSignature<cr>
" Show References
nnoremap <leader>lsr :LspShowReferences<cr>
" Open outline
nnoremap <leader>loo :LspOutline<cr>
" Hover
nnoremap <leader>lh :LspHover<cr>

" Show diagnostic
nnoremap <leader>lds :LspDiagShow<cr>
" Show diagnostic of current line
nnoremap <leader>ldc :LspDiagCurrent<cr>
" Show diagnostic which is found first
nnoremap <leader>ldf :LspDiagFirst<cr>
" Show next diagnostic 
nnoremap <leader>ldn :LspDiagNext<cr>
" Show previous diagnostic
nnoremap <leader>ldp :LspDiagPrev<cr>
" Highlight diagnostic lines
nnoremap <leader>ldhe :LspDiagHighlightEnable<cr>
" Disable highlighted diagnostic lines
nnoremap <leader>ldhd :LspDiagHighlightDisable<cr>


