" for Mac
"#######################
" 基本
"#######################
" バックスペースキーで削除できるものを指定
" indent  : 行頭の空白
" eol     : 改行
" start   : 挿入モード開始位置より手前の文字
set backspace=indent,eol,start

set nocompatible "vi非互換モード
"#######################
" 表示系
"#######################
set number "行番号表示
set showmode "モード表示
set title "編集中のファイル名を表示
set ruler "ルーラーの表示
set showcmd "入力中のコマンドをステータスに表示する
set showmatch "括弧入力時の対応する括弧を表示
set laststatus=2 "ステータスラインを常に表示
set wildmenu "tabでの補完候補を表示
"#######################
" プログラミングヘルプ系
"#######################
syntax on "カラー表示
set smartindent "オートインデント
"set autoindent
" tab関連
"set expandtab "タブの代わりに空白文字挿入
set ts=4 sw=4 sts=0 

autocmd BufNewFile	*.rb	0r	~/.vim/template/skeleton.ruby

filetype plugin indent on
autocmd FileType ruby set ts=2 | set sw=2 | set expandtab 

" ファイルを開いた際に、前回終了時の行で起動
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif
"#######################
" 検索系
"#######################
set ignorecase "検索文字列が小文字の場合は大文字小文字を区別なく検索する
set smartcase "検索文字列に大文字が含まれている場合は区別して検索する
set wrapscan "検索時に最後まで行ったら最初に戻る
"set noincsearch "検索文字列入力時に順次対象文字列にヒットさせない
set hlsearch "検索結果文字列のハイライト表示
set incsearch "インクリメンタルサーチ

"#######################
"nmap <C-S-tab> :tabprevious<cr>
"nmap <C-tab> :tabnext<cr>
"map <C-S-tab> :tabprevious<cr>
"map <C-tab> :tabnext<cr>
"imap <C-S-tab> <ESC>:tabprevious<cr>i
"imap <C-tab> <ESC>:tabnext<cr>i
map <C-w> :tabclose<cr>
nmap <C-t> :tabnew<cr>
imap <C-t> <ESC>:tabnew<cr> 

