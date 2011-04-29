"for Mac
"----------------------------------------------------
" Notice
"----------------------------------------------------
"----------------------------------------------------
" ToDo
"----------------------------------------------------
" 日本語入力がおかしい.

"----------------------------------------------------
" Basic
"----------------------------------------------------
set nocompatible "vi非互換モード
set vb t_vb= " ビープ音を鳴らさない
let mapleader = ","
" バックスペースキーで削除できるものを指定
set backspace=indent,eol,start " バックスペースで削除出来るものを選択
" set clipboard=unnamed " 共有クリップボードを使う
" set helplang=ja,en " ヘルプドキュメントの検索順
set hidden " バッファを切替えてもundoの効力を失わない
set fileformats=unix,dos,mac " 改行コードの自動認識
set shortmess+=m " [変更あり]" の代わりに "[+]" を表示

"----------------------------------------------------
" Backup
"----------------------------------------------------
" バックアップをとる
"set backup
" ファイルの上書きの前にバックアップを作る. ただし, backup がオンでない限り、バックアップは上書きに成功した後削除される.
"set writebackup
" バックアップファイルを作るディレクトリ
"set backupdir=~/backup
" スワップファイルを作るディレクトリ
"set directory=~/swap

"----------------------------------------------------
" Appearance
"----------------------------------------------------
set number " 行番号表示
set showmode "モード表示
set title "編集中のファイル名を表示
set ruler "ルーラーを表示
set showcmd "入力中のコマンドをステータスに表示する
set showmatch "括弧入力時の対応する括弧を表示
set laststatus=2 "ステータスラインを常に表示
set wildmenu " コマンドライン補完拡張
set matchtime=2 " 対応する括弧の表示時間を2にする
syntax on " シンタックスハイライト

"----------------------------------------------------
" Search
"----------------------------------------------------
set ignorecase " 検索の時に大文字小文字を区別しない
set smartcase " 検索の時に大文字が含まれている場合は区別して検索する
set wrapscan " 最後まで検索したら先頭に戻る
set incsearch " インクリメンタルサーチを使う
set hlsearch "検索結果文字列のハイライト表示
set history=100 " コマンド、検索パターンを100個まで履歴に残す
" Ctrl-iでヘルプ
nnoremap <C-i>  :<C-u>help<Space>
" カーソル下のキーワードをヘルプでひく
nnoremap <C-i><C-i> :<C-u>help<Space><C-r><C-w><Enter>

" 全角スペースを明示
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
match ZenkakuSpace /　/

" ステータスラインに表示する情報の指定
set statusline=%n\:%y%F\ \|%{(&fenc!=''?&fenc:&enc).'\|'.&ff.'\|'}%m%r%=<%l/%L:%p%%>

" for debian
" コメント文の色を変更
"highlight Comment ctermfg=lightcyan
" highlight Comment ctermfg=lightblue

" ステータスラインの色
"highlight StatusLine   term=NONE cterm=NONE ctermfg=black ctermbg=white

"--------------------
" コーディングの為の協奏曲
"--------------------
filetype plugin indent on " ファイルタイプ判定をon
autocmd BufNewFile	*.rb	0r	~/.vim/template/skeleton.ruby
autocmd FileType ruby set ts=2 | set sw=2 | set expandtab | let ruby_space_errors = 1
autocmd BufNewFile,BufRead	*.yaml	set filetype=ruby
" ファイルを開いた際に、前回終了時の行で起動
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

"----------------------------------------------------
" Indent
"----------------------------------------------------
set autoindent
set smartindent
" set paste " ペースト時にindent関連をoffにする他様々色々それぞれ。

" tabstop: タブが対応する空白の数
" softtabstop: タブやバックスペースの使用等の編集操作をするときに、タブが対応する空白の数
" shiftwidth: インデントの各段階に使われる空白の数
set ts=4 sw=4 sts=0

"----------------------------------------------------
" Encoding
"----------------------------------------------------
" 文字コードの設定
" fileencodingsの設定ではencodingの値を一番最後に記述する
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,euc-jp,cp932,iso-2022-jp
set fileencodings+=,ucs-2le,ucs-2,utf-8

"----------------------------------------------------
" Scripts
"----------------------------------------------------
" vundle.vim
filetype off
set rtp+=~/.vim/vundle.git/ 
call vundle#rc()
" My Bundles here:
" original repos on github
Bundle 'Shougo/vimproc'
Bundle 'Shougo/vimshell'
Bundle 'thinca/vim-ref'
Bundle 'Shougo/neocomplcache'
Bundle 'scrooloose/nerdcommenter'
Bundle 'thinca/vim-quickrun'
" Bundle 'ujihisa/quickrun'
Bundle 'Shougo/unite.vim'
Bundle 'vim-ruby/vim-ruby'
" Bundle 'vim-fugitive'
" vim-scripts repos
Bundle 'surround.vim'
" Bundle 'taglist.vim'
" non github repos
" Bundle 'git://git.wincent.com/command-t.git'

filetype plugin indent on 

" pathogen.vim Vundleに乗り換え
"pathogenでftdetectなどをloadさせるために一度ファイルタイプ判定をoff
" filetype off
" pathogen.vimによってbundle配下のpluginをpathに加える
" call pathogen#runtime_append_all_bundles()
" call pathogen#helptags()
" set helpfile=$VIMRUNTIME/doc/help.txt
" set helpfile=$HOME/.vim/bundle/vimdoc_ja/doc/help.jax
" filetype plugin indent on " pathogenの為にoffにしたファイルタイプ判定をon

" neocomplcache.vim
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
" _を入力したときに、それを単語の区切りとしてあいまい検索を行うかどうか制御する。例えば p_h と入力したとき、public_html とマッチするようになる。1ならば有効になる。副作用があるので、初期値は0となっている。
"let g:neocomplcache_enable_underbar_completion = 1
"let g:neocomplcache_dictionary_filetype_lists = {
let g:neocomplcache_snippets_dir = $HOME.'/.vim/snippets'
" 補完を選択しポップアップを閉じる
inoremap <expr><C-y> neocomplcache#close_popup()
" 補完をキャンセルしpopupを閉じる
inoremap <expr><C-e> neocomplcache#cancel_popup()
"let g:neocomplcache_enable_quick_match = 1 " -入力による候補番号の表示 上手く動かない
"let g:neocomplcache_enable_auto_select = 1 " 補完候補の一番先頭を選択状態にする

" Snippets
imap <C-k> <Plug>(neocomplcache_snippets_expand)
smap <C-k> <Plug>(neocomplcache_snippets_expand)

" Snippetsを編集する
command! -nargs=* Nes NeoComplCacheEditSnippets

" FileType別のOmni Completion設定
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType ruby set omnifunc=rubycomplete#Complete
 
" NERD_commenter.vim
let g:NERDCreateDefaultMappings = 0 " 自由にMappingを設定する
map <Leader>c <plug>NERDCommenterToggle
let NERDSpaceDelims = 1 " コメントの間にスペースを入れる

" QuickRun.vim
" let g:quickrun_no_default_key_mappings = 1
map <Leader>R <Plug>(quickrun)
map <Leader>rr :Ref<Space>refe<Space>
map <Leader>rm :Ref<Space>man<Space>

" VTreeExplorer
" let g:treeExplVertical=1
" let g:treeExplWinSize=30

"----------------------------------------------------
" Key Mapping
"----------------------------------------------------
"nmap <C-S-Tab> :tabprevious<CR>
"nmap <C-Tab> :tabnext<CR>
"map <C-S-tab> :tabprevious<cr>
"map <C-tab> :tabnext<cr>
"imap <C-S-tab> <ESC>:tabprevious<cr>i
"imap <C-tab> <ESC>:tabnext<cr>i
nnoremap <silent> <Esc><Esc> :nohlsearch<CR>
"map <C-w> :tabclose<cr>
nmap <C-t> :tabnew<cr>
imap <C-t> <ESC>:tabnew<cr> 

