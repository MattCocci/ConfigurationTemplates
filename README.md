## About

This directory houses copies of the configuration files and templates for my
personal setup.  That includes all of my dotfiles and my folder of vim plugins.

## Adding New Plugins in `my.vimrc`

Since I always download the plugins from Github, I need to take proper
care to install them as a git submodule so that they can be tracked and
updated correctly. So for a new plugin, rather than running the usual

    cd ConfigurationTemplates/my.vim/bundle
    git clone http://github.com/user1/some-plugin.git 

I need to run

    cd ConfigurationTemplates/
    git submodule add http://github.com/user1/some-plugin.git my.vim/bundle/some-plugin

All of these submodules then show up in the `.gitmodules` file.

## Getting Started on a New System or Server

To efficiently mirror the setup in this folder on particular systems and
servers, I use symlinks.

For example, I have my system's `.vim/` directory reference the `my.vim/`
folder in this repo.  That way, when I add plugins on one machine, commit, and
git pull on another machine, all of the plugins will automatically be synced
and updated.

To set this up (taking the `.vim/` example), I run 

    cd 
    ln -s /path/to/gitrepo/my.vim .vim

Done. Now when vim opens and looks for the `.vim/` directory, it will be
redirected to this git repo (saved locally somewhere else on my system).
