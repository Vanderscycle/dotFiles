* Org Mode
** movement

https://orgmode.org/manual/Structure-Editing.html
you can move section using `ctrl-shift n/p`
`shift tab` to cycle through levels
Ctrl+shift-n/p move line
To insert new blanklines `]o` `[o`
`ctrl shit n/p` mve line down/up
to move entire subsection `M-j\k`

** layout
'*' allows for section/titles. Can be hidden using `tab`

hello layout

Numbered list
1. second item
2. this is first item
3. thirs item

unorganized list
- one
- two

* Magit
** Movement
close window: q
its deeper than lazygit


Just like `org-mode` tab can expands and shift-tab can retract columns.
You can view what changed by pressing tab on unstaged chages col.
stage change/file: s
unstage change/file: u
help: ?
commit: c
branch: b
tag: t
    push tags p t (all)
log: l


you can select block of code for the commit using `shift+v` then stage using `s`
to discard the seclection then using `x`
* Evil snip
Usefull for short movements accross paragraph/page
** Movement
h to jump to a char
if you want to look across the buffer instead of simply
next`;` previous`,` and will go on indefinitely
same as vim and can be combined for selection and deletion

s to jump to word using 2 char

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

* Avy
** Movement

    tldr: `g-s`
    `g s s` to jump to char
   `g s sapce` works well too
    also works with motions
    To have avy running across all windows
https://www.youtube.com/watch?v=zar4GsOBU0g&list=PLhXZp00uXBk4np17N39WvB80zgxlZfVwj&index=7
Emacs support a `gui` for variables and documentation e.g. `space h v`
