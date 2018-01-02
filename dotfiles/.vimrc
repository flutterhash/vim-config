"To get Pathogen functioning and loading all of our addons
execute pathogen#infect()
"
let vimdir = $HOME.'/.vim'
let vimcache = vimdir.'/.cache'
"
"Basic Functionality
set nocompatible "to use these cool features!
set nomodeline "security
set autochdir "automatically call :cd when going to new file
set number "line numbers
set ruler "guarantee that we get cursor co-ords at the bottom
set confirm "when risking loss, puts up dialog asking to save
set hidden "buffers need not be saved to a file before switching
set exrc " .vimrc in directory overrides any options set here
set secure "makes the above less potentially dangerous?
set colorcolumn=81
set clipboard=unnamedplus "default is system copy-pasta
set backspace=indent,eol,start
set scrolloff=1 "always show at least one line above/below current
set viminfo='0,<0,@0,f0,/0
set history=1000
set noswapfile
set nobackup
set gdefault "by default, replace all instances
set splitbelow
set splitright
set autoread
syntax on
let mapleader=","
colorscheme default
"
"Filetypes
autocmd FocusGained * :checktime
"
"Indentation
filetype plugin on "tries to figure out filetype and indent properly
filetype indent on
set autoindent "keeps indentation, even if we don't have filetype recognized
set cindent "C-like indentation
set expandtab
set tabstop=4
set shiftwidth=4
let g:indent_guides_enable_on_vim_startup = 1
"
"Command Completion and Stuff
set showcmd "shows current keystroke buffer in command mode
set wildmenu "supposedly better CL completion
set wildmode=longest:full,full "to match the longest common string possible
set cmdheight=1
set previewheight=25
set cmdwinheight=25
"
"Search/Regex
set ignorecase "all lowercase == matches both lower and upper
set smartcase
set hlsearch "highlight matches on-screen when searching
set incsearch "incremental search: searching works as you type
"
"Text Autocompletion
set completeopt-=preview
"
"Status Line
set statusline=%t\ %m%=%l,%c\ %P
"
"Custom Vanilla Keybindings
"save file
nnoremap <C-s> :w<CR>
"prevent save and quit, Ex nonsense
noremap ZZ <NOP>
noremap Q <NOP>
"jump and recentre window functions
noremap C zz
noremap T zt
noremap X zb
"Window Manipulation
nnoremap <C-Down>  <C-W>j
nnoremap <C-Up>    <C-W>k
nnoremap <C-Left>  <C-W>h
nnoremap <C-Right> <C-W>l
nnoremap <Leader>v  <C-W>v
nnoremap <Leader>s  <C-W>s
nnoremap <Leader>=  <C-W>=
nnoremap <Leader>c  <C-W>c
nnoremap <Leader>H  <C-W>H
nnoremap <Leader>J  <C-W>J
nnoremap <Leader>K  <C-W>K
nnoremap <Leader>L  <C-W>L
"Tab Manipulation
nnoremap <Leader>t :tabnew<CR>
nnoremap <Leader>T :tabclose<CR>
"Miscellaneous
noremap ; :
noremap <Leader>; q:
nnoremap <Leader><CR> :noh<CR>
nnoremap g[ :pop<CR>
"
"NumberToggle
let g:UserNumberToggleTrigger = 1
let g:NumberToggleTrigger = "<Leader>n"
"
"Easymotion
let g:easymotion_default_mappings = 0
map <Leader> <Plug>(easymotion-prefix)
map <Plug>(easymotion-prefix)b <Plug>(easymotion-b)
map <Plug>(easymotion-prefix)B <Plug>(easymotion-B)
map <Plug>(easymotion-prefix)w <Plug>(easymotion-w)
map <Plug>(easymotion-prefix)W <Plug>(easymotion-W)
map <Plug>(easymotion-prefix)e <Plug>(easymotion-e)
map <Plug>(easymotion-prefix)E <Plug>(easymotion-E)
map <Plug>(easymotion-prefix)r <Plug>(easymotion-ge)
map <Plug>(easymotion-prefix)R <Plug>(easymotion-gE)
map <Plug>(easymotion-prefix)f <Plug>(easymotion-f)
map <Plug>(easymotion-prefix)g <Plug>(easymotion-F)
"
"MiniBufExplorer
nnoremap <Leader><Leader>b :MBEToggle<CR>
nnoremap <Leader>z :MBEbw<CR>
nnoremap <Leader><Leader>n :enew<CR>
nnoremap <A-Right> :MBEbn<CR>
nnoremap <A-Left> :MBEbp<CR>
"
"Ctrl-P (Fuzzy finder + MRU)
let g:ctrlp_map = ''
let g:ctrlp_cmd = ''
let g:ctrlp_mruf_max = 100
let g:ctrlp_max_history = 0
let g:ctrlp_max_files = 0
let g:ctrlp_dotfiles = 1
let g:ctrlp_cache_dir = vimcache.'/ctrlp'
let g:ctrlp_match_window = 'max:50'
nnoremap <Leader>p :CtrlP<CR>
nnoremap <Leader>o :CtrlPBookmarkDir<CR>
nnoremap <Leader>m :CtrlPMRU<CR>
nnoremap <Leader><Leader>p :CtrlPClearAllCaches<CR>
"
"Surround.vim
let g:surround_42="/* \r */"
"
"Rust.vim
let g:rust_recommended_style = 0
"
"YCM
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_complete_in_comments = 1
let g:ycm_always_populate_location_list = 1
let g:ycm_show_diagnostics_ui = 1
let g:ycm_complete_in_comments = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_rust_src_path = '/home/thia/home/Projects/others/rust/src'
nnoremap <Leader>] :YcmCompleter GoToDefinition<CR>
nnoremap <Leader>[ :YcmCompleter GoToDeclaration<CR>
"
"clang-format
let g:clang_format#command = 'clang-format-5.0'
let g:clang_format#auto_format = 0
let g:clang_format#code_style = 'llvm'
let g:clang_format#style_options = {
\  "Standard": "Cpp11"
\}
autocmd FileType c,cpp,objc nnoremap <buffer><Leader><Leader>f :ClangFormat<CR>
"
"cargo-fmt
autocmd FileType rs nnoremap <buffer><Leader><Leader>f :!cargo-fmt
"
"ultisnips
let g:UltiSnipsExpandTrigger="<Leader><tab>"
let g:UltiSnipsJumpForwardTrigger="<Leader>n"
let g:UltiSnipsJumpBackwardTrigger="<Leader>b"
"
"neomake
call neomake#configure#automake('w')
let g:neomake_error_sign = {'text': '>>', 'texthl': 'YcmErrorSign'}
let g:neomake_warning_sign = {'text': '>', 'texthl': 'YcmWarningSign'}
let g:neomake_cpp_enabled_makers = []
let g:neomake_c_enabled_makers = []
let g:neomake_rust_enabled_makers = []
let g:neomake_python_maker = {
\  'append_file': 1,
\  'args': ['/home/thia/.vim/bundle/neomake/autoload/neomake/makers/ft/python/compile.py'],
\  'auto_enabled': 1,
\  'errorformat': '%E%f:%l:%c: %m',
\  'exe': 'python3',
\  'output_stream': 'stdout',
\  'serialize': 1,
\  'serialize_abort_on_error': 1,
\}
"
"LanguageClient
let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {
\  'rust': ['rustup', 'run', 'nightly', 'rls'],
\}
let g:LanguageClient_diagnosticsDisplay = {
\  1: {
\      "name": "Error",
\      "texthl": "ALEError",
\      "signText": ">>",
\      "signTexthl": "ALEErrorSign",
\  },
\  2: {
\      "name": "Warning",
\      "texthl": "ALEWarning",
\      "signText": ">",
\      "signTexthl": "ALEWarningSign",
\  },
\  3: {
\      "name": "Information",
\      "texthl": "ALEInfo",
\      "signText": "i",
\      "signTexthl": "ALEInfoSign",
\  },
\  4: {
\      "name": "Hint",
\      "texthl": "ALEInfo",
\      "signText": "*",
\      "signTexthl": "ALEInfoSign",
\  },
\}
