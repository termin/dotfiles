"for Terminal on Mac / Linux
"----------------------------------------------------
" Notice
"----------------------------------------------------
" ss で:registersとか:marksとか色々表示する系のkey mapを一覧する.
" <Leader>he で.vimrcをすぐに表示する. ToDoとかささっと見てささっと解決したい.
" Uniteを積極的に使いたい. qflist(Quickfix), file etc...
"
" Mac標準のvimはhas('mac'), has('macunix')が0だが自前でbuildすれば1.
"----------------------------------------------------
" TODO:
"----------------------------------------------------
" indent-guidesのカラー設定. もう少し目に優しい配色にしたい. 但しtmux環境下でも表示される様に.
" keymappingで<Space>を上手く使いたい
"
" tmuxを介すとwindowの区切りをマウスで移動出来ない. tmuxの設定？
" 『Vim-users.jp - Vim Hacks Project』 http://vim-users.jp/vim-hacks-project/
" :e dir1/dir2/txt などとしたいときに, dir1を選択した後に直下のファイルを一覧させたいが良い方法はあるか. 今は<Space><BS><Tab>してる.
" helpを:splitじゃなくて:onlyで開きたい.
" surround.vimのキーバインドをまともにしたい気がする. 『Vimの極め方』 http://whileimautomaton.net/2008/08/vimworkshop3-kana-presentation
" outliner的な記述が出来るpluginで使えるものはないか.(howm-mode.vim, QFixHowm, VimOrganizer, vim-orgmode)
" 検索で一番下まで検索したので上に戻るよ、メッセージを一定時間経過後に消せないか
" augroupを上手く使いたい.
" Quickfix周り
" set mouse=, set mouse=a のtoggle

"----------------------------------------------------
" Pre
"----------------------------------------------------
" 設定されているautocmdをクリア.
" TODO: augroupで書き換えたい.
autocmd!
" augroup MyAutoCmd
	" autocmd!
" augroup END

" mapping削除
mapclear

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
colorscheme default
set background=light
set number							" 行番号表示
set showmode						" モード表示
set title							" 編集中のファイル名を表示
set ruler							" ルーラーを表示
set showcmd							" 入力中のコマンドをステータスに表示する
set showmatch						" 括弧入力時の対応する括弧を表示
set laststatus=2					" ステータスラインを常に表示
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
autocmd BufNewFile,BufRead *.erb setlocal ts=2 | set sw=2 | set expandtab
" ファイルを開いた際に、前回終了時の行で起動
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif
autocmd BufNewFile,BufRead *.ctp set filetype=php
autocmd FileType php setlocal ts=4 sw=4 sts=4 noexpandtab

" autocmd QuickfixCmdPost grep,grepadd,vimgrep copen

"----------------------------------------------------
" Indent
"----------------------------------------------------
set autoindent
set smartindent
set pastetoggle=<F2>
" インサートモードを抜けたときにpaste解除
autocmd InsertLeave * set nopaste
" set expandtab
set tabstop=4
set shiftwidth=4
" set softtabstop=0

"----------------------------------------------------
" Encoding
"----------------------------------------------------
" 文字コードの設定
" 『viで日本語の文字コードを自動判別 - 玉虫色に染まれ！』 http://d.hatena.ne.jp/over80/20080907/1220794834
" fileencodingsの設定ではencodingで設定している値を一番最後に記述する
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,ucs-bom,iso-2022-jp,euc-jp,sjis,cp932


" 『Vimで 保存した UTF-8 なファイルが Quick Look で見られない問題に対処する - ヤルキデナイズドだった』 http://d.hatena.ne.jp/uasi/20110523/1306079612
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
" TODO:
" Mac Terminal.appの場合
" <修飾キー-Tab>は使えなかった. 修飾キーはM, Cが使えた. 但しMは, Terminal.appでoptionをMetaとして使うにチェックする.
" <Right>, <Left> 等はどうやっても使えない感じ.
" <M-x>は, <Esc>x で代用. <Esc><C-x>とか.
" helpでは"<D-"でCommand Keyが使えるとしているけれど, 設定しても使えなかった.

" TODO: Metaを使いたくて出来なかったキーを<Esc>で記述する.
"
" 後で何かに割り当てたい気がする
" CTRL-G CTRL-M i_CTRL-M CTRL-P i_CTRL-J i_CTRL-K
" omapを使って整理したい様な気がする.

" 確認したい
" i_CTRL-X_CTRL_{x} なキーバインドについて確認.

" 使う
" i_CTRL-X_CTRL-L
" mark: m{a-zA-Z} , call: '{a-zA-Z}
" Exモード(連続コマンド): Q or gQ :vi[sual]で抜ける.

let mapleader = ";"
nnoremap <SLeader> <Nop>
nmap , <SLeader>

noremap <F1> <Nop>
inoremap <F1> <Nop>

" c.f. 『端末の Vim でも Alt キーを使う - 永遠に未完成』 http://d.hatena.ne.jp/thinca/20101215/1292340358
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
nnoremap <silent> <Esc><S-h> :<C-u>execute 'tabmove' tabpagenr() -2<CR>
nnoremap <silent> <Esc><S-l> :<C-u>execute 'tabmove' tabpagenr()<CR>
nnoremap <silent> g0 :<C-u>tabfirst<CR>
nnoremap <silent> g9 :<C-u>tablast<CR>
nnoremap <silent> <C-w>t :<C-u>tabnew<CR>
noremap <C-j> 5j
noremap <C-k> 5k

" tagsearch
nnoremap <Esc>t <Nop>
nnoremap <Esc>t<Esc>t <C-]>
nnoremap <Esc>t<Esc>j :<C-u>tag<CR>
nnoremap <Esc>t<Esc>k :<C-u>pop<CR>
nnoremap <Esc>t<Esc>h :<C-u>tags<CR>
nnoremap st :<C-u>tags<CR>
nnoremap sT :<C-u>map<C-T><CR>

nnoremap <silent> <Esc><Esc> :<C-u>nohlsearch<CR>
" Yでクリップボードにコピー
noremap Y "*yy
nnoremap s <Nop>
nnoremap ss :<C-u>nmap s<CR>
nnoremap sm :<C-u>marks<CR>
nnoremap sr :<C-u>registers<CR>
nnoremap sc :<C-u>changes<CR>
nnoremap sb :<C-u>buffers<CR>
nnoremap s<Leader> :<C-u>map <Leader><CR>

inoremap <silent> <C-a> <Esc>I
" neocomplcacheと被ってる.でもどっちのキーバインドも使って無い.
" inoremap <silent> <C-e> <Esc>A

"----------------------------------------------------
" Plugins
"----------------------------------------------------
" neobundle.vim
filetype off
if has('vim_starting')
	set rtp& rtp+=~/.vim/bundle/neobundle.vim/
	call neobundle#rc(expand('~/.vim/bundle'))
endif

NeoBundle 'tpope/vim-surround'
NeoBundle 't9md/vim-surround_custom_mapping'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'Shougo/neocomplete'
" NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'tsukkee/unite-help'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'soh335/unite-qflist'
" NeoBundle 'sgur/unite-qf'
" NeoBundle 'ujihisa/quickrun'
NeoBundle 'tyru/current-func-info.vim'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'vim-jp/vimdoc-ja'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle "osyo-manga/vim-textobj-multiblock", {
			\ 'depends' : "kana/vim-textobj-user"
			\ }
NeoBundle 'chrisbra/SudoEdit.vim'
NeoBundle 'renamer.vim'
" vimshell, unite-source-grep の使用にvimprocが必要.
NeoBundle 'Shougo/vimproc', {
			\ 'build' : {
			\     'windows' : 'make -f make_mingw32.mak',
			\     'cygwin' : 'make -f make_cygwin.mak',
			\     'mac' : 'make -f make_mac.mak',
			\     'unix' : 'make -f make_unix.mak',
			\    },
			\ }
" NeoBundle 'Shougo/vimshell'
NeoBundle 'rhysd/migemo-search.vim'

NeoBundle 'basyura/unite-rails'
NeoBundle 'violetyk/cake.vim'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'oppara/vim-unite-cake'

" おためし {{{
NeoBundle 'tacroe/unite-mark'
NeoBundle 'tpope/vim-rails'
" NeoBundle 'tpope/vim-endwise'
NeoBundle 'vim-scripts/ruby-matchit'
" Rails completion
" NeoBundle 'taichouchou2/alpaca_complete', {
			" \ 'depends' : [ 'tpope/vim-rails', 'Shougo/neocomplcache'],
			" \	 'build' : {
			" \	 'mac' : 'gem install alpaca_complete',
			" \	 'unix' : 'gem install alpaca_complete',
			" \}}
NeoBundle 'thinca/vim-unite-history'
" NeoBundle 'kien/ctrlp.vim'
" NeoBundle 'Shougo/vimfiler'
NeoBundle 'thinca/vim-ref'
" }}}

" NeoBundle 'AndrewRadev/switch.vim'
" NeoBundle 'Lokaltog/vim-easymotion'
" NeoBundle 'Shougo/echodoc'
" NeoBundle 'grep.vim'
" NeoBundle 'hsitz/VimOrganizer'
" NeoBundle 'hz_ja.vim'
" NeoBundle 'jceb/vim-orgmode'
" NeoBundle 'kana/vim-grex'
" NeoBundle 'kana/vim-operator-replace'
" NeoBundle 'kana/vim-operator-user'
" NeoBundle 'mattn/benchvimrc-vim'
" NeoBundle 'smartchr'
" NeoBundle 'smartword'
" NeoBundle 'sudo.vim'
" NeoBundle 'taglist.vim'
" NeoBundle 'thinca/vim-visualstar'
" NeoBundle 'tyru/caw.vim'
" NeoBundle 'tyru/operator-star.vim' " dependent for: visualstar, operator-user
" NeoBundle 'ujihisa/unite-colorscheme'
" NeoBundle 'vim-fugitive'

" NeoBundle 'git://git.wincent.com/command-t.git'

filetype plugin indent on

" Unite.vim
" 『unite plugins · Shougo/unite.vim Wiki · GitHub』 https://github.com/Shougo/unite.vim/wiki/unite-plugins
" -auto-preview はそれなりに重いので慎重に.
" -no-quit -vertical g:unite_winwidth -buffer-name
" dotfileを表示するには
nnoremap su :map [unite]<CR>
nnoremap [unite] <Nop>
nmap U [unite]
nnoremap [unite]U :<C-u>Unite<Space>
nnoremap <silent> [unite]S :<C-u>Unite source<CR>
nnoremap <silent> [unite]F :<C-u>Unite file -vertical -winwidth=60 -no-quit<CR>
nnoremap [unite]IF :<C-u>Unite file -vertical -no-quit -winwidth=
nnoremap <silent> [unite]f :<C-u>Unite file<CR>

nnoremap <silent> [unite]A :<C-u>Unite buffer bookmark file file_mru<CR>
nnoremap <silent> [unite]B :<C-u>Unite bookmark file_mru<CR>
nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
nnoremap <silent> [unite]M :<C-u>Unite file_mru<CR>
nnoremap <silent> [unite]T :<C-u>Unite tab<CR>

" TODO: Unite grepでファイルを開くとnewfileとなってしまう場合が多い(というかほとんど).困る.
nnoremap <silent> [unite]G :<C-u>Unite grep -no-quit<CR>
nnoremap <silent> [unite]l :<C-u>Unite line -start-insert -no-quit -winheight=15<CR>
" TODO: -auto-preview で新たなwindowを表示するのが邪魔. 既に開いているbufferを使いたい.
nnoremap <silent> [unite]L :<C-u>Unite line -start-insert -no-quit -auto-preview -winheight=15<CR>
" nnoremap <silent> /  :<C-u>Unite -buffer-name=search line -start-insert -no-quit<CR>
nnoremap <silent> [unite]O :<C-u>Unite outline<CR>
" nnoremap <silent> [unite]H :<C-u>Unite -start-insert help<CR>
nnoremap [unite]h :<C-u>Unite history/
nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=register register<CR>
" unite rails
nnoremap [unite]RR :<C-u>Unite -vertical -winwidth=60 -no-quit rails/
nnoremap <silent>[unite]RM :<C-u>Unite -vertical -winwidth=60 -no-quit  rails/model<CR>
nnoremap <silent>[unite]RC :<C-u>Unite -vertical -winwidth=60 -no-quit  rails/controller<CR>
nnoremap <silent>[unite]Rc :<C-u>Unite -vertical -winwidth=60 -no-quit  rails/config<CR>
nnoremap <silent>[unite]RV :<C-u>Unite -vertical -winwidth=60 -no-quit  rails/view<CR>
nnoremap <silent>[unite]RH :<C-u>Unite -vertical -winwidth=60 -no-quit  rails/helper<CR>
nnoremap <silent> [unite]Q :<C-u>Unite qflist -no-quit<CR>
nnoremap <silent> [unite]WC :<C-u>UniteWithCurrentDir file file_mru -vertical -winwidth=60 -no-quit<CR>
nnoremap <silent> [unite]Wc :<C-u>UniteWithCurrentDir file file_mru<CR>
nnoremap <silent> [unite]WB :<C-u>UniteWithBufferDir file file_mru -vertical -winwidth=60 -no-quit<CR>
nnoremap <silent> [unite]Wb :<C-u>UniteWithBufferDir file file_mru<CR>
" nnoremap <silent> [unite]WB :<C-u>UniteWithBufferDir -prompt=%\  buffer file_mru bookmark file<CR>

let g:unite_cursor_line_highlight = 'TabLineSel'
" let g:unite_winwidth = 60
" let g:unite_abbr_highlight = 'TabLine'
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings() "{{{
	" CTRL-hをhで代替したい
	imap <buffer> jj <Plug>(unite_insert_leave)
	nmap <buffer> h <Plug>(unite_delete_backward_path)
	nmap <buffer> l <Plug>(unite_narrowing_path)
	" TODO: nmap l "ディレクトリ掘る" をしてみたけれど使いづらいかも...
	" <S-m>も使いたいかも.
	imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
	nmap <buffer> <C-h> :<C-u>tabprevious<CR>
	nmap <buffer> <C-l> :<C-u>tabnext<CR>
	" nmap <silent> <buffer> <expr> <C-p> unite#do_action('vsplit')
	" imap <silent> <buffer> <expr> <C-p> unite#do_action('vsplit')

	" <C-l>: manual neocomplete completion.
	" inoremap <buffer> <C-l> <C-x><C-u><C-p><Down>

	" Start insert.
	"let g:unite_enable_start_insert = 1
endfunction "}}}

" vim-rails
if neobundle#is_installed('vim-rails')
	nnoremap <leader>rc :<C-u>Rcontroller<Space>
	nnoremap <leader>rm :<C-u>Rmodel<Space>
	nnoremap <leader>rv :<C-u>Rview<Space>
endif

" neocomplete.vim
if neobundle#is_installed('neocomplete')
	let g:neocomplete#enable_at_startup = 1
	let g:neocomplete#enable_smart_case = 1
	" let g:neocomplete#enable_prefetch=0
	" let g:neocomplete#enable_camel_case_completion = 1
	" _を入力したときに、それを単語の区切りとしてあいまい検索を行うかどうか制御する。例えば p_h と入力したとき、public_html とマッチするようになる。1ならば有効になる。副作用があるので、初期値は0となっている。
	" let g:neocomplete#enable_underbar_completion = 1
	" let g:neocomplete#dictionary_filetype_lists =

	" 日本語をキャッシュしない.
	if !exists('g:neocomplete#keyword_patterns')
		let g:neocomplete#keyword_patterns = {}
	endif
	let g:neocomplete#keyword_patterns['default'] = '\h\w*'

	" let g:neocomplete_omni_functions = {
	" \ 'python' : 'pythoncomplete#Complete',
	" \ 'ruby' : 'rubycomplete#Complete',
	" \ }

	" <CR>: close popup
	inoremap <expr><CR> pumvisible() ? neocomplete#smart_close_popup() : "\<CR>"
	" <TAB>: completion.
	" inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
	" 補完を選択しポップアップを閉じる
	inoremap <expr><C-y> neocomplete#close_popup()
	" 補完をキャンセルしpopupを閉じる
	inoremap <expr><C-e> neocomplete#cancel_popup()
	" 補完をキャンセルしてから行頭まで削除する.
	" inoremap <expr><C-u> neocomplete#cancel_popup() . "\<C-u>"

	" inoremap <expr><C-g> neocomplete#undo_completion()
	" inoremap <expr><C-l> neocomplete#complete_common_string()

	" ポップアップメニューの表示
	" autocmd VimEnter,ColorScheme * :hi Pmenu ctermbg=8
	" autocmd VimEnter,ColorScheme * :hi PmenuSel ctermbg=1
	" autocmd VimEnter,ColorScheme * :hi PmenuSbar ctermbg=2

	" FileType別のOmni Completion設定
	" Vimに対して設定
	autocmd FileType c setlocal omnifunc=ccomplete#Complete
	autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
	autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags
	autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
	autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
	autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
	autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
	autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

	" Enable heavy omni completion.
	if !exists('g:neocomplete#sources#omni#input_patterns')
	  let g:neocomplete#sources#omni#input_patterns = {}
	endif
	if !exists('g:neocomplete#force_omni_input_patterns')
	  let g:neocomplete#force_omni_input_patterns = {}
	endif
	let g:neocomplete#sources#omni#input_patterns.php =
	\ '[^. \t]->\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'
	" let g:neocomplete_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
	" let g:neocomplete_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'

endif

" neosnippet
if neobundle#is_installed('neosnippet')
	let g:neosnippet#snippets_directory = $HOME.'/.vim/snippets'
	imap <S-C-k> <Plug>(neosnippet_expand_or_jump)
	smap <S-C-k> <Plug>(neosnippet_expand_or_jump)
	xmap <S-C-k> <Plug>(neosnippet_expand_target)
	" TODO: neosnippetがC-kを使ってる.
	vnoremap <C-k> 5k
	" Snippetsを編集する
	command! -nargs=* Nse NeoSnippetEdit
	if has('conceal')
		set conceallevel=2 concealcursor=i
	endif
endif

" SudoEdit.vim, sudo.vim
command! WS SudoWrite %

" vim-surround.vim
let g:surround_no_mappings = 1
" ds:  delete a surrounding.
" cs:  change a surrounding.
" ys:  add a surrounding.
" yS:  add a surrounding. 改行とインデントを含む.
" yss: ただの行囲み.
" {
	" ySS: 行囲み. 改行とインデントを含む. こんなかんじ.
	" ySs: ySSと同じ.
" }
nmap ds <Plug>Dsurround
nmap cs <Plug>Csurround
nmap ys <Plug>Ysurround
nmap yS <Plug>YSurround
nmap yss <Plug>Yssurround
" ySSと同じ.
" nmap ySs <Plug>YSsurround
nmap ySS <Plug>YSsurround
vmap S <Plug>VSurround

" let g:surround_{char2nr("p")} = "<?php \r ?>"
" let g:surround_{char2nr("[")} = "['\r']"
" let g:surround_{char2nr("a")} = "array('\r')"
" let g:surround_{char2nr("v")} = "var_dump(\r);"
" let g:surround_{char2nr("d")} = "debug(\r);"
" let g:surround_{char2nr("c")} = "<!-- \r -->"
" let g:surround_{char2nr("C")} = "/* \r */"

" vim-surround_custom_mapping.vim
" 『t9md/vim-surround_custom_mapping · GitHub』 https://github.com/t9md/vim-surround_custom_mapping
let g:surround_custom_mapping = {}
" filetypeに共通の設定
let g:surround_custom_mapping._ = {
					\ }
let g:surround_custom_mapping.ruby = {
					\ 'w':  "%w(\r)",
					\ '%':  "%(\r)",
					\ '#':  "#{\r}",
					\ 'e':  "<%= \r %>",
					\ 'p':  "<% \r %>",
					\ }

" osyo-manga/vim-textobj-multiblock
omap ab <Plug>(textobj-multiblock-a)
omap ib <Plug>(textobj-multiblock-i)
vmap ab <Plug>(textobj-multiblock-a)
vmap ib <Plug>(textobj-multiblock-i)

" NERD_commenter.vim
let g:NERDCreateDefaultMappings = 0
nmap <Leader>c <plug>NERDCommenterToggle
vmap <Leader>c <plug>NERDCommenterToggle
" コメントの間にスペースを入れる
let NERDSpaceDelims = 1

" vim-indent-guides
" default mapping for ":IndentGuidestoggle"is <Leader>ig
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
let g:indent_guides_guide_size = 1
" autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=233
" autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=235
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=gray
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=darkgray

" QuickRun.vim
let g:quickrun_no_default_key_mappings = 1
nmap <Leader>R <Plug>(quickrun)

" migemo-search.vim
if neobundle#is_installed('migemo-search.vim') && executable('cmigemo')
	cnoremap <expr><CR> migemosearch#replace_search_word()."\<CR>"
endif

" current-func-info.vim
if neobundle#is_installed('current-func-info.vim')
	" 現在のカーソル位置の関数名を表示する
	set statusline=%n\:%y%F\ %{cfi#format('%s()','')}\|%{(&fenc!=''?&fenc:&enc).'\|'.&ff.'\|'}%m%r%=<%l/%L:%p%%>
	" let &statusline = '[%{cfi#get_func_name()}()]'
endif

" ctrlp.vim
" let g:ctrlp_map = '<C-^>'

" let g:syntastic_mode_map = { 'mode': 'active',
			" \ 'active_filetypes': ['ruby', 'php'],
			" \ 'passive_filetypes': ['puppet'] }

" cake.vim
let g:cakephp_enable_fix_mode = 1
"let g:cakephp_app = ""
let g:cakephp_enable_auto_mode = 1
nnoremap <Leader>cc :<C-u>Ccontroller<Space>
nnoremap <Leader>cC :<C-u>Ccomponent<Space>
nnoremap <Leader>cm :<C-u>Cmodel<Space>
nnoremap <Leader>cV :<C-u>Cviewtab<Space>
nnoremap <Leader>cv :<C-u>Ccontrollerview<Space>
nnoremap <Leader>cov :<C-u>Cview<Space>
nnoremap <Leader>cnV :<C-u>Ccontrollerviewtab<Space>
nnoremap <Leader>ch :<C-u>Chelper<Space>
nnoremap <Leader>cth :<C-u>Ctesthelper<Space>
nnoremap <Leader>ctm :<C-u>Ctestmodel<Space>
nnoremap <Leader>ctc :<C-u>Ctestcontroller<Space>
nnoremap <Leader>ctC :<C-u>Ctestcomponent<Space>
nnoremap <Leader>cf :<C-u>Cfixture<Space>

"----------------------------------------------------
" Post
"----------------------------------------------------
" 環境依存の設定
if filereadable(expand('~/.vimrc.local'))
	source ~/.vimrc.local
endif

