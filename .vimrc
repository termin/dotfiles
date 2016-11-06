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
" ss で:registersとか:marksとか色々表示する系のkey mapを一覧する.
" <Leader>he で.vimrcをすぐに表示する. ToDoとかささっと見てささっと解決したい.
" Uniteを積極的に使いたい. qflist(Quickfix), file etc...
"
" Mac標準のvimはhas('mac'), has('macunix')が0だが自前でbuildすれば1.
"----------------------------------------------------
" TODO:
"----------------------------------------------------
" 『Vim-users.jp - Vim Hacks Project』 http://vim-users.jp/vim-hacks-project/
" :e dir1/dir2/txt などとしたいときに, dir1を選択した後に直下のファイルを一覧させたいが良い方法はあるか. 今は<Space><BS><Tab>してる.
" helpを:splitじゃなくて:onlyで開きたい.
" surround.vimのキーバインドをまともにしたい気がする. 『Vimの極め方』 http://whileimautomaton.net/2008/08/vimworkshop3-kana-presentation
" Quickfix周り

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
colorscheme default
set background=light
set number
" set showmode
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
set breakindent

"----------------------------------------------------
" べんり
"----------------------------------------------------
filetype plugin indent on " ファイルタイプ判定をon
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
  autocmd FileType neosnippet setlocal tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab
  autocmd FileType json setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
augroup END
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
" TODO:
" Mac Terminal.appの場合
" <修飾キー-Tab>は使えなかった. 修飾キーはM, Cが使えた. 但しMは, Terminal.appでoptionをMetaとして使うにチェックする.
" <Right>, <Left> 等はどうやっても使えない感じ.
" <M-x>は, <Esc>x で代用. <Esc><C-x>とか.
" helpでは"<D-"でCommand Keyが使えるとしているけれど, 設定しても使えなかった.

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
nnoremap <silent> <Esc><S-h> :<C-u>execute 'tabmove' tabpagenr() - 2<CR>
nnoremap <silent> <Esc><S-l> :<C-u>execute 'tabmove' tabpagenr() + 1<CR>
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

" nnoremap <silent> <Esc><Esc> :<C-u>nohlsearch<CR>
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
" dein.vim
if &compatible
  set nocompatible " 『vimrcアンチパターン - rbtnn雑記』 http://rbtnn.hateblo.jp/entry/2014/11/30/174749
endif

if !s:enable_plugins
filetype plugin indent on
syntax on
else
set runtimepath^=~/.vim/bundle/repos/github.com/Shougo/dein.vim
let s:dein_dir = expand('~/.vim/bundle')
if dein#load_state(s:dein_dir)
call dein#begin(s:dein_dir)
call dein#add('Shougo/dein.vim')
call dein#add('Shougo/vimproc', {'build': 'make'})
call dein#add('editorconfig/editorconfig-vim')
call dein#add('tpope/vim-surround')
call dein#add('t9md/vim-surround_custom_mapping')
call dein#add('Shougo/neocomplete', {
      \ 'on_event': 'InsertEnter',
      \ 'lazy': 1
      \ })
call dein#add('Shougo/neosnippet', {'depends': 'vimproc'})
call dein#add('Shougo/neosnippet-snippets', {'depends': 'neosnippet'})
call dein#add('ryuzee/neosnippet_chef_recipe_snippet', {
      \ 'depends': 'neosnippet',
      \ 'lazy': 1,
      \ 'on_ft': 'ruby.chef'
      \ }) " set filetype=ruby.chef
call dein#add('Shougo/unite.vim', {'depends': 'vimproc'})
call dein#add('Shougo/unite-outline', {'depends': ['unite.vim', 'vimproc']})
call dein#add('tsukkee/unite-help', {'depends': ['unite.vim', 'vimproc']})
call dein#add('thinca/vim-quickrun')
call dein#add('soh335/unite-qflist', {'depends': 'unite.vim'})
" call dein#add('sgur/unite-qf', {'depends': 'unite.vim'})
call dein#add('tacroe/unite-mark', {'depends': 'unite.vim'})
call dein#add('tyru/current-func-info.vim')
call dein#add('scrooloose/syntastic')
call dein#add('vim-jp/vimdoc-ja')
call dein#add('nathanaelkane/vim-indent-guides')
call dein#add('kana/vim-textobj-user')
call dein#add('osyo-manga/vim-textobj-multiblock', {'depends': 'vim-textobj-user'})
call dein#add('kana/vim-repeat')
call dein#add('tyru/caw.vim', {'depends': 'vim-repeat'})
" call dein#add('scrooloose/nerdcommenter')
" call dein#add('chrisbra/SudoEdit.vim')
call dein#add('renamer.vim', {'on_cmd': 'Renamer', 'lazy': 1})
call dein#add('ctrlpvim/ctrlp.vim')
" call dein#add('Shougo/vimshell', {'depends': 'vimproc'})
" call dein#add('rhysd/migemo-search.vim')

" language {{{
" call dein#add('basyura/unite-rails', {'depends': 'unite.vim'})
" call dein#add('vim-ruby/vim-ruby')
call dein#add('violetyk/cake.vim', {'depends': 'vimproc'})
call dein#add('beyondwords/vim-twig', {'on_ft': 'twig', 'lazy': 1})
call dein#add('heavenshell/unite-sf2', {'depends': 'unite.vim'})
call dein#add('honza/vim-snippets', {'depends': 'neosnippet'})
" call dein#add('qbbr/vim-symfony')
" call dein#add('docteurklein/vim-symfony')
" call dein#add('oppara/vim-unite-cake', {'depends': 'unite.vim'})
" call dein#add('fatih/vim-go')
" call dein#add('solarnz/thrift.vim') " Syntax highlighting for thrift definition files.
" call dein#add('tpope/vim-rails')
" call dein#add('tpope/vim-endwise')
" call dein#add('vim-scripts/ruby-matchit')
" }}}

" call dein#add('Shougo/vimfiler')
" call dein#add('thinca/vim-ref')
" call dein#add('tpope/vim-fugitive')
" call dein#add('grep.vim')
" call dein#add('kana/vim-grex')
" call dein#add('kana/vim-operator-replace')
" call dein#add('kana/vim-operator-user')
" call dein#add('kana/vim-smartword')
" call dein#add('mattn/benchvimrc-vim')
" call dein#add('ujihisa/unite-colorscheme', {'depends': 'unite.vim'})

call dein#end()
call dein#save_state()
endif " /load_state()

filetype plugin indent on
if dein#check_install()
  call dein#install()
endif
syntax on " pluginロード後に設定する cf. 『vimrcアンチパターン - rbtnn雑記』 http://rbtnn.hateblo.jp/entry/2014/11/30/174749

" Unite.vim
" 『unite plugins · Shougo/unite.vim Wiki · GitHub』 https://github.com/Shougo/unite.vim/wiki/unite-plugins
" -auto-preview はそれなりに重いので慎重に.
" -no-quit -vertical g:unite_winwidth -buffer-name
if dein#tap('unite.vim')
  nnoremap su :map [unite]<CR>
  nnoremap [unite] <Nop>
  nmap U [unite]
  nnoremap [unite]U :<C-u>Unite<Space>
  " nnoremap <silent> [unite]s :<C-u>Unite source<CR>
  nnoremap <silent> [unite]F :<C-u>Unite file -vertical -winwidth=60 -no-quit<CR>
  nnoremap [unite]IF :<C-u>Unite file -vertical -no-quit -winwidth=
  nnoremap <silent> [unite]f :<C-u>Unite file<CR>

  nnoremap <silent> [unite]A :<C-u>Unite buffer bookmark file file_mru<CR>
  nnoremap <silent> [unite]B :<C-u>Unite bookmark file_mru<CR>
  nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
  nnoremap <silent> [unite]M :<C-u>Unite file_mru<CR>
  nnoremap <silent> [unite]T :<C-u>Unite tab<CR>

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
  " unite sf2
  nnoremap [unite]s :<C-u>Unite sf2/
  nnoremap <silent> [unite]S :<C-u>Unite sf2/bundles -vertical -winwidth=60 -no-quit<CR>

  let g:unite_cursor_line_highlight = 'TabLineSel'
  " let g:unite_winwidth = 60
  " let g:unite_abbr_highlight = 'TabLine'
  augroup Unite
    autocmd!
    autocmd FileType unite call s:unite_my_settings()
  augroup END

  call unite#custom#source('file', 'matchers', 'matcher_default') " dotfileを表示する

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
endif

" neocomplete.vim
if dein#tap('neocomplete')
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
  " augroup PopupMenu
    " autocmd!
    " autocmd VimEnter,ColorScheme * :hi Pmenu ctermbg=8
    " autocmd VimEnter,ColorScheme * :hi PmenuSel ctermbg=1
    " autocmd VimEnter,ColorScheme * :hi PmenuSbar ctermbg=2
  " augroup END

  " FileType別のOmni Completion設定
  " Vimに対して設定
  augroup OmniCompletion
    autocmd!
    autocmd FileType c setlocal omnifunc=ccomplete#Complete
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
  augroup END

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

let s:dein_bundle_dir = $HOME.'/.vim/bundle/'
if dein#tap('neosnippet')
  imap <C-l> <Plug>(neosnippet_expand_or_jump)
  smap <C-l> <Plug>(neosnippet_expand_or_jump)
  xmap <C-l> <Plug>(neosnippet_expand_target)
  " TODO: neosnippetがC-kを使ってる.
  " vnoremap <C-k> 5k
  command! -nargs=* Nse NeoSnippetEdit -split -vertical
  if has('conceal')
    set conceallevel=2 concealcursor=i
  endif
  let g:neosnippet#disable_runtime_snippets = {'_' : 1}
  let g:neosnippet#snippets_directory = []
  if dein#tap("neosnippet_chef_recipe_snippet")
    let g:neosnippet#snippets_directory += [s:dein_bundle_dir.'repos/github.com/ryuzee/neosnippet_chef_recipe_snippet/neosnippets']
  endif
  if dein#tap("neosnippet-snippets")
    let g:neosnippet#snippets_directory += [s:dein_bundle_dir.'repos/github.com/Shougo/neosnippet-snippets/neosnippets']
  endif
  if dein#tap("vim-snippets")
    let g:neosnippet#snippets_directory += [s:dein_bundle_dir.'repos/github.com/honza/vim-snippets/snippets']
  endif
  let g:neosnippet#snippets_directory += [$HOME.'/.vim/snippets']
endif

if dein#tap('SudoEdit.vim')
  command! WS SudoWrite %
endif

if dein#tap('vim-surround')
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
if dein#tap('vim-surround_custom_mapping')
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

if dein#tap('vim-textobj-multiblock')
  omap ab <Plug>(textobj-multiblock-a)
  omap ib <Plug>(textobj-multiblock-i)
  vmap ab <Plug>(textobj-multiblock-a)
  vmap ib <Plug>(textobj-multiblock-i)
endif

" if dein#tap('tyru/caw.vim')
"   nmap <Leader>C <Plug>(caw:prefix)
"   xmap <Leader>C <Plug>(caw:prefix)
" endif

if dein#tap('nerdcommenter')
  let g:NERDCreateDefaultMappings = 0
  nmap <Leader>C <plug>NERDCommenterToggle
  vmap <Leader>C <plug>NERDCommenterToggle
  " コメントの間にスペースを入れる
  let NERDSpaceDelims = 1
endif

if dein#tap('vim-indent-guides')
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

if dein#tap('vim-quickrun')
  let g:quickrun_no_default_key_mappings = 1
  nmap <Leader>R <Plug>(quickrun)
endif

if dein#tap('migemo-search.vim') && executable('cmigemo')
  cnoremap <expr><CR> migemosearch#replace_search_word()."\<CR>"
endif

if dein#tap('current-func-info.vim')
  " 現在のカーソル位置の関数名を表示する
  set statusline=%n\:%y%F\ %{cfi#format('%s()','')}\|%{(&fenc!=''?&fenc:&enc).'\|'.&ff.'\|'}%m%r%=<%l/%L:%p%%>
  " let &statusline = '[%{cfi#get_func_name()}()]'
endif

if dein#tap('ctrlp.vim')
  let g:ctrlp_map = '<C-^>'
endif

if dein#tap('syntastic')
  let g:syntastic_mode_map = {
        \ "mode": "active",
        \ "passive_filetypes": ["go"] }
  let g:syntastic_go_checkers = ['go', 'golint']
  nnoremap <Leader>S :<C-u>SyntasticCheck<CR>
endif

if dein#tap('vim-rails')
  nnoremap <leader>rc :<C-u>Rcontroller<Space>
  nnoremap <leader>rm :<C-u>Rmodel<Space>
  nnoremap <leader>rv :<C-u>Rview<Space>
endif

if dein#tap('cake.vim')
  let g:cakephp_enable_fix_mode = 1
  "let g:cakephp_app = ""
  let g:cakephp_enable_auto_mode = 1
  nnoremap <Leader>cc :<C-u>Ccontroller<Space>
  nnoremap <Leader>cC :<C-u>Ccomponent<Space>
  nnoremap <Leader>cm :<C-u>Cmodel<Space>
  nnoremap <Leader>cv :<C-u>Ccontrollerview<Space>
  nnoremap <Leader>cV :<C-u>Cview<Space>
  nnoremap <Leader>ch :<C-u>Chelper<Space>
  nnoremap <Leader>cf :<C-u>Cfixture<Space>
endif

if dein#tap('vim-symfony')
  let g:symfony_app_console_path= "bin/console"
endif

if dein#tap('vim-smartword')
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
