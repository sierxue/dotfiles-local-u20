# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"
if [ ! -d $ZSH/custom/themes/spaceship-prompt ];
then
    git clone https://github.com/denysdovhan/spaceship-prompt.git \
        $ZSH/custom/themes/spaceship-prompt
    ln -s "$ZSH/custom/themes/spaceship-prompt/spaceship.zsh-theme" \
        "$ZSH/custom/themes/spaceship.zsh-theme"
fi
# Customization by ganx. Looks like there is a bug. Battery show is disabled.
# ref: https://github.com/denysdovhan/spaceship-prompt/issues/296
SPACESHIP_BATTERY_SHOW=(false)
ZSH_THEME="spaceship"
