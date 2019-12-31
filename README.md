# vim-eslint-syntax

This is a Vim syntax-highlighter for [ESLint][] logging output, definitely a
weird niche right?

I'm not a huge fan of the asychronous linters, instead I rely on [git hooks][]
and get in-editor feedback with a key binding that opens a split with ESLint
output for the current buffer. If that sounds like an appealing alternative
then you're the target audience for this plugin!

If you're looking for a plugin that gives you line-by-line linter output you
will probably prefer something like [ale][] or [Syntastic][]. This also
requires a bit of familiarity with Vim and manual configuration to get working.

## Usage

My `.vimrc` has a key binding to pipe the output of [ESLint][] into a buffer
and open that buffer into a split. If you want a similar setup the following
is the bare minimum to support it, bound to `<Leader>e`:

```vim
noremap <Leader>e :call ESLintFileExternal()<cr>

function! ESLintFileExternal()
  if (&ft=='javascript' || &ft=='javascript.jsx' || &ft=='javascriptreact')
    let linterBuffType = 'eslint'

    " Recursively find local eslint, otherwise use global binary
    let localESLint = findfile('node_modules/.bin/eslint', '.;')
    if (!empty(localESLint))
      let linter = system(localESLint . " " . bufname("%") . " 2>&1")
    else
      let linter = system("eslint " . bufname("%") . " 2>&1")
    endif
  elseif (&ft=='myfile')
    " Add other linters! Maybe write highlighters for them?
  endif
  if (exists('linter'))
    split __Linter_Results__
    normal! ggdG
    setlocal buftype=nofile
    setlocal bufhidden=delete
    let &filetype = linterBuffType
    call append(0, split(linter, '\v\n'))
  else
    echo "File type not supported by available linters"
  endif
endfunction
```

If you want more hints on how to integrate other linters or how this setup
works, check out [my config][]. Note that this plugin does not automically set
the file type of the buffer so it can play nicely with other future linter
highlighters. You'll have to set it manually similar to the snippet above (`let
&filetype = linterBuffType`) or set it with an [autocommand][] like below:

```vim
au! BufRead,BufNewFile __Linter_Results__ setfiletype eslint
```

If you go with this option, you might want to change the name of the split
to reflect the linter being used.

[ESLint]: https://eslint.org
[ale]: https://github.com/dense-analysis/ale
[Syntastic]: https://github.com/vim-syntastic/syntastic
[git hooks]: https://githooks.com/
[my config]: https://github.com/gmoe/dotfiles/blob/master/.vimrc
[autocommand]: https://learnvimscriptthehardway.stevelosh.com/chapters/12.html
