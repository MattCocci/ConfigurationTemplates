# david4.zsh-theme - By Matthew Cocci
#
#   _____     __      _______ _____  _  _
#  |  __ \   /\ \    / /_   _|  __ \| || |
#  | |  | | /  \ \  / /  | | | |  | | || |_
#  | |  | |/ /\ \ \/ /   | | | |  | |__   _|
#  | |__| / ____ \  /   _| |_| |__| |  | |
#  |_____/_/    \_\/   |_____|_____/   |_|
#
# # The function prompt_git is taken from:
#
#   http://marcusolovsson.com/my-command-prompt/
#
# Some code also comes from the agnoster theme.
#


# Status:
# - Was there an error? (OFF for now)
# - Are there background jobs?
prompt_status() {
  local symbols
  symbols=()
  #[[ $RETVAL -ne 0 ]] && symbols+="%{%F{red}%}✘"
  [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{%F{cyan}%}⚙ "

  [[ -n "$symbols" ]] && echo -n $symbols
}


# Current working directory. Foreground (text) color is blue, the color
# of directories according to solarized dircolors.
prompt_dir() {
  echo -n "%{$fg[blue]%}%~"
}

# Git information if there is any
prompt_git() {
  local ref dirty mode

  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then

    # What to show if the prompt is dirty
    ZSH_THEME_GIT_PROMPT_DIRTY=' ±'

    # Parse the git info
    dirty=$(parse_git_dirty)

    # Format and display the branch
    ref=$(git symbolic-ref HEAD 2> /dev/null) || ref="➦ $(git show-ref --head -s --abbrev |head -n1 2> /dev/null)"
    local output="${ref/refs\/heads\//  }$dirty"
    if [[ -n $dirty ]]; then
      echo -n "$fg[red]$output"
    else
      echo -n "$fg[yellow]$output"
    fi

    # Add special git info
    repo_path=$(git rev-parse --git-dir 2>/dev/null)
    if [[ -e "${repo_path}/BISECT_LOG" ]]; then
      mode=" <B>"
    elif [[ -e "${repo_path}/MERGE_HEAD" ]]; then
      mode=" >M<"
    elif [[ -e "${repo_path}/rebase" || -e "${repo_path}/rebase-apply" || -e "${repo_path}/rebase-merge" || -e "${repo_path}/../.dotest" ]]; then
      mode=" >R>"
    fi
    echo -n ${mode}

  fi
}


## Main prompt
build_prompt() {
  RETVAL=$?
  prompt_status
  prompt_dir
  prompt_git
}

# Prompt, with clean line above
PROMPT='%{
%{%f%b%k%}$(build_prompt) %f%k%}» '
