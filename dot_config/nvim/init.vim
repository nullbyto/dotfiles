" plugins
call plug#begin(stdpath('data') . '/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install()  }  }
Plug 'preservim/nerdtree'
Plug 'Raimondi/delimitMate'
Plug 'vim-syntastic/syntastic'
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-surround' " cs{which surrounding to be replaced}{new}
"Plug 'ycm-core/YouCompleteMe', { 'do': './install.py' }
"Plug 'SirVer/ultisnips'
"Plug 'ervandew/supertab'
"Plug 'honza/vim-snippets'
Plug 'kyazdani42/nvim-web-devicons' " optional, for file icons
Plug 'kyazdani42/nvim-tree.lua'
"Plug 'akinsho/toggleterm.nvim'
"Plug 'vim-airline/vim-airline'
Plug 'itchyny/lightline.vim'

" Appearance
Plug 'vim-airline/vim-airline-themes'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'sheerun/vim-polyglot'
Plug 'tomasiser/vim-code-dark'
Plug 'Yggdroot/indentLine'
Plug 'ryanoasis/vim-devicons'
Plug 'catppuccin/nvim', {'as': 'catppuccin'}

call plug#end()

filetype plugin on

" ##################################################################

" require lua
lua require("nullbyto")

" ##################################################################
" -- Keybinds
" ##################################################################

nnoremap <silent> <F3> :noh <CR>
set pastetoggle=<F2>
"reloads vimrc
nnoremap <Leader>r :source $MYVIMRC<CR>
"nnoremap <silent> <F2> :!java %:r <CR>

" ------------------------------------------------------------------
" Move lines
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-k> :m '<-2<CR>gv=gv
vnoremap <A-j> :m '>+1<CR>gv=gv

" ##################################################################

" PLUGIN: nvim-tree
"map <C-n> :NvimTreeToggle<CR>
"let g:nvim_tree_show_icons = {
"    \ 'git': 1,
"    \ 'folders': 1,
"    \ 'files': 1,
"    \ 'folder_arrows': 1,
"    \ }

" ------------------------------------------------------------------

" PLUGIN: NerdTree
"autocmd vimenter * NERDTree
map <C-n> :NERDTreeToggle<CR>
map <C-b> :NERDTreeFind<CR>

" ------------------------------------------------------------------

" PLUGIN: fzf - tut: https://dev.to/iggredible/how-to-search-faster-in-vim-with-fzf-vim-36ko
let g:fzf_layout = { 'down': '~40%'  } " 40% of the window
nnoremap <silent> <C-f> :Files<CR>
nnoremap <silent> <Leader>f :GFiles<CR>
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>/ :BLines<CR>
nnoremap <silent> <Leader>' :Marks<CR>
nnoremap <silent> <Leader>g :Commits<CR>
nnoremap <silent> <Leader>H :Helptags<CR>
nnoremap <silent> <Leader>hh :History<CR>
nnoremap <silent> <Leader>h: :History:<CR>
"nnoremap <silent> <Leader>h/ :History/<CR> 

" ------------------------------------------------------------------

" PLUGIN: delimitMate
let delimitMate_expand_cr = 1 " auto indents after opening a parenthesis
let delimitMate_expand_space = 1 " expand space in paranthesis when pressing space

" ------------------------------------------------------------------

" PLUGIN: CoC
let g:coc_global_extensions = [
    \ 'coc-snippets',
    \ 'coc-pairs',
    \ 'coc-tsserver',
    \ 'coc-java',
    \ 'coc-html',
    \ 'coc-prettier',
    \ 'coc-json',
    \ 'coc-python',
    \ 'coc-clangd',
    \ 'coc-sh',
    \ 'coc-rust-analyzer',
    \ ]
nnoremap <silent> <leader>c :CocRestart<CR>

" make YCM compatible with UltiSnips (using supertab)
"let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
"let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
"let g:SuperTabDefaultCompletionType = '<C-n>'

" ------------------------------------------------------------------

" PLUGIN: UltiSnips
"let g:UltiSnipsExpandTrigger="<tab>" " use only when YCM is disabled
" better key bindings for UltiSnipsExpandTrigger
"let g:UltiSnipsExpandTrigger = "<tab>"
"let g:UltiSnipsJumpForwardTrigger = "<tab>"
"let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"


" ------------------------------------------------------------------
" Appearance

let g:catppuccin_flavour = "mocha"
let g:lightline = {
    \ "colorscheme": "catppuccin",
    \ }


" ##################################################################

" split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
set splitbelow
set splitright

" appearance
set signcolumn=yes
set colorcolumn=100
set background=dark
syntax on
set t_Co=256
set encoding=UTF-8
set termguicolors
"set noshowmode
colorscheme catppuccin
"colorscheme purify
"colorscheme jellybeans

" Main
set nohlsearch
" Give more space for msgs
set scrolloff=8
set expandtab
set tabstop=4
set shiftwidth=4
set mouse=a
set autoread
set nu
" uncomment only one
set rnu
"set nornu
