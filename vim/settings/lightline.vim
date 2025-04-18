let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly', 'filename', 'modified','epoch_utc' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'MyFugitive',
      \   'readonly': 'MyReadonly',
      \   'filename': 'MyFilename',
      \   'epoch_utc': 'EpochToUTCLightline',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '⮁', 'right': '⮃' }
      \ }

function! MyReadonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return "⭤ "
  else
    return ""
  endif
endfunction

function! MyFugitive()
  if exists("*FugitiveHead")
    let _ = FugitiveHead()
    return strlen(_) ? '⭠ '._ : ''
  endif
  return ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
       \ ('' != expand('%') ? expand('%') : '[NoName]')
endfunction

function! EpochToUTCLightline()
    let l:epoch = expand('<cword>')
    if l:epoch !~ '^\d\+$'
        return ''
    endif
    let l:utc_time = system('python3 -c "from datetime import datetime; import sys; print(datetime.utcfromtimestamp(' . l:epoch . ').strftime(''%Y-%m-%d %H:%M:%S UTC''))"')
    let l:utc_time = trim(l:utc_time)
    return l:utc_time
  endfunction

" 1742576400


" Use status bar even with single buffer
set laststatus=3
set noshowmode

