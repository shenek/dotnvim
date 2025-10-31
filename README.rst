Installation
============

Link the dot files::
    git clone --recursive git@github.com:shenek/dotnvim.git ~/.nvim
    cd ~/.config && ln -sf ../.nvim/config nvim
    cd ~/.local/share && ln -fs ../../.nvim/local nvim

After that you need to install vim plugins using vim-plug::
    :PlugInstall

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

vim-indent-guides¬
-----------------
makes indentation visible

fzf-vim
-------

Fuzzy search for neovim

LanguageClient-nvim
-------------------

Better language client for neovim

deoplete
--------

Completion tool

float-preview.nvim
------------------

nicer float-preview (no preview windows)

vim-sandwich
------------

handles surrounding braces

vim-highlightedyank
-------------------

keep yanked text highlighted

nvim-treesitter
---------------

syntax highlighting (should be a part of neovim 0.7)
run :TSUpdate

Hints
=====
Plugin management:
------------------
:Plug*

Fuzzy search
------------
:FZF*
ff - open ripgrep dialog

Braces
------
adding in visual mode sa{
deleting in braces mode sd{
