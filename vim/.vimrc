scriptencoding utf-8
set nocompatible
filetype off

set number " 行番号の表示
set norelativenumber " 相対的な行番号は使わない
set title " 編集中のファイル名を表示

set hlsearch " 検索ハイライト
hi Search ctermbg=Cyan
set ignorecase
set smartcase
set wrapscan " 最終行まで検索した後、先頭行に戻る
set incsearch " マッチしたパターンすべてをハイライト

set tabstop=4
set expandtab " tab -> space
set softtabstop=4 " tabをspaceいくつにするか
set shiftwidth=4
set list
set listchars=tab:\>\

set autoindent " 自動インデント

set lazyredraw " なんか早くなる

set showmatch " 対応する括弧のハイライト
set ruler " カーソル位置の表示
set wrap " 長い行は折り返す
set cursorline " 現在の行の強調設定
set cursorcolumn " 現在の列強調設定

set wildmenu " コマンドラインモードの補完
set cmdheight=2
set showcmd " 入力中のコマンドを表示
set shellcmdflag=-ic " コマンドラインでもaliasが使えるように

set formatoptions+=mM " 日本語の整形

set showtabline=2 " タブバーを常に表示

au BufNewFile,bufRead *.dig setf yaml " digdagファイルの設定
augroup MyPython
  autocmd!
  autocmd BufNewFile,BufReadPost *.py setf python
  autocmd BufNewFile,BufReadPost *.py inoreemap <S-Tab> <C-V><Tab>
augroup END
set encoding=utf-8 " デフォルトの文字コード
set fileencoding=utf-8
set nobackup " バックアップファイル作成しない
set noswapfile " スワップファイルを作成しない
set noundofile
set confirm " 未保存ファイルの確認
set scrolloff=5 " スクロールに余裕をもたせる
set visualbell " ビープ音消す
set vb t_vb=
set foldmethod=indent " インデントで折りたたみ
set foldlevel=1 " 折り畳み量を調節
set foldcolumn=0 " 折り畳み領域を表示
set colorcolumn=80 " 1行80文字の目安
set ambiwidth=double " 全角文字をいい感じに

set completeopt=preview
set clipboard=unnamed
function! s:Clip(data)
  let @*=a:data
  echo "clipped: " . a:data
endfunction
command! -nargs=0 ClipPath call s:Clip(expand'%:p'))
command! -nargs=0 ClipFile call s:Clip(expand'%:t'))
command! -nargs=0 ClipDir call s:Clip(expand'%p:h'))

"set ttimeoutlen=10 " キーコードシーケンスが終了するまでの時間を短く

set mouse=a " マウスでの操作を可能に

" カウントアップ
nnoremap + <C-a>
" カウントダウン
nnoremap - <C-x>

" タブ移動
"" SID
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction
"" tablineの設定
function! s:my_tabline() "{{{
  let s = ""
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1] " first window, first appears
    let no = i " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFile# '
  endfor
  let s.= '%#TabLineFile#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!' . s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 " 常にタブラインを表示
"" The prefix key
nnoremap [Tag] <Nop>
nmap t [Tab]
"" tab jump
"" t2で左から２つ目のタブへジャンプ
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n ':<C-u>tabnext'.n.'<CR>'
endfor
"" tab移動
""" tc 新しいタブを一番右に作成
map <silent> [Tab]t :tablast <bar> tabnew<CR>
""" tx タブを閉じる
map <silent> [Tag]x :tabclose<CR>
""" tn 次のタブへ
map <silent> [Tab]n :tabnext<CR>
""" tp 前のタブへ
map <silent> [Tab]p :tabprevious<CR>

:let g:latex_to_unicode_auto = 1

" plugin
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'JuliaEditorSupport/julia-vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

call vundle#end()
filetype plugin indent on

syntax on " シンタックス設定の有効化
syntax enable " 構文ハイライトを有効に
syntax sync minlines=200
colorscheme molokai
set t_Co=256 " molokaiにカラーを設定
set background=dark " 背景色を黒に設定

" vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline_theme='fruit_punch' "落ち着いた色調が好き
"let g:airline_powerline_fonts = 1 "これフォントが合わない
