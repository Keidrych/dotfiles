" Disable built-in VIM Plugins
" netrw + vinegar is awesome but has a bug with Obsession: https://github.com/tpope/vim-vinegar/issues/13
let loaded_netrwPlugin = 1

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent execute "!curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/plugged')
"= Mandatory
Plug 'jooize/vim-colemak'
Plug 'sheerun/vim-polyglot'
" Plug 'tpope/vim-vinegar' " https://shapeshed.com/vim-netrw/
Plug 'justinmk/vim-dirvish'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-unimpaired'
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'
Plug 'taohex/lightline-buffer'
"Plug 'mhinz/vim-startify'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'kassio/neoterm'
Plug 'w0rp/ale'
"Plug 'tpope/vim-fugitive'
"Plug 'idanarye/vim-merginal'
"Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'airblade/vim-gitgutter'
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'steelsojka/deoplete-flow'
Plug 'janko-m/vim-test'
Plug 'editorconfig/editorconfig-vim'
Plug 't9md/vim-choosewin'
Plug 'zhaocai/goldenview.vim'
Plug 'tpope/vim-obsession'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'chrisbra/nrrwrgn'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'niftylettuce/vim-jinja'
Plug 'jiangmiao/auto-pairs'
Plug '907th/vim-auto-save'
"Plug 'gcmt/taboo.vim'
"Plug 'airblade/vim-rooter'
"TODO enable vim-drawer
"Plug 'samuelsimoes/vim-drawer'

" On-Demand ~ FileTypes

" On-Demand ~ Functionality

" Theme
Plug 'NLKNguyen/papercolor-theme'
"Plug 'morhetz/gruvbox'
call plug#end()

" Window Settings
nmap ` <Plug>(choosewin)
let g:choosewin_overlay_enable = 1
let g:goldenview__enable_at_startup = 1
set splitbelow
set splitright
set number
set relativenumber

" Theme Settings / Visual
"set t_Co=256
"set t_ut=
set mouse=a
set background=dark
"let g:gruvbox_italic=1
set termguicolors
colorscheme PaperColor
syntax enable
set laststatus=2
set noshowmode
let g:lightline = {'colorscheme': 'PaperColor'}
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_color_change_percent = 3
let g:indent_guides_enable_on_vim_startup = 1

" Autocomplete
let g:deoplete#enable_at_startup = 1
function! StrTrim(txt)
  return substitute(a:txt, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
endfunction
let g:flow_path = StrTrim(system('PATH=$(npm bin):$PATH && which flow'))
if g:flow_path != 'flow not found'
  let g:deoplete#sources#flow#flow_bin = g:flow_path
endif

" Lightline / Ale / EditorConfig
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']
set hidden
set showtabline=2  " always show tabline

set sessionoptions+=tabpages,globals
" use lightline-buffer in lightline
let g:lightline = {
  \ 'tabline': {
  \   'left': [ [ 'taboo' ] ],
  \   'right': [[ 'close']]
  \ },
  \ 'active': {
  \   'left': [ [ 'mode', 'paste'],
  \             [ 'readonly', 'filename', 'modified'],
  \             [ 'separator'  ],
  \             [ 'bufferbefore', 'buffercurrent', 'bufferafter'  ] ],
  \   'right': [[ 'linter_errors', 'linter_warnings', 'linter_ok' ]]
  \ },
  \ 'component_expand': {
  \   'buffercurrent': 'lightline#buffer#buffercurrent',
  \   'bufferbefore': 'lightline#buffer#bufferbefore',
  \   'bufferafter': 'lightline#buffer#bufferafter',
  \   'linter_warnings': 'lightline#ale#warnings',
  \   'linter_errors': 'lightline#ale#errors',
  \   'linter_ok': 'lightline#ale#ok',
  \ },
  \ 'component_type': {
  \   'buffercurrent': 'tabsel',
  \   'bufferbefore': 'raw',
  \   'bufferafter': 'raw',
  \   'linter_warnings': 'warning',
  \   'linter_errors': 'error',
  \   'linter_ok': 'left',
  \ },
  \ 'component_function': {
  \   'bufferinfo': 'lightline#buffer#bufferinfo',
  \   'taboo': 'TabooTabName(tabpagenr())'
  \ }
  \}
nnoremap <Left> :bprev<CR>
nnoremap <Right> :bnext<CR>
" TODO use lightline's tabline instead of taboo's
let g:taboo_tabline = 1
let g:lightline_buffer_logo = ''
let g:lightline_buffer_readonly_icon = ''
let g:lightline_buffer_modified_icon = '✭'
let g:lightline_buffer_git_icon = ' '
let g:lightline_buffer_ellipsis_icon = '…'
let g:lightline_buffer_expand_left_icon = '◀ '
let g:lightline_buffer_expand_right_icon = ' ▶'
let g:lightline_buffer_active_buffer_left_icon = ''
let g:lightline_buffer_active_buffer_right_icon = ''
let g:lightline_buffer_separator_icon = '  '

" lightline-buffer function settings
let g:lightline_buffer_show_bufnr = 1
let g:lightline_buffer_rotate = 0
let g:lightline_buffer_fname_mod = ':t'
let g:lightline_buffer_excludes = ['vimfiler']

let g:lightline_buffer_maxflen = 30
let g:lightline_buffer_maxfextlen = 3
let g:lightline_buffer_minflen = 16
let g:lightline_buffer_minfextlen = 3
let g:lightline_buffer_reservelen = 20

" Ale fixers
let g:ale_fixers = {
  \ 'javascript': [ 'prettier' ],
  \ 'json': [ 'prettier' ]
  \}

" Ack / Searching
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" For any plugins that use this, make their keymappings use comma
let mapleader = " "
let g:mapleader = " "
let maplocalleader = ","

" Terminal
tnoremap <Esc> <C-\><C-n>

" FZF (replaces Ctrl-P, FuzzyFinder and Command-T)
set rtp+=/usr/local/opt/fzf
set rtp+=~/.fzf
nmap ; :Buffers<CR>
nmap <Leader>r :Tags<CR>
nmap <Leader>t :Files<CR>
nmap <Leader>a :Ag<CR>

" GitGutter styling to use · instead of +/-
let g:gitgutter_sign_added = '∙'
let g:gitgutter_sign_modified = '∙'
let g:gitgutter_sign_removed = '∙'
let g:gitgutter_sign_modified_removed = '∙'

" Test Information
let test#strategy = "neoterm"
let g:neoterm_position = "vertical"
let g:neoterm_autoscroll = 1
let g:neoterm_autoinsert = 0
let g:neoterm_automap_keys = 0
let g:neoterm_direct_open_repl = 1
let test#javascript#tap#file_pattern = "**/*.test.js"
let test#javascript#tap#options = {
  \ 'file': '--reporter landing',
  \ 'nearest': '--reporter classic --only',
  \ 'suite': '--reporter dot'
  \}

" Autosave & AutoFix / Lint
let g:auto_save = 1
let g:auto_save_no_uptime = 1
let g:auto_save_in_insert_mode = 0
let g:auto_save_silent = 1
let g:ale_fix_on_save = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_enter = 0
let g:ale_lint_on_filetype_changed = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0



" AutoCommands
augroup test
  autocmd!
  autocmd BufWrite * if test#exists() |
    \  TestFile
    \ endif
augroup END

augroup VCenterCursor
	au!
	au BufEnter,WinEnter,WinNew,VimResized *,*.*
    \ let &scrolloff=winheight(win_getid())/2
augroup END

" Force Colemak KeyBindings
silent! source "$HOME/.vim/bundle/vim-colemak/plugin/colemak.vim"
