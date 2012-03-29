"for Terminal on Mac / Linux
"----------------------------------------------------
" Notice
"----------------------------------------------------
" ss で:registersとか:marksとか色々表示する系のkey mapを一覧する.  上手くuniteと使い分けたい.
" CUIでは*レジスタが使えない. "*yとか出来ない...
" <Leader>he で.vimrcをすぐに表示する. ToDoとかささっと見てささっと解決したい.
" Uniteを積極的に使いたい. qflist(Quickfix), file etc...
"----------------------------------------------------
" TODO
"----------------------------------------------------
" 必要な時に重い設定行を読まない様に出来ると良い様なそうでも無い様な.
" :e dir1/dir2/txt などとしたいときに, dir1を選択した後に直下のファイルを一覧させたいが良い方法はあるか. 今は<Space><BS><Tab>してる.
" helpを:splitじゃなくて:onlyで開きたい.
" set mouse=a 環境でのyank
" set mouse=してマウスで範囲選択+<D-c>
" surround.vimのキーバインドをまともにしたい気がする. 『Vimの極め方』 http://whileimautomaton.net/2008/08/vimworkshop3-kana-presentation
" outliner的な記述が出来るpluginで使えるものはないか.(howm-mode.vim, QFixHowm, VimOrganizer, vim-orgmode)
"
" *unite
" もっと積極的に使っていきたいが, uniteに頼るようになるのはそれはそれで不安な気もしてくる.
" ノーマルモード lでディレクトリを潜りたい.
"
" neocomplcacheのカラー設定
" sudo関連の扱い
" Diff関連について. savevers.vimとか.
" Sessionの使い方を確認し, キーバインドを考える.
" 
" augroupを上手く使いたい.
" Quickfix周り

"----------------------------------------------------
" Pre
"----------------------------------------------------
" 設定されているautocmdをクリア.
autocmd!

"----------------------------------------------------
" Basic
"----------------------------------------------------
" vi非互換モード
set nocompatible
" ビープ音を鳴らさない
set vb t_vb=
" バックスペースキーで削除できるものを指定
set backspace=indent,eol,start
" 共有クリップボードを使う
" set clipboard+=unnamed
" ヘルプドキュメントの検索順
set helplang=ja
" バッファを切替えてもundoの効力を失わない
set hidden
" 改行コードの自動認識
set fileformats=unix,dos,mac
" [変更あり]" の代わりに "[+]" を表示
set shortmess& shortmess+=m

" K でVim helpを検索する
set keywordprg=:help

" 日本語helpの一部に開けない物があるのでその対策.
set notagbsearch

" windowの境界だけマウスホイールで変えたい
if has('mouse')
	set mouse& mouse+=a
	" map <ScrollWheelUp> <Nop>
	" map <ScrollWheelDown> <Nop>
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
colorscheme default
set number							" 行番号表示
set showmode						"モード表示
set title							"編集中のファイル名を表示
set ruler							"ルーラーを表示
set showcmd							"入力中のコマンドをステータスに表示する
set showmatch						"括弧入力時の対応する括弧を表示
set laststatus=2					"ステータスラインを常に表示
set wildmenu						" コマンドライン補完拡張
set wildmode=list:longest,full
set matchtime=2						" 対応する括弧の表示時間を2にする
syntax on							" シンタックスハイライト

" 全角スペースを明示
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
match ZenkakuSpace /　/

" ステータスラインに表示する情報の指定
set statusline=%n\:%y%F\ \|%{(&fenc!=''?&fenc:&enc).'\|'.&ff.'\|'}%m%r%=<%l/%L:%p%%>

" for debian
" コメント文の色を変更
" highlight Comment ctermfg=lightcyan
" highlight Comment ctermfg=lightblue

" ステータスラインの色
" highlight StatusLine   term=NONE cterm=NONE ctermfg=black ctermbg=white

"----------------------------------------------------
" Search
"----------------------------------------------------
set ignorecase						" 検索の時に大文字小文字を区別しない
set smartcase						" 検索の時に大文字が含まれている場合は区別して検索する
set wrapscan						" 最後まで検索したら先頭に戻る
set incsearch						" インクリメンタルサーチを使う
set hlsearch						" 検索結果文字列のハイライト表示
set history=100						" コマンド、検索パターンを100個まで履歴に残す

"----------------------------------------------------
" べんり
"----------------------------------------------------
filetype plugin indent on " ファイルタイプ判定をon
autocmd BufNewFile *.rb 0r ~/.vim/template/skeleton.ruby
autocmd FileType ruby setlocal ts=2 | set sw=2 | set expandtab | let ruby_space_errors = 1
" autocmd BufNewFile,BufRead *.yaml set filetype=ruby
autocmd FileType yaml setlocal filetype=ruby
" ファイルを開いた際に、前回終了時の行で起動
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

autocmd QuickfixCmdPost grep,grepadd,vimgrep copen

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
" 『viで日本語の文字コードを自動判別 - 玉虫色に染まれ！』 http://d.hatena.ne.jp/over80/20080907/1220794834
" fileencodingsの設定ではencodingで設定している値を一番最後に記述する
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
"set fileencodings=ucs-bom,iso-2022-jp,euc-jp,sjis,cp932,ucs-2le,ucs-2,utf-8
set fileencodings=ucs-bom,iso-2022-jp,euc-jp,sjis,cp932,utf-8

" au BufWritePost * call SetUTF8Xattr(expand("<afile>"))

" function! SetUTF8Xattr(file)
	" let isutf8 = &fileencoding == "utf-8" || ( &fileencoding == "" && &encoding == "utf-8")
	" if has("unix") && match(system("uname"),'Darwin') != -1
		" call system("xattr -w com.apple.TextEncoding 'utf-8;134217984' '" . a:file . "'")
	" endif
" endfunction

"----------------------------------------------------
" Key Mapping
"----------------------------------------------------
" 修飾キーについて
" 『ぼちぼち散歩 ku source:
" mrufileとmrucommand続き，およびMac上のVimでOptionキーを扱う方法』 http://relaxedcolumn.blog8.fc2.com/blog-entry-152.html

" CTRL-s はttyでstopとして使われてた. 同様にCTRL-qはstart
"
" TODO
" <修飾キー-Tab>は使えなかった. 修飾キーはM, Cが使えた. 但しMは, Terminal.appでoptionをMetaとして使うにチェックする.
" helpでは"<D-"でCommand Keyが使えるとしているけれど, 設定しても使えなかった.
 
" *後で何かに割り当てるKey
" CTRL-G CTRL-K CTRL-N CTRL-M i_CTRL-M CTRL-P i_CTRL-J i_CTRL-K
" c C

" omapを使って整理したい様な気がする.

" *確認したい
" i_CTRL-X_CTRL_{x} なキーバインドについて確認.

" *使う
" i_CTRL-X_CTRL-L i_CTRL-M
" mark: m{a-zA-Z} , call: '{a-zA-Z}
" Exモード(連続コマンド): Q or gQ :vi[sual]で抜ける.

let mapleader = ";"
nnoremap <SLeader> <Nop>
nmap , <SLeader>

nnoremap <Leader>hh :<C-u>tabnew<CR>:h<Space>
nnoremap <Leader>he :<C-u>tabnew<CR>:e $MYVIMRC<CR>
nnoremap <Leader>hr :<C-u>w<CR>:source $MYVIMRC<CR>

" Window, Tab関連
nnoremap <silent> <C-h> :<C-u>tabprevious<CR>
nnoremap <silent> <C-l> :<C-u>tabnext<CR>
" nnoremap <silent> <C-p> :<C-u>tabprevious<CR>
" nnoremap <silent> <C-n> :<C-u>tabnext<CR>
" tabmうごかない
" nnoremap gr gT
nnoremap <silent> <Esc><C-h> :<C-u>execute 'tabmove' tabpagenr() -2<CR>
nnoremap <silent> <Esc><C-l> :<C-u>execute 'tabmove' tabpagenr()<CR>
nnoremap <silent> g0 :<C-u>tabfirst<CR>
nnoremap <silent> g9 :<C-u>tablast<CR>
" tmuxで<C-t>をprefix keyに使う様になったので退避
" nnoremap <silent> <C-w><C-t> :<C-u>tabnew<CR>
nnoremap <silent> <C-w>t :<C-u>tabnew<CR>
noremap <C-j> 5j
noremap <C-k> 5k

" tagsearch
nnoremap <C-t> <Nop>
nnoremap <C-t><C-t> <C-]>
nnoremap <C-t><C-j> :<C-u>tag<CR>
nnoremap <C-t><C-k> :<C-u>pop<CR>
nnoremap <C-t><C-h> :<C-u>tags<CR>
nnoremap st :<C-u>tags<CR>
nnoremap sT :<C-u>map <C-T><CR>

nnoremap <silent> <Esc><Esc> :<C-u>nohlsearch<CR>
" Yでクリップボードにコピー
noremap Y "*yy
nnoremap s <Nop>
nnoremap ss :<C-u>nmap s<CR>
nnoremap sm :<C-u>marks<CR>
nnoremap sr :<C-u>registers<CR>
nnoremap sc :<C-u>changes<CR>
nnoremap sb :<C-u>buffers<CR>

inoremap <C-a> <Esc>I
inoremap <C-e> <Esc>A

" nnoremap <C-n> :cnext<CR>
" nnoremap <C-p> :cprevious<CR>

"----------------------------------------------------
" Plugins
"----------------------------------------------------
" vundle.vim
filetype off
if has('vim_starting')
	set rtp& rtp+=~/.vim/vundle.git/ 
	call vundle#rc()
endif
" My Bundles here:
" original repos on github
Bundle 'surround.vim'
Bundle 'renamer.vim'
Bundle 'Shougo/neocomplcache'
" Bundle 'Shougo/neocomplcache-snippets-complete'
Bundle 'Shougo/unite.vim'
Bundle 'h1mesuke/unite-outline'
Bundle 'tsukkee/unite-help'
Bundle 'thinca/vim-unite-history'
Bundle 'soh335/unite-qflist'
Bundle 'vim-ruby/vim-ruby'
Bundle 'scrooloose/nerdcommenter'
Bundle 'thinca/vim-quickrun'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'chrisbra/SudoEdit.vim'
" Bundle 'sudo.vim'
"" Bundle 'ujihisa/quickrun'
Bundle 'thinca/vim-ref'
Bundle 'Shougo/vimfiler'
" Bundle 'Shougo/vimproc'
" Bundle 'Shougo/vimshell'
Bundle 'kien/ctrlp.vim'
" Bundle 'mattn/benchvimrc-vim'
" ↑ 必要なもの / ↓ あんまり要らないもの
" Bundle 'Lokaltog/vim-easymotion'
Bundle 'kana/vim-grex'
" Bundle 'kana/vim-operator-user'
" Bundle 'kana/vim-operator-replace'
" Bundle 'thinca/vim-visualstar'
" Bundle 'tyru/operator-star.vim' " dependent for: visualstar, operator-user
" Bundle 'Shougo/echodoc'
" Bundle 'tyru/caw.vim'
"" Bundle 'vim-fugitive'

"" vim-scripts repos
" Bundle 'smartword'
" Bundle 'smartchr'
" Bundle 'hsitz/VimOrganizer'
" Bundle 'jceb/vim-orgmode'
" Bundle 'hz_ja.vim'
"" Bundle 'grep.vim'
"" Bundle 'taglist.vim'
" non github repos
" Bundle 'git://git.wincent.com/command-t.git'

filetype plugin indent on 

" Unite.vim
" -auto-preview はそれなりに重いので慎重に.
" -no-quit -vertical g:unite_winwidth -buffer-name
" dotfileを表示するには
nnoremap su :map [unite]<CR>
nmap U [unite]
nnoremap [unite] <Nop>
nnoremap <silent> [unite]U :<C-u>Unite<Space>
nnoremap <silent> [unite]S :<C-u>Unite source<CR>
nnoremap <silent> [unite]F :<C-u>Unite file file_mru -vertical -winwidth=70 -no-quit<CR>
nnoremap <silent> [unite]f :<C-u>Unite file<CR>
nnoremap <silent> [unite]O :<C-u>Unite outline<CR>
nnoremap <silent> [unite]H :<C-u>Unite -start-insert help<CR>
nnoremap <silent> [unite]R :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> [unite]Q :<C-u>Unite qflist -no-quit -auto-preview<CR>

nnoremap <silent> [unite]A :<C-u>Unite buffer bookmark file file_mru<CR>
nnoremap <silent> [unite]B :<C-u>Unite bookmark file_mru<CR>
nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
nnoremap <silent> [unite]M :<C-u>Unite file_mru<CR>
nnoremap <silent> [unite]T :<C-u>Unite tab<CR>

nnoremap <silent> [unite]WC :<C-u>UniteWithCurrentDir file file_mru -vertical -winwidth=70 -no-quit<CR>
nnoremap <silent> [unite]Wc :<C-u>UniteWithCurrentDir file file_mru<CR>
nnoremap <silent> [unite]WB :<C-u>UniteWithBufferDir file file_mru -vertical -winwidth=70 -no-quit<CR>
nnoremap <silent> [unite]Wb :<C-u>UniteWithBufferDir file file_mru<CR>
" nnoremap <silent> [unite]WB :<C-u>UniteWithBufferDir -prompt=%\  buffer file_mru bookmark file<CR>

let g:unite_cursor_line_highlight = 'TabLineSel'
" let g:unite_winwidth = 60
" let g:unite_abbr_highlight = 'TabLine'
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()"{{{
	" CTRL-hをhで代替したい
	imap <buffer> jj <Plug>(unite_insert_leave)
	nmap <buffer> h <Plug>(unite_delete_backward_path)
	" TODO: ノーマルモード lでディレクトリを潜りたい.
	imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
	nmap <buffer> <C-h> :tabprevious<CR>
	nmap <buffer> <C-l> :tabnext<CR>
	" nmap <silent> <buffer> <expr> <C-p> unite#do_action('vsplit')
	" imap <silent> <buffer> <expr> <C-p> unite#do_action('vsplit')

	" <C-l>: manual neocomplcache completion.
	" inoremap <buffer> <C-l> <C-x><C-u><C-p><Down>

	" Start insert.
	"let g:unite_enable_start_insert = 1
endfunction"}}}

" SudoEdit.vim, sudo.vim
command! WS SudoWrite %

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

" let g:neocomplcache_omni_functions = {
	" \ 'python' : 'pythoncomplete#Complete',
	" \ 'ruby' : 'rubycomplete#Complete',
	" \ }

" <CR>: close popup
inoremap <expr><CR> pumvisible() ? neocomplcache#smart_close_popup() : "\<CR>"
" <TAB>: completion.
" inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" 補完を選択しポップアップを閉じる
" inoremap <expr><C-y> neocomplcache#close_popup()
" 補完をキャンセルしpopupを閉じる
" inoremap <expr><C-e> neocomplcache#cancel_popup()
" <C-u>で補完をキャンセルしてから行頭まで削除する. 上手く動かない.
" inoremap <expr><C-u> neocomplcache#cancel_popup() . "\<C-u>"

" Snippets
" imap <C-k> <Plug>(neocomplcache_snippets_expand)
" smap <C-k> <Plug>(neocomplcache_snippets_expand)

" inoremap <expr><C-g> neocomplcache#undo_completion()
" inoremap <expr><C-l> neocomplcache#complete_common_string()

" Snippetsを編集する
" command! -nargs=* Nes NeoComplCacheEditSnippets

" FileType別のOmni Completion設定
" Vimに対して設定
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
" autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
autocmd FileType c setlocal omnifunc=ccomplete#Complete
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
	let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'

" NERD_commenter.vim
let g:NERDCreateDefaultMappings = 0 " 自由にMappingを設定する
map <Leader>c <plug>NERDCommenterToggle
let NERDSpaceDelims = 1 " コメントの間にスペースを入れる

" vim-indent-guides
" default mapping for ":IndentGuidestoggle"is <Leader>ig
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
let g:indent_guides_guide_size = 1
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=233
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=235

" QuickRun.vim
" let g:quickrun_no_default_key_mappings = 1
map <Leader>R <Plug>(quickrun)
map <Leader>rr :<C-u>Ref<Space>refe<Space>
map <Leader>rm :<C-u>Ref<Space>man<Space>

" ctrlp.vim
let g:ctrlp_map = '<C-^>'

" VTreeExplorer
" let g:treeExplVertical=1
" let g:treeExplWinSize=30

" operator-replace
" map _ <Plug>(operator-replace)

" vim-easymotion.vim
" let g:EasyMotion_do_shade = 0

" smartchr.vim
" inoremap <expr> = smartchr#one_of(' = ', ' == ', '=')

" echodoc.vim
" let g:echodoc_enable_at_startup = 1

" smartword.vim
" map w  <Plug>(smartword-w)
" map b  <Plug>(smartword-b)
" map e  <Plug>(smartword-e)
" map ge  <Plug>(smartword-ge)

