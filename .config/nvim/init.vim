let mapleader = "\<Space>"

" ============================================================
" PLUGINS

" Load plugins
call plug#begin('~/AppData/Local/nvim/plugged')

" Vim Enhancements
Plug 'christoomey/vim-sort-motion'
Plug 'justinmk/vim-sneak'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-user' " Required for textobj-entire
Plug 'luochen1990/rainbow'
Plug 'mbbill/undotree'
Plug 'mhinz/vim-startify'
Plug 'michaeljsmith/vim-indent-object'
Plug 'puremourning/vimspector'
Plug 'rbong/vim-flog' " Requires fugitive
Plug 'severin-lemaignan/vim-minimap'
Plug 'szw/vim-maximizer'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
" Plug 'vimwiki/vimwiki'

" Formatters
Plug 'prettier/vim-prettier', {
    \ 'do': 'npm install',
    \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }

" GUI Enhancements
Plug 'itchyny/lightline.vim'
Plug 'liuchengxu/vim-which-key'
Plug 'machakann/vim-highlightedyank'
Plug 'nathanaelkane/vim-indent-guides'

" Themes
Plug 'joshdick/onedark.vim'

" Fuzzy finder
Plug 'airblade/vim-rooter'
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

" Syntax highlighting
Plug 'nvim-treesitter/nvim-treesitter' " , { 'commit': '3c07232' }
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-treesitter/playground'

" Language support
Plug 'neovim/nvim-lspconfig'

call plug#end()

" Completion
" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=50

" Startify settings
let g:startify_lists = [
      \ { 'type': 'bookmarks' },
      \ { 'type': 'files', 'header': ['   MRU:'] },
      \ ]
let g:startify_bookmarks = [
      \ {'a': 'c:/Files/Development'},
      \ {'f': 'c:/Files/Development/Factorio/Mods'},
      \ {'z': 'c:/Files/Configs'},
      \ ]

" Python directory
let g:python3_host_prog = "c:/Files/Programs/Python/python.exe"

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

" Sneak
let g:sneak#label = 1

" Telescope
:lua <<EOF
-- require("telescope").setup{
--   defaults = {
--     file_previewer = require'telescope.previewers'.cat.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_cat.new`
--     grep_previewer = require'telescope.previewers'.vimgrep.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_vimgrep.new`
--     qflist_previewer = require'telescope.previewers'.qflist.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_qflist.new`
--   }
-- }
require("lspconfig").sumneko_lua.setup {
    cmd = {"lua-language-server", "-E", "/usr/share/lua-language-server/main.lua"},
    settings = {
        Lua = {
            diagnostics = {
                severity = {["unused-local"] = "Warning", ["undefined-global"] = "Error"},
                disable = {"lowercase-global", "redefined-local"},
                globals = {"__DebugAdapter", "__Profiler", "global", "data", "mods"},
            },
            runtime = {
                plugin = "/home/rai/dev/factorio/lua-plugin/plugin.lua",
                version = "Lua 5.2"
            },
            telemetry = {
                enable = false
            },
            workspace = {
                ignoreDir = {".vscode", "src/archive", "prototypes"},
                library = {
                    "/home/rai/dev/projects/personal/flib",
                    "/home/rai/dev/factorio/1/data/core/lualib",
                    "/home/rai/dev/factorio/1/data/core/prototypes",
                    "/home/rai/dev/factorio/runtime-api.lua"
                },
                ignoreSubmodules = false,
                preloadFileSize = 10000
            }
        }
    }
}
EOF

" Vimwiki
let g:vimwiki_list = [{'path': 'c:/Files/Drive/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]

" ============================================================
" EDITOR SETTINGS

" NO SWAP FILES!!!
set noswapfile

" Allow per-project settings
set exrc
set secure

" Keep old buffers open
set hidden

" Adjust highlighting of matching parenthesis
hi MatchParen cterm=underline guibg=none guifg=none ctermbg=none ctermfg=none

" Line numbers
set number
set relativenumber
filetype plugin on

" Sign column (linting, git, etc.)
set signcolumn=yes

" Scroll margins
set scrolloff=8

" More natural splits
set splitbelow
set splitright

" Color theme
if (has("autocmd"))
  let s:colors = onedark#GetColors()
  augroup colorextend
    autocmd!
    autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
    autocmd Colorscheme * call onedark#set_highlight("Keyword", {"fg": s:colors.purple})
    autocmd Colorscheme * call onedark#set_highlight("Operator", {"fg": s:colors.red})
    autocmd Colorscheme * call onedark#set_highlight("Include", {"fg": s:colors.yellow})
    autocmd Colorscheme * call onedark#set_highlight("Character", {"fg": s:colors.cyan})
    autocmd Colorscheme * call onedark#set_highlight("Identifier", {"fg":  s:colors.white})
  augroup END
endif
set termguicolors
" Color theme
syntax on
colorscheme onedark
set background=dark

" GUI settings
set noshowmode
let g:rainbow_active = 1
let g:rainbow_conf = {
\	'guifgs': ['gold', 'orchid', 'lightskyblue'],
\}

" Color columns
augroup lua
  autocmd FileType lua setlocal colorcolumn=121
augroup END

highlight Sneak guifg=yellow guibg=black ctermfg=yellow ctermbg=black
highlight SneakScope guifg=yellow guibg=black ctermfg=yellow ctermbg=black

" NO WRAPPING!!!
set nowrap

" ...Except when in markdown
augroup md
  autocmd FileType md setlocal wrap
augroup END

" Enable indent guides by default
if !exists('g:vscode')
  let g:indent_guides_enable_on_vim_startup = 1
endif
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#1d1f26 ctermbg=3
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#272933 ctermbg=4

" Auto-strip trailing whitespace
fun! TrimWhitespace()
  let l:save = winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:save)
endfun

augroup RAIGUARD
  autocmd!
  autocmd BufWritePre * :call TrimWhitespace()
augroup END

" Spaces > tabs
if get(g:, '_has_set_default_indent_settings', 0) == 0
  set expandtab
  set tabstop=2
  set shiftwidth=2
  set softtabstop=2
  set smartindent
  set autoindent
  let g:_has_set_default_indent_settings = 1
endif

" Use treesitter for folding
" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()

set timeoutlen=250

" Persistent undo
set undofile

" Proper search
set incsearch
set ignorecase
set smartcase
set gdefault

" Line numbers in netrw
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'
" Ignore netrw for alternate file
let g:netrw_altfile = 1

" No pesky cwd messages
autocmd VimEnter * silent ! set broadcast=none
autocmd VimLeave * silent ! set broadcast=all

" Allow moving one over from the end of the line
set ve+=onemore

" ============================================================
" KEYBOARD SETTINGS

" No arrow keys for you!
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" Move code blocks
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Use <c-.> to trigger completion.
inoremap <silent><expr> <c-.> coc#refresh()

" Better navigation hotkeys
noremap <C-h> <C-w>h
noremap <C-l> <C-w>l

" Clear search
noremap <leader>/ :let @/=""<cr>

" Search visually selected text
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

" Jump to start and end of line using the home row keys
map H ^
map L $

" Search results centered please
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz
" Movements centered please
nnoremap <silent> <c-o> <c-o>zz
nnoremap <silent> <c-i> <c-i>zz
nnoremap <expr> ' "'" . nr2char(getchar()) . "zz"
nnoremap <expr> ` "`" . nr2char(getchar()) . "zz"

" Move by line
nnoremap j gj
nnoremap k gk

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> <leader>cp <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>cn <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Find symbol of current document.
nnoremap <silent> \o  :<C-u>CocList outline<cr>

" Search workspace symbols.
nnoremap <silent> \s  :<C-u>CocList -I symbols<cr>

" Implement methods for trait
nnoremap <silent> \i  :call CocActionAsync('codeAction', '', 'Implement missing members')<cr>

" Show actions available at this location
nnoremap <silent> \a  :CocAction<cr>

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Project wide search
nnoremap <leader>sw :CocSearch <c-r>=expand("<cword>")<cr><cr>
nnoremap <leader>sl :CocSearch <c-r>0<cr>
nnoremap <leader>ss :CocSearch<space>

" FZF shortcuts
" nnoremap <leader>fb :Buffers<cr>
" nnoremap <leader>ff :Files<cr>
" nnoremap <leader>fg :Rg<cr>
" nnoremap <leader>fd :BD<cr>

" " Telescope shortcuts
nnoremap <leader>fb :Telescope buffers<cr>
nnoremap <leader>ff :Telescope git_files<cr>
nnoremap <leader>fg :Telescope live_grep<cr>

" WhichKey
nnoremap <silent> <leader> :WhichKey ' '<CR>
" nnoremap <silent> g :WhichKey 'g'<cr>

" Startify shortcut
nnoremap <leader>1 :Startify<cr>

"onedarkonedark Switch splits with ctrl-movement
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

" Use vim-sneak instead of built-in f and t
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T

" Git (fugitive, Flog, telescope)
nmap <leader>gs :G<cr>
nmap <leader>gb :Telescope git_branches<cr>
nmap <leader>gg :Flog<cr>
nmap <leader>gc :Gcommit<cr>:sleep 200m<cr><cr>
nmap <leader>gp :Gpush<cr>

" Avoid `press enter to continue` when comitting from GS
function! s:ftplugin_fugitive() abort
  nnoremap <buffer> <silent> cc :Git commit --quiet<CR>
  nnoremap <buffer> <silent> ca :Git commit --quiet --amend<CR>
  nnoremap <buffer> <silent> ce :Git commit --quiet --amend --no-edit<CR>
endfunction
augroup nhooyr_fugitive
  autocmd!
  autocmd FileType fugitive call s:ftplugin_fugitive()
augroup END

" Tabs and terminal
nmap <leader>tn :tabnew<cr>
nmap <leader>tt :tabnew<cr>:edit term://bash<cr>i
nmap <leader>te :tabnew<cr>-
nmap <leader>t1 :tabnew<cr>:Startify<cr>
nmap <leader>tc :tabclose<cr>
if has("nvim")
  au TermOpen * tnoremap <Esc> <c-\><c-n>
  au FileType fzf tunmap <Esc>
endif

" <leader><leader> toggles betwen buffers
nnoremap <leader><leader> <c-^>

" Vimspector
fun! GotoWindow(id)
  call win_gotoid(a:id)
endfun
nnoremap <leader>dd :call vimspector#Launch()<cr>
nnoremap <leader>dc :call GotoWindow(g:vimspector_session_windows.code)<cr>
nnoremap <leader>dt :call GotoWindow(g:vimspector_session_windows.tagpage)<cr>
nnoremap <leader>dv :call GotoWindow(g:vimspector_session_windows.variables)<cr>
nnoremap <leader>dw :call GotoWindow(g:vimspector_session_windows.watches)<cr>
nnoremap <leader>ds :call GotoWindow(g:vimspector_session_windows.stack_trace)<cr>
nnoremap <leader>do :call GotoWindow(g:vimspector_session_windows.output)<cr>
nnoremap <leader>de :call vimspector#Reset()<cr>

nmap <leader>dl <Plug>VimspectorStepInto
nmap <leader>dj <Plug>VimspectorStepOver
nmap <leader>dk <Plug>VimspectorStepOut
nmap <leader>d_ <Plug>VimspectorRestart
nnoremap <leader>d<space> :call vimspector#Continue()<cr>

nmap <leader>drc <Plug>VimspectorRunToCursor
nmap <leader>dbb <Plug>VimspectorToggleBreakpoint
nmap <leader>dbc <Plug>VimspectorToggleConditionalBreakpoint
nmap <leader>dbl <Plug>VimspectorToggleLogpoint

" Maximizer
nnoremap <leader>m :MaximizerToggle!<cr>

" Open new empty buffer
nnoremap <leader>n :enew<cr>

" Undo tree
nnoremap <leader>u :UndotreeToggle<cr>

" Don't jump to next occurance when searching under word
nnoremap * *N

" ============================================================
" OTHER

:lua <<EOF
require('nvim-treesitter.configs').setup {
  -- Modules and its options go here
  highlight = { enable = true },
  incremental_selection = { enable = true },
  textobjects = {
    -- enable = true,
    select = {
      enable = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner"
      }
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>a"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>A"] = "@parameter.inner",
      },
    },
  },
}
-- local previewers = require('telescope.previewers')
-- local putils = require('telescope.previewers.utils')
-- local path = require('telescope.path')
-- local pfiletype = require('plenary.filetype')

-- local new_maker = function(filepath, bufnr, bufname, use_ft_detect, callback)
--   if use_ft_detect == nil then use_ft_detect = true end
--   local ft = use_ft_detect and pfiletype.detect(filepath)

--   if bufname ~= filepath then
--     path.read_file_async(filepath, vim.schedule_wrap(function(data)
--       vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, vim.split(data, --\r\n--))

--       if callback then callback(bufnr) end
--     end))
--   else
--     if callback then callback(bufnr) end
--   end

--   putils.highlighter(bufnr, ft)
-- end
-- require('telescope').setup {
--   defaults = {
--     buffer_previewer_maker = new_maker,
--     file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
--     grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
--     qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
--   }
-- }
-- require('telescope').load_extension('fzy_native')
EOF
