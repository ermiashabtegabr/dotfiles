set nocompatible
syntax on

set noerrorbells
set noshowmode
set belloff=all
set tabstop=4 softtabstop=4
set shiftwidth=4
set wildmenu
set wildignorecase
set wildignore=\*.git/\* 
set smartindent
set relativenumber
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=$VIM/.vim/undodir
set undofile

set incsearch
set ignorecase
set termguicolors

set encoding=UTF-8
set cursorline
set cursorcolumn
set colorcolumn=80
set backspace=indent,eol,start
set showcmd
set laststatus=2
set path+=**
set runtimepath+=$VIM/.vim/bundle/auto-pairs

"===== FOLD =====
set foldenable
set foldlevelstart=10
set foldnestmax=10
set foldmethod=manual

highlight ColorColumn ctermbg=0 guibg=lightgrey

set rtp+=$VIM/.vim
call plug#begin('~/.dotfiles/vim/.vim/plugged')

	Plug 'lervag/vimtex'
	Plug 'SirVer/ultisnips'
	Plug 'honza/vim-snippets'

	Plug 'wakatime/vim-wakatime'
	Plug 'tpope/vim-surround'

	Plug 'junegunn/fzf.vim'
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

	Plug 'preservim/nerdtree'
	Plug 'Xuyuanp/nerdtree-git-plugin'
	Plug 'ryanoasis/vim-devicons'

	Plug 'preservim/nerdcommenter'

	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'dense-analysis/ale'
	Plug 'puremourning/vimspector'
	Plug 'OmniSharp/omnisharp-vim'
	Plug 'vim-erlang/vim-erlang-runtime'
	Plug 'vim-erlang/vim-erlang-omnicomplete'
	Plug 'rust-lang/rust.vim'

	Plug 'cespare/vim-toml', { 'branch': 'main' }
	Plug 'itchyny/lightline.vim'
	"Plug 'morhetz/gruvbox'
	Plug 'sonph/onehalf', { 'rtp': 'vim' }
	Plug 'drewtempelmeyer/palenight.vim'
	Plug 'joshdick/onedark.vim'

	Plug 'ap/vim-css-color'
	Plug 'mbbill/undotree'

	Plug 'dyng/ctrlsf.vim'
	Plug 'tpope/vim-fugitive'
	Plug 'vim-utils/vim-man'
	Plug 'lyuts/vim-rtags'
	Plug 'mbbill/undotree'

call plug#end()
filetype plugin indent on

colorscheme onedark
"hi Normal guibg=NONE ctermbg=7
set background=dark

let mapleader=" "
let g:netrw_browse_split=2
let g:netrw_bufsettings = "noma nomod nu nowrap ro nobl"
let g:netrw_banner=0
let g:netrw_winsize=25
let g:netrw_browse_split=4
let g:netrw_altv=1

let NERDTreeShowHidden=1
let NERDTreeShowLineNumbers=1
let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }

let g:airline_powerline_fonts=1

let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

let g:ale_fix_on_save = 1
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_text_changed = 'normal'
let g:rustfmt_autosave = 1

let g:ale_linters = {
\ 'cs': ['OmniSharp']
\}

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

let g:tex_flavor="latex"
let g:vimtex_view_method="skim"
let g:vimtex_view_automatic=1
let g:vimtex_quickfix_mode=0
let g:syntastic_tex_checkers = ['lacheck']

let g:coc_config_home = "$VIM/.vim/coc-config"

autocmd VimEnter * if !argc() | NERDTree | endif
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
autocmd FileType nerdtree setlocal relativenumber

autocmd FileType tex nmap <buffer> <C-T> :w<CR> :!latexmk -pdf % && latexmk -c<CR><CR>
autocmd FileType tex nmap <buffer> T :!open -a Skim %:r.pdf<CR><CR>
autocmd FileType tex nmap <buffer> C :!latexmk -c<CR><CR>
autocmd BufNewFile *_lec.tex,*_cpt.tex 0r ~/.vim/templates/notes-skeleton.tex
autocmd BufNewFile  *\((^_lec|^_cpt\))\@<!.tex 0r ~/.vim/templates/skeleton.tex

autocmd FileType json autocmd BufWritePre <buffer> %!python -m json.tool 2>/dev/null || echo <buffer>

command! WipeReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor

inoremap <silent><expr> <C-@> coc#refresh()
inoremap <expr><C-k> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <C-j>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<C-j>" :
            \ coc#refresh()

nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

nnoremap <silent> <leader>f :FZF<CR>
nnoremap <silent> <leader>F :FZF ~<CR>
nnoremap <silent> <C-b> :Buffers<CR>
nnoremap <silent> <leader>S :Snippets<CR>

nnoremap <leader>u :UndotreeShow<CR>

nnoremap <leader>j <C-w>j
nnoremap <leader>h <C-w>h
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l

nnoremap <leader>d :w<CR> :bn<CR> 
nnoremap <leader>p :w<CR> :bp<CR>
vnoremap <leader>d :w<CR> :bn<CR> 
vnoremap <leader>p :w<CR> :bp<CR>
inoremap <C-d> <Esc>0d$a
inoremap <C-p> <Esc>bdei

nnoremap <silent> <C-S-Up> :resize -1<CR>
nnoremap <silent> <C-S-Down> :resize +1<CR>
nnoremap <silent> <C-S-Left> :vertical resize -1<CR>
nnoremap <silent> <C-S-Right> :vertical resize +1<CR>

nnoremap <leader>bs :buffers<CR>
nnoremap <leader>b :ls<CR>:b<space>
nnoremap <leader>v :ls<CR>:vsp<space>\|<space>b<space>
nnoremap <leader>s :ls<CR>:sp<space>\|<space>b<space>

nnoremap <leader>no :noh<CR>
nnoremap n nzz
nnoremap N Nzz

nnoremap <C-o> <C-o>zz
nnoremap <C-i> <C-i>zz
nnoremap <C-k> <C-u>zz
nnoremap <C-j> <C-d>zz

inoremap <C-k> <C-u>zz
inoremap <C-j> <C-d>zz

nnoremap 0 ^_
nnoremap ^_ 0
vnoremap 0 ^_
vnoremap ^_ 0

inoremap øø <Esc>
inoremap ØØ <Esc>
vnoremap øø <Esc>
vnoremap ØØ <Esc>

vnoremap . :normal .<CR>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

cnoremap <expr> / wildmenumode() ? "\<C-E>" : "/"
cnoremap <C-k> <Up>
cnoremap <C-j> <Down>

"inoremap ' '<Esc>i'
"inoremap " "<Esc>i"
"inoremap ( (<Esc>i)
"inoremap [ [<Esc>i]
"inoremap { {<Esc>i}
"inoremap < <<Esc>i>
