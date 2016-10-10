# Path to your oh-my-zsh installation.
export ZSH=/Users/deNsuh/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="re5et"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git colorize colored-man-pages)

# User configuration

# export PATH="/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

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
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias f='open -a Finder ./' # open current directory in finder
alias ctags="/usr/local/Cellar/ctags/5.8_1/bin/ctags"

# ls aliases
alias la='ls -a'
alias ll='ls -al'

# tmux related aliases
alias tls='tmux ls'
alias ta='tmux attach -t'

# gst aliases
alias gl1='gst-launch-1.0'
alias gi1='gst-inspect-1.0'

# amazon web
alias aws='ssh -i "redhat_key.pem" ec2-user@ec2-52-78-85-239.ap-northeast-2.compute.amazonaws.com'
alias ohws='ssh -i "homepg.pem" ec2-user@ec2-52-78-186-215.ap-northeast-2.compute.amazonaws.com'

# kens project
alias k='~/kens'
alias ktcp='~/kens/app/TestTCP'
alias kbuild='~/kens/build'
alias ksrc='~/kens/src'

# cpplint
alias cpplint='~/styleguide/cpplint/cpplint.py'

# environment variables
PATH=/opt/local/bin:$PATH
export PATH
# for oracle database fucking client
PATH=$PATH:~/db/instantclient_12_1
export PATH
DYLD_LIBRARY_PATH=~/db/instantclient_12_1:$DYLD_LIBRARY_PATH
export DYLD_LIBRARY_PATH
NLS_LANG=AMERICAN_CIS.UTF8
export NLS_LANG

# mysql environment vars
export MYSQL_USER="mysql_user"
export MYSQL_DATABASE="sample_db"
export MYSQL_CONTAINER_NAME="mysql"
export MYSQL_ROOT_PASSWORD="1234"
export MYSQL_PASSWORD="1234"

export LC_ALL="en_US.UTF-8"

# pip3 install location - /usr/local/lib/python3.5/site-packages
