# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/joel/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  asdf aws brew bundler docker git gem node npm history macos rails redis-cli ruby colored-man-pages vscode zsh-syntax-highlighting
)
# Allow [ or ] whereever you want
unsetopt nomatch
source $ZSH/oh-my-zsh.sh

# User configuration
  if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

    autoload -Uz compinit
    compinit
  fi
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias zshconfig="code ~/.zshrc"
alias ohmyzsh="code ~/.oh-my-zsh"
alias opendiff="git diff --name-only | uniq | xargs code"
alias dr=docker
alias go-reshim='asdf reshim golang && export GOROOT="$(asdf where golang)/go"'


# fpath=(/usr/local/share/zsh-completions $fpath)

export PATH="./bin:$PATH"

export PATH=/usr/local/bin:$PATH
export PATH="/opt/homebrew/opt/mysql@8.4/bin:$PATH"
export PATH="/usr/local/opt/sqlite/bin:$PATH"


export EDITOR="code --wait"
export PATH="$PATH:/usr/local/smlnj/bin"
# . /usr/local/etc/profile.d/z.sh
export PATH="/usr/local/opt/openssl/bin:$PATH"
export PATH="/Users/joel/bin:$PATH"
export PATH="/Users/joel/.composer/vendor/bin:$PATH"
# Logstash vars
export LOGSTASH_VERSION=7.5.2
export LOGSTASH_HOME=/usr/local/Cellar/logstash/7.5.2/libexec
export LOGSTASH_CONF_DIR=$LOGSTASH_HOME/config
export PATH=$PATH:$LOGSTASH_HOME/bin
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH="/usr/local/opt/openldap/bin:$PATH"
export PATH="/usr/local/opt/openldap/sbin:$PATH"
export PATH="$HOME/bin:$PATH"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# export SSL_CERT_FILE=/etc/ssl/cert.pem
export PATH="/Users/joel/.local/bin:$PATH"
export LDFLAGS="-L$(brew --prefix libyaml)/lib"
export CPPFLAGS="-I$(brew --prefix libyaml)/include"
export RUBY_YJIT_ENABLE=1
export RUBY_CONFIGURE_OPTS=--enable-yjit
# keep this script at the bottom of file to ensure asdf is first in path
. $HOME/.asdf/asdf.sh
# order matters here
export PATH="/Users/joel/.ebcli-virtual-env/executables:$PATH"

# bun completions
[ -s "/Users/joel/.bun/_bun" ] && source "/Users/joel/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Added by Windsurf
export PATH="/Users/joel/.codeium/windsurf/bin:$PATH"
