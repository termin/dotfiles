"----------------------------------------------------
" Pre
"----------------------------------------------------
set encoding=utf-8
scriptencoding utf-8 " これ以降マルチバイト可. encodingを先に書く
" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

" mapping削除
mapclear

let s:enable_plugins = 1 " pluginを使わなければここで設定

"----------------------------------------------------
" Notice
"----------------------------------------------------
" パッケージマネージャーにvim-jetpackが必要
" https://github.com/tani/vim-jetpack
"
" ss で:registersとか:marksとか色々表示する系のkey mapを一覧する.
" <Leader>he で.vimrcをすぐに表示する. ToDoとかささっと見てささっと解決したい.
"
" Mac標準のvimはhas('mac'), has('macunix')が0だが自前でbuildすれば1.

"----------------------------------------------------
" Basic
"----------------------------------------------------
set vb t_vb=
set backspace=indent,eol,start
" set clipboard+=unnamed
set helplang=ja
set hidden
set fileformats=unix,dos,mac
set shortmess& shortmess+=m

set keywordprg=:help " K でVim helpを検索する

set notagbsearch " 日本語helpの一部に開けない物があるのでその対策

" if has('mouse')
  " set mouse& mouse+=a
  " " map <ScrollWheelUp> <Nop>
  " " map <ScrollWheelDown> <Nop>
  " map <S-ScrollWheelUp> <Nop>
  " map <S-ScrollWheelDown> <Nop>
  " map <C-ScrollWheelUp> <Nop>
  " map <C-ScrollWheelDown> <Nop>
  " map <M-ScrollWheelUp> <Nop>
  " map <M-ScrollWheelDown> <Nop>
" endif

"----------------------------------------------------
" Backup
"----------------------------------------------------
" バックアップをとる
" set backup
" ファイルの上書きの前にバックアップを作る. ただし, backup がオンでない限り、バックアップは上書きに成功した後削除される.
" set writebackup
" バックアップファイルを作るディレクトリ
" set backupdir=~/backup
" スワップファイルを作るディレクトリ
" set directory=~/swap

"----------------------------------------------------
" Appearance
"----------------------------------------------------
if has('termguicolors') && $COLORTERM == "truecolor" && s:enable_plugins
  " cf. :h xterm-true-color
  set termguicolors
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

colorscheme default
set background=dark
set number
set title
set ruler
set showcmd
set showmatch
set matchtime=2
set laststatus=2
set wildmenu
set wildmode=list:longest,full

augroup Highlight
  autocmd!
  highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
  autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
  highlight TrailingSpace ctermbg=darkred guibg=darkred
  autocmd VimEnter,WinEnter * match TrailingSpace /\s\+$/
augroup END

" ステータスラインに表示する情報の指定
set statusline=%n\:%y%F\ \|%{(&fenc!=''?&fenc:&enc).'\|'.&ff.'\|'}%m%r%=<%l/%L:%p%%>

" for debian
" コメント文の色を変更
" highlight Comment ctermfg=lightcyan
" highlight Comment ctermfg=lightblue

" highlight StatusLine   term=NONE cterm=NONE ctermfg=black ctermbg=white

" augroup Quickfix
  " autocmd!
  " autocmd QuickfixCmdPost grep,grepadd,vimgrep copen
" augroup END

"----------------------------------------------------
" Search
"----------------------------------------------------
set ignorecase
set smartcase
set incsearch
set hlsearch
set history=100

"----------------------------------------------------
" Indent
"----------------------------------------------------
set autoindent
set smartindent
" set expandtab
set tabstop=4
set shiftwidth=4
" set softtabstop=0
if exists('+breakindent')
  set breakindent
endif

"----------------------------------------------------
" べんり
"----------------------------------------------------
filetype plugin indent on
set pastetoggle=<F2>
augroup Indent
  autocmd!
  autocmd BufNewFile *.rb 0r ~/.vim/template/skeleton.ruby
  autocmd FileType ruby setlocal tabstop=2 shiftwidth=2 expandtab | let ruby_space_errors = 1
  autocmd BufNewFile,BufRead *.erb setlocal tabstop=2 shiftwidth=2 expandtab

  " ファイルを開いた際に、前回終了時の行で起動
  autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

  " インサートモードを抜けたときにpaste解除
  autocmd InsertLeave * set nopaste

  autocmd BufNewFile,BufRead *.ctp setlocal filetype=php
  autocmd FileType php setlocal tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab
  autocmd FileType cpp setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType json setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
augroup END

" pluginが入っていればrbtnn/vim-ambiwidth でsingleに上書き
" cf. https://twitter.com/mattn_jp/status/1526718582264320000
set ambiwidth=double

"----------------------------------------------------
" Encoding
"----------------------------------------------------
" 文字コードの設定
" 『viで日本語の文字コードを自動判別 - 玉虫色に染まれ！』 http://d.hatena.ne.jp/over80/20080907/1220794834
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,ucs-bom,iso-2022-jp,euc-jp,sjis,cp932
" set fileencodings=ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932,utf-8

"----------------------------------------------------
" Key Mapping
"----------------------------------------------------
" 修飾キーについて
" 『ぼちぼち散歩 ku source:
" mrufileとmrucommand続き，およびMac上のVimでOptionキーを扱う方法』 http://relaxedcolumn.blog8.fc2.com/blog-entry-152.html

" CTRL-s はttyでstopとして使われてた. 同様にCTRL-qはstart
"
" Mac Terminal.appの場合
" <修飾キー-Tab>は使えなかった. 修飾キーはM, Cが使えた. 但しMは, Terminal.appでoptionをMetaとして使うにチェックする.
" <Right>, <Left> 等はどうやっても使えない感じ.
" helpでは"<D-"でCommand Keyが使えるとしているけれど, 設定しても使えなかった.

let mapleader = ";"

noremap <F1> <Nop>
inoremap <F1> <Nop>

" cf. 『端末の Vim でも Alt キーを使う - 永遠に未完成』 http://d.hatena.ne.jp/thinca/20101215/1292340358
if has('mac') && !has('gui_running')
  " Use meta keys in console.
  function! s:use_meta_keys()  " {{{
    for i in map(
    \   range(char2nr('a'), char2nr('z'))
    \ + range(char2nr('A'), char2nr('Z'))
    \ + range(char2nr('0'), char2nr('9'))
    \ , 'nr2char(v:val)')
      " <ESC>O do not map because used by arrow keys.
      if i != 'O'
        execute 'nmap <ESC>' . i '<M-' . i . '>'
      endif
    endfor
  endfunction  " }}}

  call s:use_meta_keys()
  " map <NUL> <C-Space>
  " map! <NUL> <C-Space>
endif

" let $MYVIMRC = ""
nnoremap <Leader>hh :<C-u>tabnew<CR>:h<Space>
nnoremap <Leader>he :<C-u>tabnew<CR>:e $MYVIMRC<CR>
nnoremap <Leader>hr :<C-u>w<CR>:source $MYVIMRC<CR>

" Window, Tab関連
nnoremap <silent> <C-h> :<C-u>tabprevious<CR>
nnoremap <silent> <C-l> :<C-u>tabnext<CR>
" nnoremap gr gT
nnoremap <silent> <A-S-h> :<C-u>execute 'tabmove' tabpagenr() - 2<CR>
nnoremap <silent> <A-S-l> :<C-u>execute 'tabmove' tabpagenr() + 1<CR>
nnoremap <silent> g0 :<C-u>tabfirst<CR>
nnoremap <silent> g9 :<C-u>tablast<CR>
nnoremap <silent> <C-w>t :<C-u>tabnew<CR>
noremap <C-j> 5j
noremap <C-k> 5k

" tagsearch
nnoremap <A-t> <Nop>
nnoremap <A-t><A-t> <C-]>
nnoremap <A-t><A-j> :<C-u>tag<CR>
nnoremap <A-t><A-k> :<C-u>pop<CR>
nnoremap <A-t><A-h> :<C-u>tags<CR>
nnoremap st :<C-u>tags<CR>
nnoremap sT :<C-u>map<C-T><CR>

" Yでクリップボードにコピー
noremap Y "*yy
nnoremap s <Nop>
nnoremap ss :<C-u>nmap s<CR>
nnoremap sm :<C-u>marks<CR>
nnoremap sr :<C-u>registers<CR>
nnoremap sc :<C-u>changes<CR>
nnoremap sb :<C-u>buffers<CR>
nnoremap s<Leader> :<C-u>map <Leader><CR>

"----------------------------------------------------
" Plugins
"----------------------------------------------------
if &compatible
  set nocompatible " 『vimrcアンチパターン - rbtnn雑記』 http://rbtnn.hateblo.jp/entry/2014/11/30/174749
endif

if !s:enable_plugins
filetype plugin indent on
syntax on
else

packadd vim-jetpack
call jetpack#begin()
Jetpack 'tani/vim-jetpack', {'opt': 1} " bootstrap
" if !has('nvim')
"   Jetpack 'roxma/nvim-yarp'
"   Jetpack 'roxma/vim-hug-neovim-rpc'
" endif
" Jetpack 'Shougo/vimproc', {'do': 'make'}

" Jetpack 'vim-airline/vim-airline'
Jetpack 'dracula/vim', { 'as': 'dracula' }
" Jetpack 'cocopon/iceberg.vim'
" Jetpack 'arcticicestudio/nord-vim'
Jetpack 'itchyny/lightline.vim'
Jetpack 'ryanoasis/vim-devicons'
Jetpack 'cocopon/colorswatch.vim' " :ColorSwatchGenerate

Jetpack 'rbtnn/vim-ambiwidth'
Jetpack 'editorconfig/editorconfig-vim'
Jetpack 'tpope/vim-surround'
Jetpack 't9md/vim-surround_custom_mapping'
Jetpack 'thinca/vim-quickrun'
" Jetpack 'tyru/current-func-info.vim'
Jetpack 'scrooloose/syntastic'
" Jetpack 'vim-jp/vimdoc-ja'
Jetpack 'nathanaelkane/vim-indent-guides'
Jetpack 'kana/vim-textobj-user'
Jetpack 'osyo-manga/vim-textobj-multiblock' " depends vim-textobj-user
Jetpack 'kana/vim-repeat'
Jetpack 'tyru/caw.vim' " depends vim-repeat
Jetpack 'vim-scripts/renamer.vim', {'cmd': 'Renamer'}
" Jetpack 'ctrlpvim/ctrlp.vim'

" language {{{
Jetpack 'airblade/vim-gitgutter'
" }}}

" Jetpack 'thinca/vim-ref'
" Jetpack 'tpope/vim-fugitive'
" Jetpack 'grep.vim'
" Jetpack 'kana/vim-grex'
" Jetpack 'kana/vim-operator-replace'
" Jetpack 'kana/vim-operator-user'
" Jetpack 'kana/vim-smartword'
" Jetpack 'mattn/benchvimrc-vim'

call jetpack#end()

filetype plugin indent on
syntax on " pluginロード後に設定する cf. 『vimrcアンチパターン - rbtnn雑記』 http://rbtnn.hateblo.jp/entry/2014/11/30/174749

if jetpack#tap('lightline.vim')
  " filename => absolutepath
  " rightのcloseが不要
  let g:lightline = {
        \   'active': {
        \     'left': [ [ 'mode', 'paste' ], [ 'readonly', 'absolutepath', 'modified' ] ],
        \     'right': [ [ 'lineinfo' ], [ 'percent' ], [ 'fileformat', 'fileencoding', 'filetype' ] ]
        \   },
        \   'inactive': {
        \     'left': [ [ 'absolutepath' ] ],
        \     'right': [ [ 'lineinfo' ], [ 'percent' ] ]
        \   },
        \   'tabline': {
        \     'left': [ [ 'tabs' ] ],
        \     'right': [ ]
        \   },
        \ }
  " defaultとして
  let g:lightline.colorscheme = 'wombat'
endif

if jetpack#tap('nord-vim')
  colorscheme nord
  if jetpack#tap('lightline.vim')
    let g:lightline.colorscheme = 'nord'
  endif
endif

if jetpack#tap('dracula')
  colorscheme dracula
  if jetpack#tap('lightline.vim')
    let g:lightline.colorscheme = 'darcula'
  endif
endif

if jetpack#tap('iceberg.vim')
  colorscheme iceberg
  if jetpack#tap('lightline.vim')
    let g:lightline.colorscheme = 'iceberg'
  endif
  set background=dark
endif

if jetpack#tap('vim-surround')
  let g:surround_no_mappings = 1
  " ds:  delete a surrounding.
  " cs:  change a surrounding.
  " ys:  add a surrounding.
  " yS:  add a surrounding. 改行とインデントを含む.
  " yss: ただの行囲み.
  " {
    " ySS: 行囲み. 改行とインデントを含む. こんなかんじ.
  " }
  nmap ds <Plug>Dsurround
  nmap cs <Plug>Csurround
  nmap ys <Plug>Ysurround
  nmap yS <Plug>YSurround
  nmap yss <Plug>Yssurround
  nmap ySS <Plug>YSsurround
  vmap S <Plug>VSurround
endif

" 『t9md/vim-surround_custom_mapping · GitHub』 https://github.com/t9md/vim-surround_custom_mapping
if jetpack#tap('vim-surround_custom_mapping')
  let g:surround_custom_mapping = {}
  " filetypeに共通の設定
  let g:surround_custom_mapping._ = {
        \ 'C': "/* \r */",
        \ }

  let g:surround_custom_mapping.ruby = {
        \ 'w':  "%w(\r)",
        \ '%':  "%(\r)",
        \ '#':  "#{\r}",
        \ 'e':  "<%= \r %>",
        \ 'p':  "<% \r %>",
        \ }
  let g:surround_custom_mapping.php = {
        \ 'p': "<?php \r ?>",
        \ '[': "['\r']",
        \ 'a': "array('\r')",
        \ 'v': "var_dump(\r);",
        \ 'd': "debug(\r);",
        \ }
  let g:surround_custom_mapping.html = {
        \ 'c': "<!-- \r -->",
        \ }
endif

if jetpack#tap('vim-textobj-multiblock')
  omap ab <Plug>(textobj-multiblock-a)
  omap ib <Plug>(textobj-multiblock-i)
  vmap ab <Plug>(textobj-multiblock-a)
  vmap ib <Plug>(textobj-multiblock-i)
endif

if jetpack#tap('vim-indent-guides')
  " default mapping for ":IndentGuidestoggle"is <Leader>ig
  let g:indent_guides_enable_on_vim_startup = 1
  let g:indent_guides_auto_colors = 0
  let g:indent_guides_guide_size = 1
  augroup IndentGuides
    autocmd!
    " autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=233
    " autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=235
    autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=gray
    autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=darkgray
  augroup END
endif

if jetpack#tap('vim-quickrun')
  let g:quickrun_no_default_key_mappings = 1
  nmap <Leader>R <Plug>(quickrun)
endif

if jetpack#tap('current-func-info.vim')
  " 現在のカーソル位置の関数名を表示する
  set statusline=%n\:%y%F\ %{cfi#format('%s()','')}\|%{(&fenc!=''?&fenc:&enc).'\|'.&ff.'\|'}%m%r%=<%l/%L:%p%%>
  " let &statusline = '[%{cfi#get_func_name()}()]'
endif

if jetpack#tap('ctrlp.vim')
  let g:ctrlp_map = '<C-^>'
endif

if jetpack#tap('syntastic')
  let g:syntastic_mode_map = {
        \ "mode": "active",
        \ "passive_filetypes": ["go"] }
  let g:syntastic_go_checkers = ['go', 'golint']
  nnoremap <Leader>S :<C-u>SyntasticCheck<CR>
endif

if jetpack#tap('vim-smartword')
  map w <Plug>(smartword-w)
  map b <Plug>(smartword-b)
  map e <Plug>(smartword-e)
  map ge <Plug>(smartword-ge)
endif

endif " /s:enable_plugins

"----------------------------------------------------
" Post
"----------------------------------------------------
" 環境依存の設定
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif

" vim: tabstop=2 shiftwidth=2 expandtab
