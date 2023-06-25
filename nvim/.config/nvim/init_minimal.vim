"	
"	███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗██████╗  ██████╗
"	████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║██╔══██╗██╔════╝
"	██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║██████╔╝██║     
"	██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║██╔══██╗██║     
"	██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║██║  ██║╚██████╗
"	╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝
"	-- by txp                                                                 
"	-- it's time for a change	
"
"
"
"
"



set nocompatible   " Disable vi-compatibility
filetype off                   " required!


"===============================================================================
"  Load Plugins   
"===============================================================================

call plug#begin('~/.config/nvim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'rhysd/accelerated-jk'
Plug 'Lokaltog/vim-easymotion'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/tmuxline.vim'
Plug 'scrooloose/syntastic'
Plug 'Shougo/unite.vim'
Plug 'scrooloose/nerdtree'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'xolox/vim-misc'
"TODO: currently disabled in minimal
"Plug 'xolox/vim-easytags'
Plug 'flazz/vim-colorschemes'
" this bad boy needs to be compile -> see the post_update hook in .git
Plug 'Shougo/vimproc.vim', { 'build' : {     'windows' : 'tools\\update-dll-mingw',     'cygwin' : 'make -f make_cygwin.mak',     'mac' : 'make -f make_mac.mak',     'linux' : 'make',     'unix' : 'gmake',    }, }
" Plug 'Valloric/YouCompleteMe'

"Plug 'majutsushi/tagbar'
Plug 'Shougo/vimfiler.vim'

"=== vim-scripts repos ===
"Plug 'taglist.vim'

call plug#end()

""=== plugins on github ===
filetype plugin indent on    " required

"===============================================================================
"  General Settings   
"===============================================================================

"automatically reloads the vimrc
autocmd! bufwritepost .nvimrc source %

"save foldings -> but somehow this screws up the working directory, so a job
"for future alex ;-)
"au BufWinLeave * silent! mkview
"au BufWinEnter * silent! loadview

set autoread " vim updates file on change
set clipboard=unnamedplus " use the X Window clipboard
set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show Unicode glyphs
set hidden      " Enable unsaved buffers
set mouse=a
set nostartofline " prevents cursor form jumping to begin of line on bufferswitch
"set autochdir
"set listchars=tab:▸\ 

"session stuff
set ssop-=options    " do not store global and local values in a session
" ... this fixed the problem, that some of the colors were screwed up in
" ... tmux after restoring a session (ctermbg and stuff)
set ssop-=folds      " do not store folds
" left and right arrow key are going to next line on end of line
" -> I'm using this in my inside functions
set whichwrap+=<,>,[,]


"
"===============================================================================
"  Indentation                                                            
"===============================================================================

set tabstop=4 shiftwidth=4 noexpandtab
" Filetyp specific 
filetype plugin indent on     " required!
if has("autocmd")
    filetype on
    autocmd FileType python setlocal ts=4 sts=4 sw=4  smartindent smarttab expandtab 
endif


 
vnoremap < <gv
vnoremap > >gv
set number "set line numbers
set backspace=indent,eol,start " Backspace behaves as expected
"set tw=80 " set max linewidth to 80 char 
           



"  Backup and Swapfile
"set undodir=~/.vim/tmp/undo//
"set backupdir=~/.vim/tmp/backup//
"set directory=~/.vim/tmp/directory//
"set backup
set noswapfile
"========================================================
"  Syntax hightlighting and Colors schemes 
"=======================================================

" Enable syntax highlighting
if has("syntax")
  syntax on
endif

" If not in tty set 256 color support - in tty there is no support for 
" 256 colors and the whole thing is flashing all the time
if &term!="linux"
	set t_Co=256
endif
"color molokai
color my_theme2
"color 256-jungle 
" 16 is black -> RGB 0 0 0
" see http://vim.wikia.com/wiki/Xterm256_color_names_for_console_Vim
highlight SignColumn ctermbg=16
highlight LineNr ctermfg=darkgrey ctermbg=none
highlight Normal ctermbg=none
"set background=dark
" I like the cursorlinenr hightlighting - the cursorline highlighting itself
" is to black, so you can't really see it...
set cursorline


" search settings
set ignorecase
set hlsearch
hi Search cterm=NONE ctermfg=black ctermbg=Green
nnoremap n nzzzv
nnoremap N Nzzzv




"========================================================
"   Mappings 
"=======================================================

" Mode switching
let myMode = 2

" Mode toggle func
function! ToggleMode()
   :imap öa ()<Left>
   :imap äa []<Left>

   :imap ös ""<Left>
   :imap äs ''<Left>

   :imap öd <><Left>
   :imap äd {%  %}<Left><Left><Left>

   :imap öf {}<Left>
   :imap öff {{  }}<Left><Left><Left>
   :imap äf {}<Left><CR><CR><Up>

   :imap ö<space> <Esc>wa
   :imap ä<space> <Esc>ea

   if g:myMode == 1
	   let g:myMode=2
	   :iunmap öa
	   :iunmap ös
	   " check it out: somehow iunmap doesn't work on mappings which contain a d
	   :imap öd öd
	   :iunmap öf
	   :iunmap öff
	   :iunmap äa
	   :iunmap äs
	   " see above - same behavior
	   :imap äd äd
	   :iunmap äf
	   :iunmap ö<space>
	   :iunmap ä<space>
	   echo "Now in german text mode -> most äöü shortcuts inactive (except: quit and save)"
   else
	   let g:myMode=1
	   echo "Now in coding mode -> äöü shortcuts active"
   endif
endfunction



:silent :call ToggleMode()

nmap <silent> <F2> :call ToggleMode()<CR>

" MY FUNCTIONS
" easy ci yi vi and di -> searches the next of the flowing characters:
" ),},>,],",' and starts the respective inside operation... 
" gets triggerd by pressing cii yii dii and vii
"
" mode 1: change inside
" mode 2: yank inside
" mode 3: visual inside
" mode 4: delete inside/cut
function! MyInside(operation)
	" set marker to jump back if no inside char is found
	execute "normal 'p"

	while (line(".") != line("$")) || (col(".")<col("$")-1) 
		" go to right character by character and store the hex val of the
		" current character in currentChar
		execute "normal! \<Right>"
		redir => currentChar
		silent normal! g8
		redir END

		" the next 3 lines are pretty nasty 
		" get a clean hex format of currentChar (forgot why..)
		let ccHex = currentChar[1:] 
		" Hex -> Dec
		let ccDec = str2nr(ccHex,16)
		" Dec -> Char
		let cc = nr2char(ccDec)

		" check if cc is one of my trigger chars
		if ( cc == "}" || cc == ")" || cc == "<" || cc == ">" || cc == "]" || cc == "\"" || cc == "'" )
			" build command...
			let command = "normal! " . a:operation . cc 
			" ... and execute it
			execute command

			" in case of change operator - go into insert mode 
			" (execute always returns normal mode)
			if ( a:operation == "ci" || a:operation == "ca" )
				startinsert
				normal! l
			endif

			" job is done -  quit while loop 
			break
		endif
	endwhile

	" cleanup	
	" TODO: jumplist
	"execute "normal `p"

	" if no hit was found (if we are at the very end of the file) - jump back to mark
	"if (line(".") == line("$")) && (col(".") >= col("$")-1)
		"
	"endif

endfunction


" paste content of "0 register (copy register) with capslock + p
nmap þ "0p


" bind MyInside to the respective keymappings
nmap cii :call MyInside("ci")<CR>
nmap yii :call MyInside("yi")<CR>
nmap vii :call MyInside("vi")<CR>
nmap dii :call MyInside("di")<CR>
nmap caa :call MyInside("ca")<CR>
nmap yaa :call MyInside("ya")<CR>
nmap vaa :call MyInside("va")<CR>
nmap daa :call MyInside("da")<CR>

"TODO: fix it
"autocmd BufWriteCmd *.html,*.css,*.haml :call Refresh_browser()
function! Refresh_browser()
	echo "frank is the man"
	if &modified
		write
		silent !xdotool search "firefox" key 'ctrl+r'
	endif
endfunction

" map leader to , (default was \)
:let mapleader = ","
:let maplocalleader = ","
" easy split navigation
:update
:nnoremap <C-h> <C-w>h
let g:C_Ctrl_j='off' " avoid some conflicts
:nnoremap <C-j> <C-w>j
:nnoremap <C-k> <C-w>k
:nnoremap <C-l> <C-w>l


" Jump to definition
" TODO: Remap this bad boy
"noremap t <C-c>g

" noremap df caw
"noremap DF caW

"change word under the cursor with content of the buffer
nmap <silent> cp "_cw<C-R>"<Esc>
" cange inside special mappings

"TODO - do I use this really???
nmap ciöa ci( 
nmap ciös ci" 
nmap ciöd ci' 
nmap ciöf ci{ 
nmap ciäa ci< 
nmap ciäs ci[ 
nmap ciäd dt%dT%i<space><space><esc><left>i 

" * is just terrible to reach
nmap # *

nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)
"Insert mode mappings

" insert -> normal mappings
:imap kj <ESC>
:imap jk <ESC>



" hjkl movement in insert mode using third level -> see .Xmodmap
"inoremap ħ <C-o>h
"inoremap ŋ <C-o>j
"inoremap ĸ <C-o>k
"inoremap ł <C-o>l

" ----  Maximise and Equalise Split Windows
" horizontal 
noremap öM <C-w>_
" vertical
noremap äM <C-w>\|
" horzontal and vertical
noremap ÄM <C-w>_<C-w>\|
noremap ÖM <C-w>_<C-w>\|
" equalise
noremap öm <C-w>=
noremap äm <C-w>=

"Visual mode mappings
:vmap <space><space> <ESC>
":vmap jk <ESC>


"nmap <S> O<Esc>j
"nmap <CR> o<Esc>k
"""" Buffer Stuff

"cycle through buffers
"third level of j 
noremap ც :bp<CR>  
inoremap ც <ESC>:bp<CR>  
"third level of k
noremap ĸ :bn<CR> 
inoremap ĸ <ESC>:bn<CR> 

"cycle through windows - next window
"third level ol l
noremap ł <C-w>w
inoremap ł <C-w>w
vnoremap ł <C-C>w
"cycle through windows - previous window
"" third level of h
noremap ħ <C-w>W
inoremap ħ <C-w>W
vnoremap ħ <C-w>W

"  quit buffer
noremap öb   :bd<CR>
noremap öB   :bd!<CR>
noremap ÖB   :bd!<CR>

"""" Tab Stuff
"" well turns out I'm not that big of a tab guy... so maybe in the the future
" next tab - third level of l
"noremap ł :tabn<CR>
"inoremap ł <C-O>:tabn<CR>
"vnoremap ł <C-C>:tabn<CR>
"" previos tab - third level of h
"noremap ħ :tabp<CR>
"inoremap ħ <C-ö> <C-O>:tabp<CR>
"vnoremap ħ <C-C>:tabp<CR>
"" new tab
"noremap öt :tabnew<CR>
"" quit tab
"noremap öT :tabclose<CR>
"noremap ÖT :tabclose!<CR>




"""" Session Stuff
noremap üw :exec "mks!" . v:this_session<CR>:echo "Session" v:this_session"saved" <CR>

"""" Marks  Stuff
noremap m `
noremap ' m
"""" Mark remapping -> ' and ` are terrible to type on geman keyboard
"noremap - '
"noremap _ `

""""  SAVE FILES  
"easier keybinding for :w (save active buffer)
noremap  <silent> öw             :update<CR>
vnoremap <silent> öw        <C-C>:update<CR>
inoremap <silent> öw        <C-O>:update<CR>

"easier keybinding for :wa (save all buffers)
noremap  <silent> äw             :wa<CR>
vnoremap <silent> äw        <C-C>:wa<CR>
inoremap <silent> äw        <C-O>:wa<CR>

"easier keybinding for :w! (force save active buffers)
noremap  <silent> öW             :w!<CR>
vnoremap <silent> öW        <C-C>:w!<CR>
inoremap <silent> öW        <C-O>:w!<CR>

"easier keybinding for :wa (force save all buffers)
noremap  <silent> äW             :wa!<CR>
vnoremap <silent> äW        <C-C>:wa!<CR>
inoremap <silent> äW        <C-O>:wa!CR>


""""  QUIT FILES
" keybinding for :update|:quit (save and quit active buffer)
noremap  <silent> öq             :update<CR>:quit<CR>
vnoremap <silent> öq        <C-C>:update<CR>:quit<CR>
inoremap <silent> öq        <C-O>:update<CR><C-O>:quit<CR>

" keybinding for :quit! (quit without saving active buffer)
noremap  <silent> öQ             :quit!<CR>
vnoremap <silent> öQ        <C-C>:quit!<CR>
inoremap <silent> öQ        <C-O>:quit!<CR>

" keybinding for :update!|:quit (force save and quit active buffer)
noremap  <silent> ÖQ             :update!<CR>:quit<CR>
vnoremap <silent> ÖQ        <C-C>:update!<CR>:quit<CR>
inoremap <silent> ÖQ        <C-O>:update!<CR><C-O>:quit<CR>

"" keybinding for :update|:quit (save and quit all buffers)
noremap  <silent> äq             :xa<CR>
vnoremap <silent> äq        <C-C>:xa<CR>
inoremap <silent> äq        <C-O>:xa<CR>

" keybinding for :quit! (quit without saving all buffers)
noremap  <silent> äQ             :quitall!<CR>
vnoremap <silent> äQ        <C-C>:quitall!<CR>
noremap  <silent> äQ        <C-O>:quitall!<CR>







"========================================================
"  Plugins Settings, Configuration, Keybindings 
"=======================================================

"------------ Pymode  --------------------------
"let g:pymode = 1

"------------ Easytag  --------------------------
:let g:easytags_file = '~/.nvim/tags'

"------------ UNITE  --------------------------

" ---  Some Variables
"let g:unite_source_rec_min_cache_files = 10
"let g:unite_source_rec_max_cache_files = 1000000
if executable('ag')
	let g:unite_source_rec_async_command= 'ag --nocolor --nogroup -g ""'
endif


" open unite in veritcal split
let g:unite_enable_split_vertically = 1

" ---- Functions and Autocommands
call unite#custom#source('file_mru,file_rec,file_rec/async,grepocate', 'max_candidates', 0)

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#custom#source( 'buffer', 'converters', ['converter_file_directory'])
" TODO: check it out what exactly..
call unite#filters#sorter_default#use(['sorter_rank'])


"TODO to checkout
"nmap <buffer> <C-j>     <Plug>(unite_toggle_auto_preview)




autocmd FileType unite call s:unite_settings()

function! s:unite_settings()
  nmap <silent><buffer><expr> _ unite#do_action('split')
  nmap <silent><buffer><expr> - unite#do_action('vsplit')
endfunction


"---- Mappings
" rebuild the index - for example if new files and folders exist..
nnoremap <F6> :execute "normal \<Plug>(unite_redraw)" <cr>
nnoremap <leader>a :Unite -start-insert file_rec/async<cr>
nnoremap <leader>f :Unite buffer -quick-match <cr>
nnoremap <leader>g :Unite grep:. -no-quit<CR>
"----------------------------------------------------------------------------


"=============== YouCompleteMe Settings ========================
"let g:ycm_filetype_specific_completion_to_disable = {'c':'test'}
"let g:EclimCompletionMethod ='omnifunc'
"=============== Syntastic Setting ========================
"enable signs on the left side    
let g:syntastic_enable_signs=1

"let g:syntastic_mode_map = { 'mode': 'active',
"		       \ 'active_filetypes': ['ruby', 'php', 'css'],
"		       \ 'passive_filetypes': ['puppet'] }


let g:syntastic_check_on_open=1

let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
"let g:syntastic_mql5_checkers=['mql5.vim']
"let g:syntastic_mql5_compiler_path = '/home/alex/.wine/dosdevices/c:/Program Files/MetaTrader5-ActivTrades'
"let g:syntastic_mql5_compiler_executable = 'wine mql564.exe'
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_html_checkers = ['jshint']
let g:syntastic_python_flake8_args='--ignore=E501,E265,E127,E128'
" E501: linesize
" E265: The one about comments starting '# '
" E127,E128: Errors about inline alignment
" W391: blank line at EOF. Of course you want a blank line there.



"========================================================
"    Plugins Mappings
"=======================================================

"----------- TagList Mappings ----------------
nmap <leader>t :TlistToggle <CR>
let Tlist_Use_Right_Window = 1
let Tlist_GainFocus_On_ToggleOpen = 1
"let g:tagbar_autofocus = 1

"----------- ultiSnips ----------------
let g:UltiSnipsExpandTrigger="<leader>s"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
" don't know why these dont work but I think I like tab even more...
"TODO: check out what is the problem...
"let g:UltiSnipsJumpForwardTrigger="<c-n>"
"let g:UltiSnipsJumpBackwardTrigger="<c-N>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

"------------  Nerdtree  --------------------------
" third level of n
nnoremap ” :NERDTreeToggle <cr>
let NERDTreeMapOpenSplit='_'
let NERDTreeMapOpenVSplit='-'

"----------------- Easymotion Mappings ------------------
let g:EasyMotion_leader_key = '<Space>'

" modified easymotion keys, in order to fit better to the german keyboard
" layout... e.g. no ; which uses shift on german keyboards.. Default was: 'asdghklqwertyuiopzxcvbnmfj;'
let g:EasyMotion_keys = 'asdghklöqwertzuiopzyxcvbnmfj'
map <space>J <Plug>(easymotion-eol-j)
map <space>K <Plug>(easymotion-eol-k)

map <space>l $
map <space>h 0 
"----------------- Airline Mappings ------------------
let g:airline_powerline_fonts = 1
"let g:airline#extensions#bufferline#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'badwolf'
"let g:bufferline_echo = 0
"  autocmd VimEnter *
"    \ let &statusline='%{bufferline#refresh_status()}'
"      \ .bufferline#get_status_string()
"========================================================
"  Code Completion 
"=======================================================

"--- omnicomplete ---
set omnifunc=syntaxcomplete#Complete

"autocmd FileType python set omnifunc=pythoncomplete#Complete
"autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

"omnicompletion java (scheint sich mit eclim zu vertragen... weiter beobachten)
"autocmd FileType java set tags=~/Desktop/java.tags 

"if has("autocmd")
"	  autocmd Filetype java setlocal omnifunc=javacomplete#Complete
"	    autocmd Filetype java setlocal completefunc=javacomplete#CompleteParamsInfo
 "   endif
