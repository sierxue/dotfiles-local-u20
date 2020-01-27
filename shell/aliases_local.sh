# aliases from aliases.sh from dotfiles.
# Use colors in coreutils utilities output
alias ls='ls --color=auto'
alias grep='grep --color'

# ls aliases
alias ll='ls -lah'
alias la='ls -A'
alias l='ls'

# Aliases to protect against overwriting
alias cp='cp -i'
alias mv='mv -i'

# git related aliases
alias gag='git exec ag'

# Update dotfiles
dfu() {
    (
        cd ~/.dotfiles && git pull --ff-only && ./install -q
    )
}

# Use pip without requiring virtualenv
syspip() {
    PIP_REQUIRE_VIRTUALENV="" pip "$@"
}

syspip2() {
    PIP_REQUIRE_VIRTUALENV="" pip2 "$@"
}

syspip3() {
    PIP_REQUIRE_VIRTUALENV="" pip3 "$@"
}

# cd to git root directory
# ganx: This alias rely on git plugin of oh-my-zsh.
alias cdgr='grt'

# Create a directory and cd into it
mcd() {
    mkdir "${1}" && cd "${1}"
}

# Jump to directory containing file
jump() {
    cd "$(dirname ${1})"
}

# cd replacement for screen to track cwd (like tmux)
scr_cd()
{
    builtin cd $1
    screen -X chdir "$PWD"
}

if [[ -n $STY ]]; then
    alias cd=scr_cd
fi

# Go up [n] directories
up()
{
    local cdir="$(pwd)"
    if [[ "${1}" == "" ]]; then
        cdir="$(dirname "${cdir}")"
    elif ! [[ "${1}" =~ ^[0-9]+$ ]]; then
        echo "Error: argument must be a number"
    elif ! [[ "${1}" -gt "0" ]]; then
        echo "Error: argument must be positive"
    else
        for ((i=0; i<${1}; i++)); do
            local ncdir="$(dirname "${cdir}")"
            if [[ "${cdir}" == "${ncdir}" ]]; then
                break
            else
                cdir="${ncdir}"
            fi
        done
    fi
    cd "${cdir}"
}

# Execute a command in a specific directory
xin() {
    (
        cd "${1}" && shift && ${@}
    )
}

# Check if a file contains non-ascii characters
nonascii() {
    LC_ALL=C grep -n '[^[:print:][:space:]]' "${1}"
}

# Fetch pull request

fpr() {
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        echo "error: fpr must be executed from within a git repository"
        return 1
    fi
    (
        cdgr
        if [ "$#" -eq 2 ]; then
            local repo="${PWD##*/}"
            local user="${1}"
            local branch="${2}"
        elif [ "$#" -eq 3 ]; then
            local repo="${1}"
            local user="${2}"
            local branch="${3}"
        else
            echo "Usage: fpr [repo] username branch"
            return 1
        fi

        git fetch "git@github.com:${user}/${repo}" "${branch}:${user}/${branch}"
    )
}

# Serve current directory

serve() {
    ruby -run -e httpd . -p "${1:-8080}"
}

# Mirror a website
alias mirrorsite='wget -m -k -K -E -e robots=off'

# Mirror stdout to stderr, useful for seeing data going through a pipe
alias peek='tee >(cat 1>&2)'

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# a group of git commands

# aliases related git
alias amp="git add --all && git commit -m 'update' && git push"

# https://github.com/ggreer/the_silver_searcher/wiki/Advanced-Usage
# alias ag="ag --path-to-ignore ~/.ignore" ttst: not working for 0.31.0, shipped with ubuntu 16.04.
alias ag="ag -p ~/.ignore"

alias grep="grep -I --line-number --color --exclude-dir=\.bzr --exclude-dir=\.git --exclude-dir=\.hg --exclude-dir=\.svn --exclude-dir=build --exclude-dir=dist --exclude=tags"

# http://vim.wikia.com/wiki/Enable_servername_capability_in_vim/xterm
alias vim='vim --servername vim'

# aliases related to python
alias jn='jupyter notebook'
alias python=python3
# alias pip=pip3
alias piu='python3 -m pip install --user'

# Open documents

###############
#  My papers  #
###############

# df.tex; df means demand forecasting.
alias gv_df='gvim ~/repo/pac/df.tex'
alias gv_invcost='gvim ~/repo/invCost/invCost-AP-order-stop.tex'
alias gv_toolsRes='gvim ~/repo/toolsRes/toolsRes.tex'
alias gv_ThesisSWUFE='gvim ~/repo/toolsRes/ThesisSWUFE.tex'

#############################
#  Frequently edited files  #
#############################

alias gv_qy='gvim ~/repo/gzsxls/qy-gzsxls/qy-gzsxls.tex'

######################
#  General commands  #
######################
# gg means command "git gui".
# i means install.
# so means command source.
# u means update.

alias bfg='java -jar ~/soft/bfg-1.13.0.jar'
alias gg_dot='cd ~/.df/dotfiles && git gui'
alias gg_dotl='cd ~/.df/dotfiles-local && git gui'
alias i_dotfiles='~/.df/dotfiles/install'
alias i_dotfiles_local='~/.df/dotfiles-local/install'
alias mc='make clean'
alias shrink='sudo ~/.df/dotfiles-local/scripts/shrink.sh -y'
alias so_v='source ~/.vimrc'
alias so_z='source ~/.zshrc'
alias u_dotfiles='cd ~/.df/dotfiles-local/scripts && ./pullDotfiles.sh'
alias u_vim_anywhere='~/.vim-anywhere/update'
alias gv_vimrc='gvim ~/.vimrc'


####################
#  classic papers  #
####################

alias gv_scarf_optimality_1960='gvim ~/repo/sierxue/static/pdf/scarf_optimality_1960.tex'

# za means zathura
alias za_berger='zathura ~/Zotero/storage/AHQ8RKFE/*.pdf'


###########################
#  General files to edit  #
###########################
# gv means gvim.

alias gv_bib='gvim ~/.df/dotfiles-local/texmf/bibtex/bib/ganx.bib'
alias gv_hist_zsh='gvim ~/.zsh_history'
alias gv_vimrc='gvim ~/.vimrc'
alias gv_sty_ganx='gvim ~/.df/dotfiles-local/texmf/tex/latex/ganx.sty'
alias gv_sty_teaching='gvim ~/.df/dotfiles-local/texmf/tex/latex/beamer_metropolis_teaching.sty'
alias gv_abolish='gvim ~/.df/dotfiles-local/vim/after/plugin/abolish.vim'
alias gv_castel='gvim ~/.df/dotfiles-local/vim/UltiSnips/tex.snippets'
alias gv_ganx='gvim ~/.df/dotfiles-local/vim/UltiSnips/ganxtex.snippets'
alias gv_test_snips='vim ~/.df/dotfiles-local/vim/UltiSnips/test_ultisnips.tex'
alias gv_rmd='gvim ~/.df/dotfiles-local/vim/UltiSnips/rmd.snippets'
alias gv_rmd2='gvim ~/.df/dotfiles-local/vim/UltiSnips/rmd2.snippets'
alias gv_aliases='gvim ~/.df/dotfiles-local/shell/aliases_local.sh'
alias gv_dl='gvim /media/a/data4T/youtube-dl/youtube-dl.txt'


############
#  zotero  #
############

# za means zathura
alias za_berger='zathura ~/Zotero/storage/AHQ8RKFE/*.pdf'

#############
#  invCost  #
#############

alias gv_invcost='gvim ~/repo/invCost/invCost-AP-order-stop.tex'

####################
#  classic papers  #
####################

alias gv_scarf_optimality_1960='gvim ~/repo/sierxue/static/pdf/scarf_optimality_1960.tex'

# za means zathura

alias za_berger='zathura ~/Zotero/storage/AHQ8RKFE/*.pdf'

#############
#  invCost  #
#############

alias gv_invcost='gvim ~/repo/invCost/invCost-AP-order-stop.tex'

####################
#  classic papers  #
####################

alias gv_scarf_optimality_1960='gvim ~/repo/sierxue/static/pdf/scarf_optimality_1960.tex'

alias gv_vimrc='gvim ~/.vimrc'

# za means zathura

alias za_berger='zathura ~/Zotero/storage/AHQ8RKFE/*.pdf'

#############
#  invCost  #
#############

alias gv_invcost='gvim ~/repo/invCost/invCost-AP-order-stop.tex'
