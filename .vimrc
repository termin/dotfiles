" for Mac
"--------------------
" Notice
"--------------------
" 参考:
" Mac OSXでのvim環境整理。.vimrcやらオヌヌメPlug inやらまとめ。 - ゆろよろ日記
" http://d.hatena.ne.jp/yuroyoro/20101104/1288879591
"--------------------
" 基本
"--------------------
set nocompatible "vi非互換モード
set vb t_vb= " ビープ音を鳴らさない
let mapleader = ","
" バックスペースキーで削除できるものを指定
set backspace=indent,eol,start " backspaceで削除出来るものを選択
" set clipboard=unnamed " 共有クリップボードを使う
"set helplang=ja,en " ヘルプドキュメントの検索順
set hidden " バッファを切替えてもundoの効力を失わない

"----------------------------------------------------
" バックアップ関係
"----------------------------------------------------
"set nobackup " バックアップをとらない
" ファイルの上書きの前にバックアップを作る。(ただし、backup がオンでない限り、バックアップは上書きに成功した後削除される)
"set writebackup
"set backup
"set backupdir=~/backup " バックアップファイルを作るディレクトリ
"set directory=~/swap " スワップファイルを作るディレクトリ

"--------------------
" 表示系
"--------------------
set number "行番号表示
set showmode "モード表示
set title "編集中のファイル名を表示
set ruler "ルーラーの表示
set showcmd "入力中のコマンドをステータスに表示する
set showmatch "括弧入力時の対応する括弧を表示
set laststatus=2 "ステータスラインを常に表示
set wildmenu "tabでの補完候補を表示
set matchtime=2 " 対応する括弧の表示時間を2にする
syntax on "カラー表示

" 全角スペースを明示
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
match ZenkakuSpace /　/

" for debian
" コメント文の色を変更
"highlight Comment ctermfg=lightcyan
"highlight Comment ctermfg=lightblue
" 全角スペースの表示
"highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
"match ZenkakuSpace /　/
" ステータスラインに表示する情報の指定
"set statusline=%n\:%y%F\ \|%{(&fenc!=''?&fenc:&enc).'\|'.&ff.'\|'}%m%r%=<%l/%L:%p%%>

" pathogen.vim
"pathogenでftdetectなどをloadさせるために一度ファイルタイプ判定をoff
filetype off
" pathogen.vimによってbundle配下のpluginをpathに加える
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
" set helpfile=$VIMRUNTIME/doc/help.txt
" set helpfile=$HOME/.vim/bundle/vimdoc_ja/doc/help.jax
filetype plugin indent on " ファイルタイプ判定をon

"----------------------------------------------------
" 検索関係
"----------------------------------------------------
set ignorecase " 検索の時に大文字小文字を区別しない
set smartcase " 検索の時に大文字が含まれている場合は区別して検索する
set wrapscan " 最後まで検索したら先頭に戻る
set incsearch " インクリメンタルサーチを使う
set hlsearch "検索結果文字列のハイライト表示
" Ctrl-iでヘルプ
nnoremap <C-i>  :<C-u>help<Space>
" カーソル下のキーワードをヘルプでひく
nnoremap <C-i><C-i> :<C-u>help<Space><C-r><C-w><Enter>

"--------------------
" コーディングの為の協奏曲
"--------------------
autocmd BufNewFile	*.rb	0r	~/.vim/template/skeleton.ruby
autocmd FileType ruby set ts=2 | set sw=2 | set expandtab | let ruby_space_errors = 1
" ファイルを開いた際に、前回終了時の行で起動
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

"--------------------
" インデント
"--------------------
set autoindent
set smartindent
"set paste " ペースト時にindent関連をoffにする他様々色々それぞれ。
"set expandtab "タブの代わりに空白文字挿入
" tabstop: タブが対応する空白の数
" shiftwidth: インデントの各段階に使われる空白の数
" softtabstop: タブやバックスペースの使用等の編集操作をするときに、タブが対応する空白の数
set ts=4 sw=4 sts=0 

"----------------------------------------------------
" encoding
"----------------------------------------------------
" 文字コードの設定
" fileencodingsの設定ではencodingの値を一番最後に記述する
" set encoding=utf-8
" set termencoding=utf-8
" set fileencoding=utf-8
" set fileencodings=ucs-bom,euc-jp,cp932,iso-2022-jp
" set fileencodings+=,ucs-2le,ucs-2,utf-8

"--------------------
" vim scripts
"--------------------
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
" map <Leader>x, c<space> " <Leader>xでコメントをトグル
let NERDSpaceDelims = 1 " コメントの間にスペースを入れる

" QuickRun.vim
" Mappingを自由に設定する
" g:quickrun_no_default_key_mappings = 1

" VTreeExplorer
" let g:treeExplVertical=1
" let g:treeExplWinSize=30

"--------------------
" Key Mapping
"--------------------
map <Leader>rr :Ref<Space>refe<Space>
map <Leader>rm :Ref<Space>man<Space>
"nmap <C-S-tab> :tabprevious<CR>
"nmap <C-tab> :tabnext<CR>
"map <C-S-tab> :tabprevious<CR>
"map <C-tab> :tabnext<CR>
"imap <C-S-tab> <ESC>:tabprevious<CR>i
"imap <C-tab> <ESC>:tabnext<CR>i
nnoremap <Esc><Esc> :nohlsearch<CR>
"map <C-w> :tabclose<CR>
nmap <C-t> :tabnew<CR>
imap <C-t> <ESC>:tabnew<CR> 
map g1 :tabfirst<CR>
map g9 :tablast<CR>

