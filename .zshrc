export PATH=$PATH:$HOME/bin:/usr/local/go/bin:/usr/local/bin
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/local/bin
export XDG_DATA_HOME=$HOME/.local/share

# nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="spaceship"

SPACESHIP_PROMPT_ORDER=(
  time          # Time stamps section
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  hg            # Mercurial section (hg_branch  + hg_status)
  package       # Package version
  gradle        # Gradle section
  maven         # Maven section
  node          # Node.js section
  ruby          # Ruby section
  elixir        # Elixir section
  xcode         # Xcode section
  swift         # Swift section
  golang        # Go section
  php           # PHP section
  rust          # Rust section
  haskell       # Haskell Stack section
  julia         # Julia section
  docker        # Docker section
  aws           # Amazon Web Services section
  gcloud        # Google Cloud Platform section
  venv          # virtualenv section
  conda         # conda virtualenv section
  pyenv         # Pyenv section
  dotnet        # .NET section
  ember         # Ember.js section
  kubectl       # Kubectl context section
  terraform     # Terraform workspace section
  ibmcloud      # IBM Cloud section
  exec_time     # Execution time
  line_sep      # Line break
  vi_mode       # Vi-mode indicator
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)




# Case sensitive shell autocomplete
CASE_SENSITIVE="true"
COMPLETION_WAITING_DOTS=true

# Updates
zstyle ':omz:update' mode reminder  # just remind me to update when it's time
zstyle ':omz:update' frequency 13

DISABLE_MAGIC_FUNCTIONS="true"

ENABLE_CORRECTION="true"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPS="--extended"
export FZF_DEFAULT_COMMAND="fd --type f"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# fzf but to directories
f() {
    local dir
    dir=$(
        cd &&
          fd -0 --type d --hidden | fzf --read0
    ) && cd ~/$dir
}

# export MANPATH="/usr/local/man:$MANPATH"

# Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
 else
   export EDITOR='nvim'
 fi

unsetopt EXTENDED_HISTORY


################################ ALIAS #######################################
alias vim="nvim" 
alias edit="nvim ~/.zshrc"
alias vimconfig="cd ~/.config/nvim/lua"
alias config="cd ~/.config"
alias la="ls -a"
alias ll="ls -ll"
alias code="cd ~/Desktop/code"
alias sourcezsh="source ~/.zshrc ~/.zsh_profile"
alias python="python3"
alias tmux="tmux -2"
alias edittmux="vim ~/.tmux.conf"
alias luamake=/home/alex/tools/lua-language-server/3rd/luamake/luamake

