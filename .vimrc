" ╔══════════════════════════════════════════════════════════════╗
" ║                    VIM CONFIGURATION                         ║
" ║              Full-Stack Elegant Setup                        ║
" ║         OneDark · Emmet · AutoPairs · Smart Search           ║
" ╚══════════════════════════════════════════════════════════════╝

" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
"  PLUGIN MANAGER (vim-plug)
"  Install: curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

call plug#begin('~/.vim/plugged')

" ── Tema ──────────────────────────────────────────────────────
Plug 'joshdick/onedark.vim'

" ── Statusline elegante ───────────────────────────────────────
Plug 'itchyny/lightline.vim'

" ── Autocompletado de pares (no usa coc ni lsp, liviano) ──────
Plug 'jiangmiao/auto-pairs'

" ── Emmet (HTML/CSS/JS) ───────────────────────────────────────
Plug 'mattn/emmet-vim'

" ── Syntax highlighting mejorado ──────────────────────────────
Plug 'sheerun/vim-polyglot'

" ── Comentarios rápidos ───────────────────────────────────────
Plug 'tpope/vim-commentary'

" ── Surround (envolver con comillas, tags, etc.) ──────────────
Plug 'tpope/vim-surround'

" ── Explorador de archivos ────────────────────────────────────
Plug 'preservim/nerdtree'

" ── Búsqueda difusa (FZF) ─────────────────────────────────────
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" ── Git signs en el gutter ───────────────────────────────────
Plug 'airblade/vim-gitgutter'

" ── Indentación visual ───────────────────────────────────────
Plug 'Yggdroot/indentLine'

" ── Autocompletado nativo mejorado (Tab para completar) ─────
Plug 'ervandew/supertab'

" ── Cierre de tags HTML ──────────────────────────────────────
Plug 'alvan/vim-closetag'

" ── Resaltado de color en CSS ────────────────────────────────
Plug 'ap/vim-css-color'

" ── Múltiples cursores ───────────────────────────────────────
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

Plug 'neoclide/coc.nvim', {'branch': 'release'}



call plug#end()


" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
"  CONFIGURACIÓN GENERAL
" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

set nocompatible                 " Modo no compatible con vi (requerido)
filetype plugin indent on        " Detección de tipo de archivo
syntax enable                    " Sintaxis habilitada

set encoding=utf-8               " Codificación UTF-8
set fileencoding=utf-8
set termencoding=utf-8

set hidden                       " Buffers en background sin guardar
set history=500                  " Historial de comandos
set autoread                     " Recargar archivos modificados externamente
set backspace=indent,eol,start   " Backspace funcional


" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
"  APARIENCIA · TEMA ONEDARK
" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

set termguicolors                " Colores de terminal de 24 bits
set background=dark

" Activar onedark con colores del terminal si no hay GUI
let g:onedark_termcolors = 256
let g:onedark_terminal_italics = 1
colorscheme onedark

set mouse=a
set number                       " Números de línea
set relativenumber               " Números relativos
set cursorline                   " Resaltar línea actual
set showmatch                    " Resaltar paréntesis correspondiente
set signcolumn=yes               " Columna de signos siempre visible
set colorcolumn=100              " Línea guía en columna 100
set laststatus=2                 " Barra de estado siempre visible
set noshowmode                   " No mostrar -- INSERT -- (lo muestra lightline)
set showcmd                      " Mostrar comando en progreso
set scrolloff=8                  " Líneas de contexto al hacer scroll
set sidescrolloff=8
set wrap                         " Ajuste de línea
set linebreak                    " Romper en palabras completas
set list                         " Mostrar caracteres invisibles
set listchars=tab:→\ ,trail:·,nbsp:·

" Cursor diferente en modos
let &t_SI = "\e[6 q"             " Cursor barra en INSERT
let &t_SR = "\e[4 q"             " Cursor subrayado en REPLACE
let &t_EI = "\e[2 q"             " Cursor bloque en NORMAL


" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
"  INDENTACIÓN · 2 ESPACIOS
" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

set tabstop=2                    " Ancho de tabulación visual
set shiftwidth=2                 " Ancho de indentación
set softtabstop=2                " Tabulación en modo inserción
set expandtab                    " Espacios en lugar de tabs
set smartindent                  " Indentación inteligente
set autoindent                   " Auto-indentación

" Por tipo de archivo
augroup FileTypeIndent
  autocmd!
  autocmd FileType python         setlocal ts=4 sw=4 sts=4
  autocmd FileType go             setlocal ts=4 sw=4 sts=4 noexpandtab
  autocmd FileType html,css,scss  setlocal ts=2 sw=2 sts=2
  autocmd FileType javascript,typescript,json setlocal ts=2 sw=2 sts=2
  autocmd FileType yaml,toml      setlocal ts=2 sw=2 sts=2
  autocmd FileType markdown       setlocal ts=2 sw=2 sts=2 wrap
augroup END


" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
"  BÚSQUEDA
" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

set incsearch                    " Búsqueda incremental
set hlsearch                     " Resaltar resultados
set ignorecase                   " Ignorar mayúsculas/minúsculas
set smartcase                    " Case-sensitive si hay mayúsculas


" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
"  SPLITS Y VENTANAS
" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

set splitbelow                   " Nuevo split horizontal abajo
set splitright                   " Nuevo split vertical a la derecha


" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
"  ARCHIVOS TEMPORALES
" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

set noswapfile                   " Sin archivos swap
set nobackup                     " Sin backups
set undofile                     " Historial de deshacer persistente
set undodir=~/.vim/undo          " Directorio para undo files
" Crear directorio si no existe
silent! call mkdir(expand('~/.vim/undo'), 'p')


" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
"  SUPERTAB (Tab para autocompletar)
" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

let g:SuperTabDefaultCompletionType = 'context'   " detecta contexto
let g:SuperTabContextDefaultCompletionType = '<c-n>'
let g:SuperTabLongestHighlight = 1
let g:SuperTabCrMapping = 1                        " Enter confirma selección


" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
"  AUTOCOMPLETADO NATIVO
" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

set complete+=kspell              " Completar con corrector ortográfico
set completeopt=menuone,noinsert,noselect
set pumheight=10                  " Máximo 10 items en menú popup
set wildmenu                      " Menú de completado en línea de comandos
set wildmode=longest:full,full    " Modo de completado


" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
"  EMMET CONFIG
" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

" Activar Emmet en HTML, CSS, JS, JSX, TSX, PHP, Vue
let g:user_emmet_mode = 'i'
let g:user_emmet_install_global = 0
let g:user_emmet_leader_key = '<C-e>'

augroup EmmetEnable
  autocmd!
  autocmd FileType html,css,scss,javascript,typescript,
        \javascriptreact,typescriptreact,php,vue,svelte
        \ EmmetInstall
augroup END

" Configuración de Emmet para JSX
let g:user_emmet_settings = {
  \  'javascript' : { 'extends' : 'jsx' },
  \  'typescript' : { 'extends' : 'jsx' },
  \  'javascriptreact' : { 'extends' : 'jsx' },
  \  'typescriptreact' : { 'extends' : 'jsx' },
  \}


" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
"  AUTO-PAIRS CONFIG
" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

let g:AutoPairs = {
  \ '(' : ')',
  \ '[' : ']',
  \ '{' : '}',
  \ "'" : "'",
  \ '"' : '"',
  \ '`' : '`',
  \ }
let g:AutoPairsShortcutToggle     = '<M-p>'
let g:AutoPairsShortcutFastWrap   = '<M-e>'
let g:AutoPairsShortcutJump       = '<M-n>'
let g:AutoPairsMoveCharacter = "()[]{}\"'"
let g:AutoPairsMapCR              = 1        " Enter crea bloque indentado
let g:AutoPairsCenterLine         = 0


" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
"  CLOSETAG (cierre automático de etiquetas HTML)
" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

let g:closetag_filenames = '*.html,*.xhtml,*.jsx,*.tsx,*.vue,*.svelte,*.php'
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.tsx'
let g:closetag_emptyTags_caseSensitive = 1
let g:closetag_shortcut = '>'
let g:closetag_close_shortcut = '<leader>>'


" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
"  LIGHTLINE (statusbar)
" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

let g:lightline = {
  \ 'colorscheme': 'onedark',
  \ 'active': {
  \   'left': [
  \     ['mode', 'paste'],
  \     ['gitbranch', 'readonly', 'filename', 'modified']
  \   ],
  \   'right': [
  \     ['lineinfo'],
  \     ['percent'],
  \     ['fileformat', 'fileencoding', 'filetype']
  \   ]
  \ },
  \ 'component_function': {
  \   'gitbranch': 'FugitiveHead',
  \ },
  \ }


" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
"  NERDTREE
" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI  = 1
let g:NERDTreeIgnore = [
  \ '\.git$', 'node_modules$', '__pycache__$',
  \ '\.DS_Store$', '\.pyc$', 'dist$', 'build$'
  \ ]
let g:NERDTreeStatusline = ''

" Cerrar si NERDTree es la última ventana
autocmd BufEnter *
  \ if tabpagenr('$') == 1 && winnr('$') == 1 &&
  \    exists('b:NERDTree') && b:NERDTree.isTabTree()
  \ | quit | endif


" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
"  INDENTLINE
" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

let g:indentLine_char            = '│'
let g:indentLine_color_term      = 239
let g:indentLine_color_gui       = '#3c4048'
let g:indentLine_fileTypeExclude = ['markdown', 'json', 'text']


" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
"  FZF CONFIG
" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

let g:fzf_layout = { 'down': '~30%' }
let g:fzf_colors = {
  \ 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }


" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
"  GITGUTTER
" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

let g:gitgutter_sign_added              = '▎'
let g:gitgutter_sign_modified           = '▎'
let g:gitgutter_sign_removed            = '▎'
let g:gitgutter_sign_removed_first_line = '▔'
let g:gitgutter_sign_modified_removed   = '▋'
highlight GitGutterAdd    guifg=#98c379
highlight GitGutterChange guifg=#e5c07b
highlight GitGutterDelete guifg=#e06c75


" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
"  LEADER KEY
" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

let mapleader = " "              " Espacio como leader


" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
"  ATAJOS DE TECLADO
" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

" ── Guardar y salir ──────────────────────────────────────────
nnoremap <leader>w  :w<CR>           " <Space>w  → guardar
nnoremap <leader>W  :wa<CR>          " <Space>W  → guardar todos los buffers
nnoremap <leader>q  :q<CR>           " <Space>q  → cerrar
nnoremap <leader>Q  :qa<CR>          " <Space>Q  → cerrar todo
nnoremap <leader>x  :x<CR>           " <Space>x  → guardar y cerrar
inoremap <C-s>      <Esc>:w<CR>a     " Ctrl+S    → guardar (INSERT)
nnoremap <C-s>      :w<CR>           " Ctrl+S    → guardar (NORMAL)

" ── Archivos / Explorador ────────────────────────────────────
nnoremap <leader>e  :NERDTreeToggle<CR>   " <Space>e  → abrir/cerrar NERDTree
nnoremap <leader>E  :NERDTreeFind<CR>     " <Space>E  → revelar archivo actual
nnoremap <leader>o  :e **/*               " <Space>o  → abrir archivo con wildcard

" ── Búsqueda con FZF ────────────────────────────────────────
nnoremap <leader>f  :Files<CR>       " <Space>f  → buscar archivos
nnoremap <leader>F  :GFiles<CR>      " <Space>F  → archivos rastreados por git
nnoremap <leader>b  :Buffers<CR>     " <Space>b  → cambiar buffer
nnoremap <leader>/  :Rg<CR>          " <Space>/  → ripgrep en todo el proyecto
nnoremap <leader>*  :Rg <C-r><C-w><CR> " <Space>* → buscar palabra bajo cursor
nnoremap <leader>:  :Commands<CR>    " <Space>:  → buscar comandos vim
nnoremap <leader>h  :History<CR>     " <Space>h  → historial de archivos

" ── Búsqueda inline ──────────────────────────────────────────
nnoremap <Esc><Esc> :nohlsearch<CR>  " Esc×2    → limpiar resaltado
nnoremap n         nzzzv             " n centrado
nnoremap N         Nzzzv             " N centrado

" ── Navegación entre splits ──────────────────────────────────
nnoremap <C-h>  <C-w>h
nnoremap <C-j>  <C-w>j
nnoremap <C-k>  <C-w>k
nnoremap <C-l>  <C-w>l

" ── Redimensionar splits ─────────────────────────────────────
nnoremap <M-Up>    :resize +2<CR>
nnoremap <M-Down>  :resize -2<CR>
nnoremap <M-Left>  :vertical resize -2<CR>
nnoremap <M-Right> :vertical resize +2<CR>

" ── Buffers ──────────────────────────────────────────────────
nnoremap <Tab>    :bnext<CR>
nnoremap <S-Tab>  :bprevious<CR>
nnoremap <leader>d :bdelete<CR>      " <Space>d  → eliminar buffer

" ── Mover líneas ─────────────────────────────────────────────
nnoremap <M-j>  :m .+1<CR>==
nnoremap <M-k>  :m .-2<CR>==
vnoremap <M-j>  :m '>+1<CR>gv=gv
vnoremap <M-k>  :m '<-2<CR>gv=gv

" ── Indentación en visual mode mantiene selección ────────────
vnoremap <  <gv
vnoremap >  >gv

" ── Copiar al portapapeles ───────────────────────────────────
nnoremap <leader>y  "+y
vnoremap <leader>y  "+y
nnoremap <leader>p  "+p
nnoremap <leader>P  "+P

" ── Comentarios (vim-commentary) ─────────────────────────────
" gcc → comentar línea, gc → comentar selección (ya viene con el plugin)

" ── Nuevo split ──────────────────────────────────────────────
nnoremap <leader>sv  :vsplit<CR>
nnoremap <leader>sh  :split<CR>

" ── Ir a definición (nativo ctags) ───────────────────────────
nnoremap <leader>]   <C-]>
nnoremap <leader>[   <C-t>

" ── Terminal dentro de vim ───────────────────────────────────
nnoremap <leader>t   :terminal<CR>
tnoremap <Esc>       <C-\><C-n>      " Esc para salir del modo terminal

" ── Emmet ────────────────────────────────────────────────────
" Expansión: Ctrl+e , (coma) en modo inserción


" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
"  AUTOCOMANDOS ÚTILES
" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

augroup GeneralAutocmds
  autocmd!

  " Eliminar espacios en blanco al final al guardar
  autocmd BufWritePre * :%s/\s\+$//e

  " Recordar posición del cursor al reabrir archivo
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   execute 'normal! g`"zvzz' |
    \ endif

  " Resaltar yank brevemente (Vim 8.1+)
  if exists('##TextYankPost')
    autocmd TextYankPost *
      \ silent! call matchadd('IncSearch',
      \   '\%'.line("'[").'l\%'.col("'[").'c.*\%'.line("']").'l\%'.col("']").'c', 10, -1)
  endif

  " Recargar .vimrc al guardar
  autocmd BufWritePost $MYVIMRC source $MYVIMRC

augroup END


" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
"  TIPOS DE ARCHIVO FRONTEND / BACKEND
" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

augroup FileTypes
  autocmd!
  " Frontend
  autocmd BufNewFile,BufRead *.jsx       set filetype=javascriptreact
  autocmd BufNewFile,BufRead *.tsx       set filetype=typescriptreact
  autocmd BufNewFile,BufRead *.vue       set filetype=vue
  autocmd BufNewFile,BufRead *.svelte    set filetype=svelte
  autocmd BufNewFile,BufRead *.scss      set filetype=scss
  autocmd BufNewFile,BufRead *.mdx       set filetype=markdown

  " Backend
  autocmd BufNewFile,BufRead *.py        set filetype=python
  autocmd BufNewFile,BufRead *.go        set filetype=go
  autocmd BufNewFile,BufRead *.rs        set filetype=rust
  autocmd BufNewFile,BufRead *.php       set filetype=php
  autocmd BufNewFile,BufRead *.rb        set filetype=ruby
  autocmd BufNewFile,BufRead Dockerfile* set filetype=dockerfile
  autocmd BufNewFile,BufRead *.env*      set filetype=sh
  autocmd BufNewFile,BufRead *.toml      set filetype=toml
augroup END


" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
"  RENDIMIENTO
" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

set lazyredraw                   " No redibujar en macros
set ttyfast                      " Terminal rápida
set synmaxcol=300                " Limitar sintaxis en líneas largas
set redrawtime=10000             " Tiempo máximo para resaltado


" configuracion adicional para Coc-Install
" === COC BASIC CONFIG ===
set updatetime=300
set shortmess+=c

" TAB para autocompletar
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()

inoremap <silent><expr> <S-TAB>
      \ coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" ENTER para confirmar sugerencia
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Ir a definición
nmap <silent> gd <Plug>(coc-definition)

" Hover (documentación)
nmap <silent> K :call CocActionAsync('doHover')<CR>


" === COC CONFIG ===
set updatetime=300
set shortmess+=c
set signcolumn=yes

" TAB autocompleta
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()

inoremap <silent><expr> <S-TAB>
      \ coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" ENTER confirma sugerencia
inoremap <silent><expr> <CR>
      \ coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Ir a definición
nmap <silent> gd <Plug>(coc-definition)

" Ver documentación
nmap <silent> K :call CocActionAsync('doHover')<CR>

" Renombrar variable
nmap <leader>rn <Plug>(coc-rename)

" Formatear
nmap <leader>f  <Plug>(coc-format-selected)
vmap <leader>f  <Plug>(coc-format-selected)

"coc-prettier
autocmd BufWritePre *.js,*.jsx,*.ts,*.tsx,*.json,*.html,*.css,*.scss :CocCommand prettier.formatFile

" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
"  FIN DE CONFIGURACIÓN
" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
