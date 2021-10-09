if exists('g:loaded_plugins')
  finish
endif

" Vim-Polyglot {{{ "
let g:polyglot_disabled = ['autoindent']
" Vim-Polyglot }}} "

" ColorScheme {{{ "
let g:srcery_italic=1
let g:gruvbox_italic=1
set background=dark
colorscheme srcery
" ColorScheme }}} "

" vim-tmux-navigator {{{ "
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <c-w>h :TmuxNavigateLeft<cr>
nnoremap <silent> <c-w>j :TmuxNavigateDown<cr>
nnoremap <silent> <c-w>k :TmuxNavigateUp<cr>
nnoremap <silent> <c-w>l :TmuxNavigateRight<cr>
nnoremap <silent> <c-w>\ :TmuxNavigatePrevious<cr>
" vim-tmux-navigator }}} "

" vim-cool {{{ "
let g:CoolTotalMatches = 1
" vim-cool }}} "

" Undotree {{{ "
inoremap <silent> <leader>u <esc>:UndotreeToggle<cr>
nnoremap <silent> <leader>u :UndotreeToggle<cr>
" Undotree }}} "

" Floaterm {{{ "
let g:floaterm_wintype = 'vsplit'
let g:floaterm_width = 0.5
nnoremap <leader>tt :FloatermToggle<cr>
inoremap <leader>tt <esc>:FloatermToggle<cr>
nnoremap <leader>nt :FloatermNew<cr>
inoremap <leader>nt <esc>:FloatermNew<cr>
" Floaterm }}} "

" Vim-select {{{ "
let g:select_no_ignore_vcs = 0
" A bunch of fuzzy
inoremap <silent><leader>sp <esc>:Select projectfile<cr>
nnoremap <silent><leader>sp :Select projectfile<cr>
inoremap <silent><leader>sb <esc>:Select buffer<cr>
nnoremap <silent><leader>sb :Select buffer<cr>
inoremap <silent><leader>sd <esc>:Select todo<cr>
nnoremap <silent><leader>sd :Select todo<cr>
inoremap <silent><leader>sg <esc>:Select gitfile<cr>
nnoremap <silent><leader>sg :Select gitfile<cr>
inoremap <silent><leader>s/ <esc>:Select bufline<cr>
nnoremap <silent><leader>s/ :Select bufline<cr>
" Vim-select }}} "

" Scalpel {{{ "
let g:ScalpelMap=0
nmap <leader><f2> <plug>(Scalpel)
" Scalpel }}} "

" Vim-smartpairs {{{ "
" Removes basic autoclose
iunmap {
iunmap (
iunmap [
iunmap "
iunmap `
" Vim-smartpairs }}} "

" Fern {{{ "
let g:fern#disable_default_mappings = 1
let g:fern#default_hidden = 1
let g:fern#renderer = 'nerdfont'
inoremap <silent><c-b>b <esc>:Fern . -reveal=%<cr>
nnoremap <silent><c-b>b :Fern . -reveal=%<cr>
inoremap <silent><c-b>v <esc>:wincmd v<cr>:Fern . -reveal=%<cr>
nnoremap <silent><c-b>v :wincmd v<cr>:Fern . -reveal=%<cr>
inoremap <silent><c-b>s <esc>:wincmd s<cr>:Fern . -reveal=%<cr>
nnoremap <silent><c-b>s :wincmd s<cr>:Fern . -reveal=%<cr>
" Fern }}} "

" vim-highlightedyank {{{ "
let g:highlightedyank_highlight_duration = 250
" vim-highlightedyank }}} "

" vim-lsp {{{ "
if !isdirectory(expand('$HOME') . '/.local/vim-lsp-settings/servers')
  call mkdir(expand('$HOME') . '/.local/vim-lsp-settings/servers', 'p')
endif
let g:lsp_settings_servers_dir=expand('$HOME') . '/.local/vim-lsp-settings/servers'
let g:lsp_fold_enabled = 0
let g:lsp_diagnostics_float_cursor = 1
let g:lsp_diagnostics_float_delay = 250
let g:lsp_diagnostics_highlights_enabled = 0
let g:lsp_diagnostics_signs_error = {'text': ''}
let g:lsp_diagnostics_signs_warning = {'text': ''}
let g:lsp_diagnostics_signs_info = {'text': ''}
let g:lsp_diagnostics_signs_hint = {'text': ''}
let g:lsp_diagnostics_signs_delay = 250
nmap gd <plug>(lsp-definition)
nmap gr <plug>(lsp-references)
nmap gi <plug>(lsp-implementation)
nmap gt <plug>(lsp-type-definition)
nmap <c-@> <plug>(lsp-code-action)
nmap <f2> <plug>(lsp-rename)
nmap <silent> <c-h> <plug>(lsp-previous-diagnostic)
nmap <silent> <c-l> <plug>(lsp-next-diagnostic)
" vim-lsp }}} "

" Lightline {{{ "
let g:lightline = {
      \ 'active': {
        \   'left': [['mode', 'paste'],
        \           ['gitbranch', 'readonly', 'filename', 'modified']],
        \   },
        \ 'component_function': {
          \   'gitbranch': 'gitbranch#name',
          \   },
          \ }
let g:lightline.colorscheme = g:colors_name
" Lightline }}} "

" clean-path.vim {{{ "
packadd clean-path.vim
let &path.=cleanpath#setpath()
let &wildignore.=cleanpath#setwildignore()
" clean-path.vim }}} "

" ddc.vim {{{ "
function! s:custom_expand() abort
  if !pumvisible()
    return "\<cr>"
  endif

  " Workaround Ultisnips horrible expand keybind disabled
  let l:complete_info = complete_info(['selected', 'items'])
  if l:complete_info == {}
    return "\<c-y>"
  endif
  let l:index = l:complete_info.selected
  let l:item = l:complete_info.items[l:index]
  if stridx(l:item.menu, '[us]') != -1
    return UltiSnips#ExpandSnippet()
  endif

  return "\<c-y>"
endfunction
packadd denops.vim
packadd ddc.vim
packadd ddc-around
packadd ddc-matcher_head
packadd ddc-matcher_fuzzy
packadd ddc-sorter_rank
packadd ddc-converter_remove_overlap
packadd ddc-file
packadd ddc-buffer
packadd ddc-matcher_fuzzy
packadd ddc-ultisnips
packadd denops-popup-preview.vim
packadd ddc-vim-lsp
call ddc#custom#patch_global('sources',
      \ [
      \   'vim-lsp',
      \   'buffer',
      \   'around',
      \   'ultisnips',
      \   'file'
      \ ])
call ddc#custom#patch_global('sourceOptions', {
      \ '_': {
      \   'ignoreCase': v:true,
      \   'minAutoCompleteLength': 1,
      \   'sorters': ['sorter_rank'],
      \   'converters': ['converter_remove_overlap']
      \   },
      \ 'vim-lsp': {
      \   'mark': 'lsp',
      \   'matchers': ['matcher_head'],
      \   'isVolatile': v:true,
      \   },
      \ 'file': {
      \   'mark': 'file',
      \   'matchers': ['matcher_fuzzy'],
      \   'isVolatile': v:true,
      \   },
      \ 'buffer': {
      \   'mark': 'b',
      \   'matchers': ['matcher_fuzzy']
      \   },
      \ 'around': {
      \   'mark': 'a',
      \   'matchers': ['matcher_fuzzy']
      \   },
      \ 'ultisnips': {
      \   'matchers': ['matcher_head'],
      \   'mark': 'us'
      \   }
      \ })
call ddc#custom#patch_global('filterParams', {
      \ 'matcher_fuzzy': {
      \   'camelcase': v:true
      \   },
      \ })
inoremap <silent> <expr> <tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <silent> <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"
inoremap <silent> <cr> <c-r>=<sid>custom_expand()<cr>
inoremap <silent> <expr> <c-@> ddc#manual_complete()
call popup_preview#enable()
call ddc#enable()
" ddc.vim }}} "

" Ultisnips {{{ "
let g:UltiSnipsExpandTrigger="<nop>"
let g:UltiSnipsJumpForwardTrigger="<leader><leader>"
let g:UltiSnipsJumpBackwardTrigger="<nop>"
" Ultisnips }}} "

let g:loaded_plugins = 1