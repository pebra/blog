---
layout: post
title: "[Vim] Toggle between Vim and Shell"
date: 2013-11-14 13:35
comments: true
tags: 
- vim
- shell
---

There is a binding I kind of use a lot in the past months. As you may know, you can switch to a shell from Vim with 

``` bash
  :sh
```
in normal mode. If you type exit or hit CTR+D in your shell, you will get back to Vim. I like this behaviour when I am on a remote server via ssh.

Therefor I binded CTR+D in Vim to execute :sh, so I can toggle between shell and Vim with this shortcut.
To get it, include this snippet in your vimrc.

``` bash
  # ~/.vimrc
  noremap <C-d> :sh<cr>
```
