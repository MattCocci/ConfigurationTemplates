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

Now all of these submodules then show up in the `.gitmodules` file. All
I need to do is add and commit that along with the new folder.

## Getting Started on a New System or Server

### Downloading This Repo and All Vim Plugins

On a new system, I start by first cloning this repo to some local
directory like `~/Documents/` (though any works, really). 

Then after cloning, I run
  
    cd /path/to/repo/ConfigurationTemplates/
    git submodule update --init

This will then pull download all of the plugins I need from Github.

Once downloaded, if the plugins have been updated on Github with bug
patches or changes, you can download the latest changes by running
  
    git submodule foreach git pull origin master

### Using these Files

To get a new system or server to use these files as my configuration
files, I use symlinks (rather than copying and pasting).

For example, I have my system's `~/.tmux.conf` simply be a pointer to
the `~/.tmux.conf` file in this repo.  That way, when I update this file
on one, commit, and run git pull on another machine, all of the plugins
will automatically be synced and updated.

To set this up (taking the `.tmux.conf` example), I run 

    cd 
    ln -s /path/to/gitrepo/.tmux.conf .tmux.conf

Done. Now when tmux opens and looks for the `.tmux.conf` directory, it
will be redirected to this git repo (saved locally somewhere else on my
system and easily synced/updated with a `git pull`).
