if [ "$(uname -s)" != "Darwin" ]; then
  info "skipping themes, OS not currently supported"
  exit 0
fi

# install solarized
source $DOTFILES_ROOT/bootstrap/functions

# vim - pathogen
# pathogen combined with the symlink in vim/bundle take care of this


# iTerm
if [ -f "$DOTFILES_SCRATCH/iterm2_solarized.loaded" ]; then
  success "skipped iTerm2 Solarized Dark theme, already loaded"
else
  open "${DOTFILES_ROOT}/themes/solarized/iterm2-colors-solarized/Solarized Dark.itermcolors" && \
          touch $DOTFILES_SCRATCH/iterm2_solarized.loaded
        if [ $? == 0 ]; then
          success "loaded iTerm2 Solarized Dark theme"
  else
    fail "failed to load iTerm2 Solarized Dark theme"
        fi
fi

# Terminal.app
read -d '' terminal_app_solarized_dark <<EOD

tell application "Terminal"

        local allOpenedWindows
        local initialOpenedWindows
        local windowID
        set themeName to "Solarized Dark xterm-256color"

        (* Store the IDs of all the open terminal windows. *)
        set initialOpenedWindows to id of every window

        (* Open the custom theme so that it gets added to the list
           of available terminal themes (note: this will open two
           additional terminal windows). *)
        do shell script "open '${DOTFILES_ROOT}/themes/solarized/osx-terminal.app-colors-solarized/xterm-256color/" & themeName & ".terminal'"

        (* Wait a little bit to ensure that the custom theme is added. *)
        delay 1

        (* Set the custom theme as the default terminal theme. *)
        set default settings to settings set themeName

        (* Get the IDs of all the currently opened terminal windows. *)
        set allOpenedWindows to id of every window

        repeat with windowID in allOpenedWindows

                (* Close the additional windows that were opened in order
                   to add the custom theme to the list of terminal themes. *)
                if initialOpenedWindows does not contain windowID then
                        close (every window whose id is windowID)

                (* Change the theme for the initial opened terminal windows
                   to remove the need to close them in order for the custom
                   theme to be applied. *)
                else
                        set current settings of tabs of (every window whose id is windowID) to settings set themeName
                end if

        end repeat

end tell

EOD

if [ -f "$DOTFILES_SCRATCH/terminal_app_solarized.loaded" ]; then
  success "skipped Terminal.app Solarized Dark theme, already loaded"
else
        osascript -e "$terminal_app_solarized_dark" && \
          touch $DOTFILES_SCRATCH/terminal_app_solarized.loaded
        if [ $? == 0 ]; then
          success "loaded Terminal.app Solarized Dark theme"
        else
                fail "failed to load Terminal.app Solarized Dark theme"
        fi
fi
