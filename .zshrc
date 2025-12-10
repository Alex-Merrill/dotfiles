export PATH=$PATH:$HOME/bin:/usr/local/go/bin:/usr/local/bin
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/local/bin
export XDG_DATA_HOME=$HOME/.local/share
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/include/opencv4
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PIPENV_PYTHON="$PYENV_ROOT/shims/python"
export PATH=$PATH:/usr/share/processing/processing-4.0.1
export PATH=$PATH:$HOME/.local/share/nvim/mason/bin

# nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# Path to oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="spaceship"

SPACESHIP_PROMPT_ORDER=(
  time      # Time stamps section
  user      # Username section
  dir       # Current directory section
  host      # Hostname section
  git       # Git section (git_branch + git_status)
  hg        # Mercurial section (hg_branch  + hg_status)
  package   # Package version
  node      # Node.js section
  ruby      # Ruby section
  elixir    # Elixir section
  xcode     # Xcode section
  swift     # Swift section
  golang    # Go section
  php       # PHP section
  rust      # Rust section
  haskell   # Haskell Stack section
  julia     # Julia section
  docker    # Docker section
  aws       # Amazon Web Services section
  gcloud    # Google Cloud Platform section
  venv      # virtualenv section
  conda     # conda virtualenv section
  dotnet    # .NET section
  kubectl   # Kubectl context section
  terraform # Terraform workspace section
  ibmcloud  # IBM Cloud section
  exec_time # Execution time
  line_sep  # Line break
  jobs      # Background jobs indicator
  exit_code # Exit code section
  char      # Prompt character
)

# Case sensitive shell autocomplete
CASE_SENSITIVE="true"
COMPLETION_WAITING_DOTS=true

# Updates
zstyle ':omz:update' mode reminder # just remind me to update when it's time
zstyle ':omz:update' frequency 13

DISABLE_MAGIC_FUNCTIONS="true"

ENABLE_CORRECTION="true"

plugins=(
  git
  fzf
  zsh-autosuggestions
  asdf
  pyenv
  poetry
)

# load pyenv
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

source $ZSH/oh-my-zsh.sh

# User configuration

# Zoxide
eval "$(zoxide init --cmd cd zsh)"

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPS="--extended"
export FZF_DEFAULT_COMMAND="fd --type f --hidden"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# fzf but to directories
f() {
  local dir
  dir=$(
    cd \
      && fd -0 --type d --hidden | fzf --read0
  ) && cd ~/$dir
}

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
  export VISUAL='nvim'
fi

unsetopt EXTENDED_HISTORY

################################ ALIAS #######################################
alias vim="nvim"
alias edit="nvim ~/.zshrc"
alias vimconfig="cd ~/.config/nvim/lua"
alias config="cd ~/.config"
alias dotfiles="cd ~/dotfiles"
alias ..="cd .."
alias la="ls -a"
alias ll="ls -ll"
alias code="cd ~/Code"
alias sourcezsh="source ~/.zshrc ~/.zsh_profile"
alias t="tmux -2 -u"
alias tko="tmux kill-server"
alias edittmux="vim ~/.tmux.conf"
alias copy='xclip -sel clip'
alias open="xdg-open"
alias fman="compgen -c | fzf --preview 'man -P cat {}' | xargs man"
alias get_idf=". $HOME/esp/esp-idf/export.sh"
