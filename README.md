## About

This directory houses copies of the configuration files and templates
for my personal setup.  That includes all my dotfiles and folder of vim
plugins.

## Getting Started on a New System or Server

To efficiently mirror the setup in this folder, you can use symlinks.
For example, you could have your system's `.vim/` directory reference
the `my.vim/` folder in this repo.  That way, when you add plugins on
one machine, commit, and git pull on another machine, you're plugins
will automatically be updated.

To set this up (taking the `.vim/` example), run 

    cd 
    ln -s /path/to/gitrepo/my.vim .vim

Done. Know when vim opens and looks for your `.vim/` directory, it will
be redirected to the git repo with the latest setup and plugins.
