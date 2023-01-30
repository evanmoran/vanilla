# .zshrc
#-----------------------------------------------------------------------------

# Oh my zsh
#-----------------------------------------------------------------------------
# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor root line)

# Theme
#-----------------------------------------------------------------------------

ZSH_THEME=./.king-zsh-theme

#alias king='sudo zsh'
#function chess { echo "\n   ♔  ♕  ♖  ♗  ♘  ♙  ♚  ♛  ♜  ♝  ♞  ♟\n" }

# Settings
#-----------------------------------------------------------------------------

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Plugins
#-----------------------------------------------------------------------------
plugins=(brew git zsh-autosuggestions docker docker-compose)

source $ZSH/oh-my-zsh.sh

# OS Detection
#-----------------------------------------------------------------------------
# Supported arguments: "windows", "osx", "linux"
function is_os {
  if [ -z "$OS" ]; then
    OS=$(uname -s)
    [ "$?" -eq 0 ] || return 0
  fi
  if [ $1 = "windows" ] && [ "$OS" = "Windows_NT" ]; then
    return 0
  elif [ $1 = "linux" ] && [ "$OS" = "Linux" ]; then
      return 0
  elif [ $1 = "mac" ] && [ "$OS" = "Darwin" ]; then
    return 0
  fi
  return 1
}

# Configure with: ~/.location
function is_location {
  if [ "`cat ~/.location | grep $1`" = $1 ]; then
    return 0
  fi
  return 1
}

# Create missing .location file if it doesn't exist
if [ ! -f ~/.location ]; then
  echo "home" > ~/.location
fi

# Path
#-----------------------------------------------------------------------------

# Print operating system
echo # Newline
echo -n "  os:       "

# Bind for Windows
if is_os "windows"; then
  echo "windows"
  export USER=$USERNAME                 # OSX already has this
  export PATH=$PATH
  export PATH=~/bin:$PATH
  export PATH=~/bin/windows:$PATH

# Bind for OSX
elif is_os "mac"; then
  echo "mac"
  # Brew requires /usr/local/bin and /usr/local/sbin to be ahead of /usr/bin
  export PATH=/usr/local/bin:$PATH
  export PATH=/usr/local/sbin:$PATH

  # Brew Java requres
  export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
  export CPPFLAGS="-I/opt/homebrew/opt/openjdk/include"
  export JAVA_HOME=$(/usr/libexec/java_home) 

  # Path for node
  export NODE_PATH=/usr/local/lib/node_modules

  # Path for npm
  export PATH=/usr/local/share/npm/bin:$PATH

  # Todo: Fix path to be LOCATION based.
  export PATH=/usr/local/Cellar/git/1.7.8/bin:$PATH
  export PATH=/usr/local/share/python:$PATH
  export PATH=~/bin:$PATH

  # Editor so sublime is opened directly
  export EDITOR="sub -w"

  if [ -d $HOME/.rbenv ]; then
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"
  fi

# Bind for Linux
elif is_os "linux"; then
  echo "linux"

  export PATH="${HOME}/bin:${HOME}/.local/bin:$PATH"

  export MANPATH="${HOME}/share/man:${HOME}/.local/share/man:$MANPATH"
  export EDITOR="emacs"

  export NODE_PATH="#{HOME}/.node_modules"
fi

# Bind for osx and linux
if is_os "mac" || is_os "linux"; then

fi

echo "  user:     $USER"

# Prompt
#-----------------------------------------------------------------------------

# Disable virtualenv prompt
export VIRTUAL_ENV_DISABLE_PROMPT=1

export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

function git_branch {
   (echo -n "*"; git branch 2> /dev/null | sed -e '/^[^*]/d') | sed -e 's/\*\* \(.*\)/*\1/'
}

function define_colors {
  local N=30
  local COLOR
  for COLOR in BLACK RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
    export COLOR_${COLOR}="\033[0;${N}m"
    export COLOR_${COLOR}_LIGHT="\033[1;${N}m"
    export PROMPT_COLOR_${COLOR}="\[\033[0;${N}m\]"
    export PROMPT_COLOR_${COLOR}_LIGHT="\[\033[1;${N}m\]"
    N=$(($N + 1))
  done

  COLOR_NONE="\033[0m"
  COLOR_COMMENT=$COLOR_BLACK
  PROMPT_COLOR_NONE="\[${COLOR_NONE}\]"
  PROMPT_COLOR_GIT=$PROMPT_COLOR_GREEN
  PROMPT_COLOR_USER=$PROMPT_COLOR_CYAN
  PROMPT_COLOR_HOST=$PROMPT_COLOR_CYAN
  PROMPT_COLOR_PATH=$PROMPT_COLOR_YELLOW
  PROMPT_COLOR_HISTORY=$PROMPT_COLOR_RED
  PROMPT_COLOR_TIME=$PROMPT_COLOR_MAGENTA

  # TODO: Extend bold, underline to all colors
  COLOR_BOLD="\033[1m"
  PROMPT_COLOR_BOLD="\[${COLOR_BOLD}\]"

  COLOR_UNDERLINE="\033[4m"
  PROMPT_COLOR_UNDERLINE="\[${COLOR_UNDERLINE}\]"
}

alias print_colors="define_colors; echo -e \"${COLOR_NONE}COLOR_NONE\";echo -e \"${COLOR_WHITE}COLOR_WHITE\t${COLOR_WHITE_LIGHT}COLOR_WHITE_LIGHT\";echo -e \"${COLOR_BLUE}COLOR_BLUE\t${COLOR_BLUE_LIGHT}COLOR_BLUE_LIGHT\";echo -e \"${COLOR_GREEN}COLOR_GREEN\t${COLOR_GREEN_LIGHT}COLOR_GREEN_LIGHT\";echo -e \"${COLOR_CYAN}COLOR_CYAN\t${COLOR_CYAN_LIGHT}COLOR_LIGHT_CYAN\";echo -e \"${COLOR_RED}COLOR_RED\t${COLOR_RED_LIGHT}COLOR_RED_LIGHT\";echo -e \"${COLOR_MAGENTA}COLOR_MAGENTA\t${COLOR_MAGENTA_LIGHT}COLOR_MAGENTA_LIGHT\";echo -e \"${COLOR_YELLOW}COLOR_YELLOW\t${COLOR_YELLOW_LIGHT}COLOR_YELLOW_LIGHT\";echo -e \"${COLOR_BLACK}COLOR_BLACK\t${COLOR_BLACK_LIGHT}COLOR_BLACK_LIGHT\""11

# Aliases
#-----------------------------------------------------------------------------

if is_os "mac"; then

  function terminal_theme {
    TERMINAL_THEME=$1; if [ -z "$TERMINAL_THEME" ]; then TERMINAL_THEME="SolarizedDark"; fi
    osascript -e "tell application \"Terminal\" to set current settings of window 1 to settings set \"$TERMINAL_THEME\""
  }

  # function light { terminal_theme "SolarizedLight"; }
  # function dark { terminal_theme "SolarizedDark"; }
  function light { }
  function dark { }

  function black { dark; osascript -e "tell application \"Terminal\" to set background color of front window to {0, 0, 0}"; }
  function red { dark; osascript -e "tell application \"Terminal\" to set background color of front window to {6885, 0, 765}"; }
  function green { dark; osascript -e "tell application \"Terminal\" to set background color of front window to {3060, 6630, 3570}"; }
  function purple { dark; osascript -e "tell application \"Terminal\" to set background color of front window to {5100, 3060, 7395}"; }
  function cyan { dark; osascript -e "tell application \"Terminal\" to set background color of front window to {0, 7140, 7395}"; }
  function orange { dark; osascript -e "tell application \"Terminal\" to set background color of front window to {7650, 4080, 255}"; }
  function blue { dark; osascript -e "tell application \"Terminal\" to set background color of front window to {765, 0, 6885}"; }
  function yellow { dark; osascript -e "tell application \"Terminal\" to set background color of front window to {7650, 7650, 0}"; }
  function terminal_tab { osascript -e 'tell application "Terminal" to activate' \
    -e 'tell application "System Events" to tell process "Terminal" to keystroke "t" using command down' \
    -e 'tell application "Terminal" to do script "echo It begins." in selected tab of the front window' }

  # Run -- Echo your command as it is run
  function comment { echo -e "${COLOR_COMMENT}[$@]${COLOR_NONE}"; }
  function run { comment $@; $@; }
  function run_color { local C1=$1; local C2=$2; shift; shift; comment $@; $C1; $@; local ERR=$?; $C2; return $ERR}

  # Color terminal during run
  # function runl { light; run $@; local E=$?; dark; return $E }
  function runl { run_color light dark "$@" }
  function rund { run_color dark light "$@" }
  function runr { run_color red dark "$@" }
  function rung { run_color green dark "$@" }
  function runp { run_color purple dark "$@" }
  function runy { run_color yellow dark "$@" }
  function runo { run_color orange dark "$@" }
  function runc { run_color cyan dark "$@" }

  # Random
  function random { openssl rand -hex 8 | pbcopy; echo "Copy successful."}

  # Beep
  function beep { echo -n ''; }

  # Growl
  function growl { growlnotify -m $@; }
  function grun { $@; growlnotify -t "Completed" -m "$@"; }
  function grunl { light; grun $@; dark; }
  function grund { dark; grun $@; light; }
  function grunr { red; grun $@; dark; }
  function grung { green; grun $@; dark; }
  function grunp { purple; grun $@; dark; }
  function grunc { cyan; grun $@; dark; }
  function gruno { orange; grun $@; dark; }
  function gruny { yellow; grun $@; dark; }

  alias xcode="open -a XCode $@"

else

  function beep { echo -n ''; }
  function run { $@; }
  function runl { $@; }
  function rund { $@; }
  function runr { $@; }
  function rung { $@; }
  function runp { $@; }
  function runy { $@; }
  function runo { $@; }
  function runc { $@; }
  function growl { $@; }
  function grunl { $@; }
  function grunr { $@; }
  function grung { $@; }
  function grunp { $@; }
  function grunc { $@; }
  function gruno { $@; }
  function gruny { $@; }

fi

# One-time Aliases
#-----------------------------------------------------------------------------

if is_os "mac"; then
  function onetime_setup {
    # Ensure dropbox is /d
    run ln -s $HOME/Dropbox/ $HOME/d

    # Add .gitconfig, .bash_profile to path
    run ln -s $HOME/.files/.gitconfig $HOME/.gitconfig
    run ln -s $HOME/.files/.bash_profile $HOME/.bash_profile

    # Add sublime to commandline path
    run ln -s '/Applications/Sublime Text 3.app/Contents/SharedSupport/bin/subl' /usr/local/bin/sub

    # Hotlink sublime user settings to dropbox
    run rm -rf "$HOME/Library/Application Support/Sublime Text 3/Packages/User"; ln -s "$HOME/d/env/sublime/Packages/User" "$HOME/Library/Application Support/Sublime Text 3/Packages/User"

    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  }
fi

# Config Aliases
#-----------------------------------------------------------------------------

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

alias open_profile="${EDITOR} ~/.files/osx/osx.bash ~/.files/osx/links.bash ~/.files/git/gitconfig ~/.files/osx/karabiner/karabiner.json  ~/.files/zsh/zshrc"

alias plan="${EDITOR} ~/.plan"
alias notes="${EDITOR} ~/.notes"

alias reload="pushd ${HOME}/.files > /dev/null; git pull; source ${HOME}/.files/.zshrc; popd > /dev/null"

#-----------------------------------------------------------------------------
# ls colors
#-----------------------------------------------------------------------------
export CLICOLOR=1
# export LSCOLORS=
export LSCOLORS=Exgxcxdxbxahxfxbxdxcgc
export LS_OPTIONS='--color=auto'
export LS_COLORS="no=00;38;5;244:rs=0:di=00;38;5;33:ln=01;38;5;37:mh=00:pi=48;5;230;38;5;136;01:so=48;5;230;38;5;136;01:do=48;5;230;38;5;136;01:bd=48;5;230;38;5;244;01:cd=48;5;230;38;5;244;01:or=48;5;235;38;5;160:su=48;5;160;38;5;230:sg=48;5;136;38;5;230:ca=30;41:tw=48;5;64;38;5;230:ow=48;5;235;38;5;33:st=48;5;33;38;5;230:ex=01;38;5;64:*.tar=00;38;5;61:*.tgz=01;38;5;61:*.arj=01;38;5;61:*.taz=01;38;5;61:*.lzh=01;38;5;61:*.lzma=01;38;5;61:*.tlz=01;38;5;61:*.txz=01;38;5;61:*.zip=01;38;5;61:*.z=01;38;5;61:*.Z=01;38;5;61:*.dz=01;38;5;61:*.gz=01;38;5;61:*.lz=01;38;5;61:*.xz=01;38;5;61:*.bz2=01;38;5;61:*.bz=01;38;5;61:*.tbz=01;38;5;61:*.tbz2=01;38;5;61:*.tz=01;38;5;61:*.deb=01;38;5;61:*.rpm=01;38;5;61:*.jar=01;38;5;61:*.rar=01;38;5;61:*.ace=01;38;5;61:*.zoo=01;38;5;61:*.cpio=01;38;5;61:*.7z=01;38;5;61:*.rz=01;38;5;61:*.apk=01;38;5;61:*.gem=01;38;5;61:*.jpg=00;38;5;136:*.JPG=00;38;5;136:*.jpeg=00;38;5;136:*.gif=00;38;5;136:*.bmp=00;38;5;136:*.pbm=00;38;5;136:*.pgm=00;38;5;136:*.ppm=00;38;5;136:*.tga=00;38;5;136:*.xbm=00;38;5;136:*.xpm=00;38;5;136:*.tif=00;38;5;136:*.tiff=00;38;5;136:*.png=00;38;5;136:*.svg=00;38;5;136:*.svgz=00;38;5;136:*.mng=00;38;5;136:*.pcx=00;38;5;136:*.dl=00;38;5;136:*.xcf=00;38;5;136:*.xwd=00;38;5;136:*.yuv=00;38;5;136:*.cgm=00;38;5;136:*.emf=00;38;5;136:*.eps=00;38;5;136:*.CR2=00;38;5;136:*.ico=00;38;5;136:*.tex=01;38;5;245:*.rdf=01;38;5;245:*.owl=01;38;5;245:*.n3=01;38;5;245:*.ttl=01;38;5;245:*.nt=01;38;5;245:*.torrent=01;38;5;245:*.xml=01;38;5;245:*Makefile=01;38;5;245:*Rakefile=01;38;5;245:*build.xml=01;38;5;245:*rc=01;38;5;245:*1=01;38;5;245:*.nfo=01;38;5;245:*README=01;38;5;245:*README.txt=01;38;5;245:*readme.txt=01;38;5;245:*.md=01;38;5;245:*README.markdown=01;38;5;245:*.ini=01;38;5;245:*.yml=01;38;5;245:*.cfg=01;38;5;245:*.conf=01;38;5;245:*.c=01;38;5;245:*.cpp=01;38;5;245:*.cc=01;38;5;245:*.log=00;38;5;240:*.bak=00;38;5;240:*.aux=00;38;5;240:*.lof=00;38;5;240:*.lol=00;38;5;240:*.lot=00;38;5;240:*.out=00;38;5;240:*.toc=00;38;5;240:*.bbl=00;38;5;240:*.blg=00;38;5;240:*~=00;38;5;240:*#=00;38;5;240:*.part=00;38;5;240:*.incomplete=00;38;5;240:*.swp=00;38;5;240:*.tmp=00;38;5;240:*.temp=00;38;5;240:*.o=00;38;5;240:*.pyc=00;38;5;240:*.class=00;38;5;240:*.cache=00;38;5;240:*.aac=00;38;5;166:*.au=00;38;5;166:*.flac=00;38;5;166:*.mid=00;38;5;166:*.midi=00;38;5;166:*.mka=00;38;5;166:*.mp3=00;38;5;166:*.mpc=00;38;5;166:*.ogg=00;38;5;166:*.ra=00;38;5;166:*.wav=00;38;5;166:*.m4a=00;38;5;166:*.axa=00;38;5;166:*.oga=00;38;5;166:*.spx=00;38;5;166:*.xspf=00;38;5;166:*.mov=01;38;5;166:*.mpg=01;38;5;166:*.mpeg=01;38;5;166:*.m2v=01;38;5;166:*.mkv=01;38;5;166:*.ogm=01;38;5;166:*.mp4=01;38;5;166:*.m4v=01;38;5;166:*.mp4v=01;38;5;166:*.vob=01;38;5;166:*.qt=01;38;5;166:*.nuv=01;38;5;166:*.wmv=01;38;5;166:*.asf=01;38;5;166:*.rm=01;38;5;166:*.rmvb=01;38;5;166:*.flc=01;38;5;166:*.avi=01;38;5;166:*.fli=01;38;5;166:*.flv=01;38;5;166:*.gl=01;38;5;166:*.m2ts=01;38;5;166:*.divx=01;38;5;166:*.webm=01;38;5;166:*.axv=01;38;5;166:*.anx=01;38;5;166:*.ogv=01;38;5;166:*.ogx=01;38;5;166:"

# between quotation marks is the tool output for LS_COLORS
# export LS_COLORS="di=31;41:ln=31;41:so=31;41:pi=31;41:ex=31;41:bd=31;41:cd=31;41:su=31;41:sg=31;41:tw=31;41:ow=31;41:"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
[ "$TERM" = "xterm" ] && TERM="xterm-256color"

if is_os 'mac'; then
  eval `gdircolors ~/.dircolors`
  # TODO: Detect if gls exists before binding these
  alias ls='run gls --color -F $@'      # Compact view
  alias ll='run gls --color -AF $@'     # Compact view, showing hidden
  alias la='run gls --color -lhAF $@'   # Full view, showing hidden
  alias lt='run gls --color -AF $@ | grep test'   # Compact view, filtering test
  alias l.='gls --color -adF .*'        # Show just .files
  alias ls0='ls -Gp'
  alias ls1='ls -GF'
elif is_os 'linux'; then
  eval `dircolors ~/.dircolors`
  alias ls='run ls --color -F $@'       # Compact view
  alias ll='run ls --color -AF $@'      # Compact view, showing hidden
  alias la='run ls --color -lhAF $@'    # Full view, showing hidden
fi

# Navigation Alaises
#-----------------------------------------------------------------------------

alias hlist='history $@'
alias hclear='history -c'             # history clear
alias hgrep='history | grep -i $@'   # history grep

alias asdf='clear;'
alias cl='clear; ls -lhG $@'
alias cla='clear; ls -lhAG $@'

alias s='cd ..'
alias timeutc='date -u "+UTC    %Y-%m-%d %H:%M:%S    %Y-%m-%d %r"'
alias timepst='date "+PST    %Y-%m-%d %H:%M:%S    %Y-%m-%d %r"'
alias timenow='utc && pst'

alias diff='run git difftool --extcmd=/usr/bin/opendiff $@'
alias diffs='run git difftool --staged --extcmd=/usr/bin/opendiff $@'

# Run, change color, and echo
function ssh {
  runr /usr/bin/ssh "$@"
}

# Info Alaises
#-----------------------------------------------------------------------------
alias psls='ps aux $@'             # List running processes
alias psg='ps aux | grep $@'      # Search running processes
alias psgi='ps aux | grep -i $@'  # Case insensitive search
alias findgrep='find . -type f | grep $@' # Find recursive with grep
alias findgrepfull='find $PWD -type f | grep $@' # Find recursive with grep

# Bazel aliases
#-----------------------------------------------------------------------------
alias bb='bazel build $@'
alias bt='bazel test --test_output=all $@'
alias btq='bazel test $@'
alias bc='bazel clean $@'
alias bce='bazel clean --expunge'
alias br='bazel run $@'

# Go
alias g='go @$'
export GOPATH=~/go/
export PATH=$PATH:$GOPATH/bin

# GRPC
export GRPC_GO_LOG_VERBOSITY_LEVEL=99
export GRPC_GO_LOG_SEVERITY_LEVEL=info

# Docker aliases
#-----------------------------------------------------------------------------
alias docker_list_ip_addresses='docker inspect --format="{{.Name}}                                  {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}" $(docker ps -aq)'
alias dip='docker_list_ip_addresses'
alias dcb='run docker-compose up --build $@'
alias docker_file_up='run docker-compose up file_server'
alias docker_identity_up='run docker-compose up identity_server'
alias dcu='run docker-compose up $@'
alias dcd='run docker-compose down $@'
alias dcp='run docker-compose ps $@'
alias dc='run docker-compose $@'

alias dm='docker-machine'
alias dmx='docker-machine ssh'
alias dk='docker'
alias dki='docker images'
alias dks='docker service'
alias dkrm='docker rm'
alias dkl='docker logs'
alias dklf='docker logs -f'
alias dkflush='docker rm `docker ps --no-trunc -aq`'
alias dkflush2='docker rmi $(docker images --filter "dangling=true" -q --no-trunc)'
alias dkt='docker stats --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}\t{{.NetIO}}"'
alias dkps="docker ps --format '{{.ID}} ~ {{.Names}} ~ {{.Status}} ~ {{.Image}}'"

dkln() {
  docker logs -f `docker ps | grep $1 | awk '{print $1}'`
}

dkp() {
  if [ ! -f .dockerignore ]; then
    echo "Warning, .dockerignore file is missing."
    read -p "Proceed anyway?"
  fi

  if [ ! -f package.json ]; then
    echo "Warning, package.json file is missing."
    read -p "Are you in the right directory?"
  fi

  VERSION=`cat package.json | jq .version | sed 's/\"//g'`
  NAME=`cat package.json | jq .name | sed 's/\"//g'`
  LABEL="$1/$NAME:$VERSION"

  docker build --build-arg NPM_TOKEN=${NPM_TOKEN} -t $LABEL .

  read -p "Press enter to publish"
  docker push $LABEL
}

dkpnc() {
  if [ ! -f .dockerignore ]; then
    echo "Warning, .dockerignore file is missing."
    read -p "Proceed anyway?"
  fi

  if [ ! -f package.json ]; then
    echo "Warning, package.json file is missing."
    read -p "Are you in the right directory?"
  fi

  VERSION=`cat package.json | jq .version | sed 's/\"//g'`
  NAME=`cat package.json | jq .name | sed 's/\"//g'`
  LABEL="$1/$NAME:$VERSION"

  docker build --build-arg NPM_TOKEN=${NPM_TOKEN} --no-cache=true -t $LABEL .
  read -p "Press enter to publish"
  docker push $LABEL
}

dkpl() {
  if [ ! -f .dockerignore ]; then
    echo "Warning, .dockerignore file is missing."
    read -p "Proceed anyway?"
  fi

  if [ ! -f package.json ]; then
    echo "Warning, package.json file is missing."
    read -p "Are you in the right directory?"
  fi

  VERSION=`cat package.json | jq .version | sed 's/\"//g'`
  NAME=`cat package.json | jq .name | sed 's/\"//g'`
  LATEST="$1/$NAME:latest"

  docker build --build-arg NPM_TOKEN=${NPM_TOKEN} --no-cache=true -t $LATEST .
  read -p "Press enter to publish"
  docker push $LATEST
}

dkclean() {
  docker rm $(docker ps --all -q -f status=exited)
  docker volume rm $(docker volume ls -qf dangling=true)
}

dkprune() {
  docker system prune -af
}

dktop() {
  docker stats --format "table {{.Container}}\t{{.Name}}\t{{.CPUPerc}}  {{.MemPerc}}\t{{.NetIO}}\t{{.BlockIO}}"
}

dkstats() {
  if [ $# -eq 0 ]
    then docker stats --no-stream;
    else docker stats --no-stream | grep $1;
  fi
}

dke() {
  docker exec -it $1 /bin/sh
}

dkexe() {
  docker exec -it $1 $2
}

dkreboot() {
  osascript -e 'quit app "Docker"'
  countdown 2
  open -a Docker
  echo "Restarting Docker engine"
  countdown 120
}

dkstate() {
  docker inspect $1 | jq .[0].State
}

dksb() {
  docker service scale $1=0
  sleep 2
  docker service scale $1=$2
}


# Git aliases
#-----------------------------------------------------------------------------

alias git='noglob git'
alias gb='git branch'
alias gs='git status'

alias gls="git --no-pager log -n 10 --graph --pretty=format:'%C(cyan)%h%C(green) %an %C(yellow)%cr%C(reset): %s%C(reset)%C(magenta)%d%Creset' --abbrev-commit --date=relative"

alias gsh="git_show_last_commit"

alias gh="gls"

alias gll="git --no-pager log -n 30 --graph --pretty=format:'%C(cyan)%h%C(green) %an %C(yellow)%cr%C(reset): %s%C(reset)%C(magenta)%d%Creset' --abbrev-commit --date=relative"

alias gla="git lg"

alias glm="git --no-pager log -n 40 --graph --pretty=format:'%C(cyan)%h%C(green) %an %C(yellow)%cr%C(reset): %s%C(reset)%C(magenta)%d%Creset' --abbrev-commit --date=relative | grep 'Evan Moran'"

alias gg='echo -e "\n--------------------------------- Git Branch -----------------------------------\n";git branch;echo -e "\n--------------------------------- Git Status -----------------------------------\n";git status;echo -e "\n--------------------------------- Git Log --------------------------------------\n";git lg | head -n 12'

alias ggm='echo -e "\n--------------------------------- Git Branch -----------------------------------\n";git branch;echo -e "\n--------------------------------- Git Status -----------------------------------\n";git status;echo -e "\n--------------------------------- Git Log ------------------------------------- \n";git lg | grep Evan | head -n 12 '

alias gd='run git diff'
alias gds='run git diff --staged'
alias gdc='run git diff --cached'
alias gdt='git symbolic-ref -q HEAD | xargs git for-each-ref --format="%(upstream:short)" | xargs -o git diff'

alias gcp='git cherry-pick $@'
alias gcpa='git cherry-pick --abort $@'
alias gcpc='git cherry-pick --continue $@'

# Git workflow

# Git core manipulation

alias ga='run git add'
alias gap='run git add -p'

alias gf='run git fetch'
alias gfa='git fetch --all $@'
alias gfap='git fetch --all --prune $@'
alias gfo='git fetch origin $@'

alias gpr='run git pull --rebase'
alias gprs='run git pull --rebase && run git submodule update --init --recursive'

alias gy='run git yank'

alias gwip="run git commit -m \"WIP\""
alias gca='run git commit --amend $@'
alias gcp='run git commit -p $@'
alias gcm='run git commit -m "$@"'
alias gr='run git remote $@'
alias grv='run git remote -v $@'
alias gra='run git remote add $@'
alias gpush='run git stash'
alias gpop='run git stash pop'

alias gmt='run git mergetool'

# Rebase interactive to the origin/branch you are currently upstream to.

alias gack='run git add . && git commit -m "f"'
alias grimace='run git add . && git commit -m "f" && git rebase -i master'

# Super userful rebase commands
alias git_rebase_from_master='run git rebase master'
alias git_rebase_from_origin_master='run git fetch; run git rebase origin/master' 
alias git_rebase_interactive_from_origin_master='run git fetch; run git rebase -i origin/master'
alias git_rebase_from_origin_staging='run git fetch; run git rebase origin/staging'
alias git_rebase_interactive_from_origin_staging='run git fetch; run git rebase -i origin/staging'

# Short names for those same rebase commands
alias grm='run git fetch; run git rebase master'
alias grom='git_rebase_from_origin_master'
alias grim='git_rebase_interactive_from_origin_master'
alias gros='git_rebase_from_origin_staging'
alias gris='git_rebase_interactive_from_origin_staging'
alias grt='git_rebase_top_commits'
alias grit='git symbolic-ref -q HEAD | xargs git for-each-ref --format="%(upstream:short)" | xargs -o git rebase -i'
alias glt='git symbolic-ref -q HEAD | xargs git for-each-ref --format="%(upstream:short)" | xargs -o git lg HEAD'


alias git_monthly='git log --author evanmoran --format="%ci" | cut -f1-2 -d- | uniq -c | tail -r'
alias git_reset_head='run git reset -p HEAD'
alias git_deleted='run git ls-files -d'
alias git_show_last_commit='run git show HEAD'

alias git_restore_deleted='run git ls-files -d | xargs git checkout --'
alias git_undo_cherrypick='run git reset --merge ORIG_HEAD'
alias git_undo_last_commit='run git reset --soft HEAD~1'
alias git_undo_last_commit_and_lower='run git reset --keep HEAD~1'
alias git_undo_commit_hash='run git reset --soft $@'

alias git_remember_merge_changes='run git rerere'
alias git_rebase_top_commits='run git rebase -i HEAD~5'
alias git_list_remote_branches='run git br -r'
alias git_delete_remote_branch='echo "git push <remotename> --delete <branchname>"'
alias git_show_file_stats_between_branches='git '
alias git_pull_rebase_from_origin_master='run git fetch; run git rebase origin/master'
# Visual diffs in OSX using built in opendiff




# Go Aliases
alias go='richgo'
alias gt='richgo test $@'
alias gl='golangci-lint $@'
alias gv='richgo vet $@'

# Ansible aliases
#-----------------------------------------------------------------------------

alias a="${EDITOR} ${HOME}/.ansible_hosts"
alias an='run ansible $@'
alias anp='run ansible-playbook $@'
alias anu="run ansible $@ -u ubuntu"

alias framdpull='run ansible-playbook ~/framd/ansible/framd.all.yml -t pull $@'
alias framdinstall='run ansible-playbook ~/framd/ansible/framd.all.yml -t install $@'
alias framddbinstall='run ansible-playbook ~/framd/ansible/framd.db.yml -t install $@'
alias framdwebinstall='run ansible-playbook ~/framd/ansible/framd.web.yml -t install $@'

# EC2 aliases
#-----------------------------------------------------------------------------
# EC2FILTER = "awk -v OFS='    ' -F'\t' '{print $2, $3, $6, $4}'"

EC2FILTER="grep INSTANCE | awk -v OFS='    ' -F'\\\\t' '{print \$2, \$3, \$6, \$4}'"
alias els="echo '[ec2-describe-instances]'; ec2-describe-instances | $EC2FILTER"
alias els1="echo '[ec2-describe-instances --region us-east-1]'; ec2-describe-instances --region us-east-1 | $EC2FILTER"
alias els2="echo '[ec2-describe-instances --region us-east-2]'; ec2-describe-instances --region us-east-2 | $EC2FILTER"
alias els3="echo '[ec2-describe-instances --region us-east-3]'; ec2-describe-instances --region us-east-3 | $EC2FILTER"
alias els1w="echo '[ec2-describe-instances --region us-west-1]'; ec2-describe-instances --region us-west-1 | $EC2FILTER"
alias els2w="echo '[ec2-describe-instances --region us-west-2]'; ec2-describe-instances --region us-west-2 | $EC2FILTER"
alias els3w="echo '[ec2-describe-instances --region us-west-3]'; ec2-describe-instances --region us-west-3 | $EC2FILTER"
alias ekeys="run ec2-describe-keypairs"
alias erm="run ec2-terminate-instances $@"
alias estop="run ec2-stop-instances $@"
alias estart="run ec2-start-instances $@"
alias erun='run ec2-run-instances ami-137bcf7a -g sg-22f5824a -k evan_sphinx --instance-type t1.micro --region us-east-1 $@'
alias ermall='for i in `ec2din | grep running | cut -f2`; do ec2kill $i; done'



echo -n "  context: "

function pidOf {
  ps aux | grep "$1" | grep -v grep | tail -n 1 | awk '{ print $2; }'
}

if is_location "home"; then

# Home Aliases
#-----------------------------------------------------------------------------
  echo -n " @home"


# Work Aliases
#-----------------------------------------------------------------------------

elif is_location "niantic"; then
  echo -n " @niantic"


# Server Aliases
#-----------------------------------------------------------------------------

elif is_location "server"; then
  echo -n " @server"

else
  echo -n " @unknown (no aliases bound)"


fi

# End
#-----------------------------------------------------------------------------

# Two newlines
echo
echo


if type complete &>/dev/null; then
  _npm_completion () {
    local words cword
    if type _get_comp_words_by_ref &>/dev/null; then
      _get_comp_words_by_ref -n = -n @ -n : -w words -i cword
    else
      cword="$COMP_CWORD"
      words=("${COMP_WORDS[@]}")
    fi

    local si="$IFS"
    if ! IFS=$'\n' COMPREPLY=($(COMP_CWORD="$cword" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           npm completion -- "${words[@]}" \
                           2>/dev/null)); then
      local ret=$?
      IFS="$si"
      return $ret
    fi
    IFS="$si"
    if type __ltrim_colon_completions &>/dev/null; then
      __ltrim_colon_completions "${words[cword]}"
    fi
  }
  complete -o default -F _npm_completion npm
elif type compdef &>/dev/null; then
  _npm_completion() {
    local si=$IFS
    compadd -- $(COMP_CWORD=$((CURRENT-1)) \
                 COMP_LINE=$BUFFER \
                 COMP_POINT=0 \
                 npm completion -- "${words[@]}" \
                 2>/dev/null)
    IFS=$si
  }
  compdef _npm_completion npm
elif type compctl &>/dev/null; then
  _npm_completion () {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    if ! IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       npm completion -- "${words[@]}" \
                       2>/dev/null)); then

      local ret=$?
      IFS="$si"
      return $ret
    fi
    IFS="$si"
  }
  compctl -K _npm_completion npm
fi
###-end-npm-completion-###
