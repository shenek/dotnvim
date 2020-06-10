Installation
============

Link the dot files::
    git clone --recursive git@github.com:shenek/dotnvim.git ~/.nvim
    cd ~/.config && ln -sf ../.nvim/config nvim
    cd ~/.local/share && ln -fs ../../.nvim/local nvim

Adding a new plugin
===================
* Preferend way of installation is vim-plug
* If it is not possible to install it using vim-plug
  add a git submodule to local/site/pack/git-plugins/


Plugins
=======

vim-plug
--------
vim plugin management

gruvbox
-------
retro color scheme

vim-airlane
-----------
nicer status bar (you need have fonts-powerline installed)

vim-gitgutter
-------------
show changed lines from git

ale
---
asynchronous linter (integrates a various kinds of linters)

vim-indent-guides¬
-----------------
makes indentation visible

Hints
=====
Plugin management:
:Plug*
