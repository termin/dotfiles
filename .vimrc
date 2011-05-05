"for Mac / debian
"----------------------------------------------------
" Notice
"----------------------------------------------------
"----------------------------------------------------
" ToDo
"----------------------------------------------------
" Tab, Window関連のKey Mappingをまとめたい.
" wildemodeで目当ての項目に到達した後, 更に下位の項目を選択させたい時に, そのままTabではダメなのが不満.
" 何か上手い手は無いか.
" 後で何かに割り当てるKey
" t, T
" F, ;も使ってないなぁ.
"
" i_CTRL-X_CTRL_{x} なキーバインドについて調べる.
"
" bufferについて調べておきたい.
"
" helpを:splitじゃなくて:onlyで開きたい.

" set mouse=aだと, terminal.appの機能で選択, コピーが出来ない.
" 何か良い設定は無いか. clipboardはあまり使いたくない.

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

" K でVim helpを検索する
set keywordprg=:help

" windowの境界だけマウスホイールで変えたい
if has('mouse')
	set mouse=a
	map <ScrollWheelUp> <Nop>
	map <ScrollWheelDown> <Nop>
	map <S-ScrollWheelUp> <Nop>
	map <S-ScrollWheelDown> <Nop>
	map <C-ScrollWheelUp> <Nop>
	map <C-ScrollWheelDown> <Nop>
	map <M-ScrollWheelUp> <Nop>
	map <M-ScrollWheelDown> <Nop>
endif

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
set wildmode=list:longest,full
set matchtime=2 " 対応する括弧の表示時間を2にする
syntax on " シンタックスハイライト

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

"----------------------------------------------------
" Search
"----------------------------------------------------
set ignorecase " 検索の時に大文字小文字を区別しない
set smartcase " 検索の時に大文字が含まれている場合は区別して検索する
set wrapscan " 最後まで検索したら先頭に戻る
set incsearch " インクリメンタルサーチを使う
set hlsearch "検索結果文字列のハイライト表示
set history=100 " コマンド、検索パターンを100個まで履歴に残す

"--------------------
" コーディングの為の協奏曲
"--------------------
filetype plugin indent on " ファイルタイプ判定をon
autocmd BufNewFile	*.rb	0r	~/.vim/template/skeleton.ruby
autocmd FileType ruby set ts=2 | set sw=2 | set expandtab | let ruby_space_errors = 1
autocmd BufNewFile,BufRead	*.yaml	set filetype=ruby
" ファイルを開いた際に、前回終了時の行で起動
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

autocmd QuickfixCmdPost vimgrep cw

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
" 日本語helpの一部に開けない物があるのでその対策.
set notagbsearch
" vundle.vim
filetype off
set rtp+=~/.vim/vundle.git/ 
call vundle#rc()
" My Bundles here:
" original repos on github
Bundle 'Shougo/vimproc'
Bundle 'Shougo/vimshell'
" Bundle 'thinca/vim-ref'
Bundle 'Shougo/neocomplcache'
Bundle 'scrooloose/nerdcommenter'
Bundle 'thinca/vim-quickrun'
"" Bundle 'ujihisa/quickrun'
" Bundle 'Shougo/unite.vim'
Bundle 'vim-ruby/vim-ruby'
"" Bundle 'vim-fugitive'
"" vim-scripts repos
Bundle 'surround.vim'
"" Bundle 'grep.vim'
"" Bundle 'taglist.vim'
" non github repos
" Bundle 'git://git.wincent.com/command-t.git'

filetype plugin indent on 

" Unite.vim
" nnoremap <Leader>u :<C-u>Unite<Space>

" neocomplcache.vim
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
" let g:neocomplcache_enable_camel_case_completion = 1
" _を入力したときに、それを単語の区切りとしてあいまい検索を行うかどうか制御する。例えば p_h と入力したとき、public_html とマッチするようになる。1ならば有効になる。副作用があるので、初期値は0となっている。
" let g:neocomplcache_enable_underbar_completion = 1
"let g:neocomplcache_dictionary_filetype_lists =
let g:neocomplcache_snippets_dir = $HOME.'/.vim/snippets'
"let g:neocomplcache_enable_quick_match = 1 " -入力による候補番号の表示 上手く動かない

" 日本語をキャッシュしない.
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" <CR>: close popup
inoremap <expr><CR> pumvisible() ? neocomplcache#smart_close_popup() : "\<CR>"
" <TAB>: completion.
" inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" 補完を選択しポップアップを閉じる
inoremap <expr><C-y> neocomplcache#close_popup()
" 補完をキャンセルしpopupを閉じる
inoremap <expr><C-e> neocomplcache#cancel_popup()
" <C-u>で補完をキャンセルしてから行頭まで削除する. 上手く動かない.
" inoremap <expr><C-u> neocomplcache#cancel_popup() . "\<C-u>"
 
" Snippets
imap <C-k> <Plug>(neocomplcache_snippets_expand)
smap <C-k> <Plug>(neocomplcache_snippets_expand)

" inoremap <expr><C-g> neocomplcache#undo_completion()
" inoremap <expr><C-l> neocomplcache#complete_common_string()

" Snippetsを編集する
command! -nargs=* Nes NeoComplCacheEditSnippets

" FileType別のOmni Completion設定
autocmd FileType python set omnifunc=pythoncomplete#Complete
" autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
" autocmd FileType php set omnifunc=phpcomplete#CompletePHP
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
" <修飾キー-Tab>は使えなかった. 修飾キーも使えたのは<C-x>のみ. on Mac.
"map <C-Tab> :tabnext<CR>
"imap <C-Tab> <ESC>:tabnext<CR>i
" <C-l>, <C-h>って必要かな.
nmap <C-h> :tabprevious<CR>
nmap <C-l> :tabnext<CR>
" nmap <C-t><C-h> :tabprevious<CR>
" nmap <C-t><C-l> :tabnext<CR>
nmap g1 :tabfirst<CR>
nmap g9 :tablast<CR>
nnoremap <silent> <Esc><Esc> :nohlsearch<CR>
" <C-w><C-q> OR <C-w>q :quit
" <C-w>c :close
" nmap <C-t><C-t> :tabnew<CR>
nmap <C-t> :tabnew<CR>
" カーソル下のキーワードをヘルプでひく. -> keywordprgで用無し
" nnoremap <Leader>h :<C-u>help<Space><C-r><C-w><Enter>

