" ESLint results buffer syntax file
" Language: ESLint
" Creator: Griffin Moe <me@griffinmoe.com>
" Version: 1.0

if exists("b:current_syntax")
  finish
endif

syn clear

syn keyword eslError error
syn match eslError "\d\+ errors\?"

syn keyword eslWarning warning
syn match eslWarning "\d\+ warnings\?"

syn match eslRuleName "\b[A-Za-z/\-1-9]\+$"

syn match eslLineNumber "\(\d\+\):\(\d\+\)"

syn region eslFileName start="^/" end="\.jsx\?$" keepend extend

syn region eslCode start=+`+ end=+`+ keepend

let b:current_syntax = "eslint"

hi link eslLineNumber PreProc
hi link eslFileName Comment
hi link eslError Label
hi link eslWarning Type
hi link eslRuleName Underlined
hi link eslCode String
