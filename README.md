# mac-dev-setup
Things I setup on my laptop. Insipred by https://github.com/utkuufuk/ubuntu-on-steroids.

# Enable these flags to name windows, fill PDF forms, and save passwords with two phase login
chrome://flags/#window-naming

chrome://flags/#pdf-form-save

chrome://flags/#username-first-flow

# Apps
- Copyclip for clipboard history
- Brew for packages
- Rectangle for window snapping
- Itsycal for a calendar dropdown in menu bar (add to startup https://macpaw.com/how-to/remove-startup-items-in-osx)

# Settings
```
sudo chmod 666 /etc/ssh/sshd_config
vim /etc/ssh/sshd_config # Replace this by mosh
  > CountAliveInterval 120
echo $'set -s escape-time 0\nset-option -g default-shell /bin/bash\nunbind Up     \nunbind Down   \nunbind Right   \nunbind Left  \nbind Up run-shell "if [ $(tmux display-message -p \'#{pane_at_top}\') -ne 1 ]; then tmux select-pane -U; fi"\nbind Down run-shell "if [ $(tmux display-message -p \'#{pane_at_bottom}\') -ne 1 ] ; then tmux select-pane -D; fi"\nbind Right run-shell "if [ $(tmux display-message -p \'#{pane_at_right}\') -ne 1 ]; then tmux select-pane -R; fi"\nbind Left run-shell "if [ $(tmux display-message -p \'#{pane_at_left}\') -ne 1 ]; then tmux select-pane -L; fi"' > ~/.tmux.conf # Makes escape zero delay and has 'ctrl b + arrow' end at an edge pane
echo "set-option -g history-limit 5000" >> ~/.tmux.conf # Increase tmux scrollback buffer size
echo "set -g @plugin 'tmux-plugins/tmux-resurrect'" >> ~/.tmux.conf 
echo "set -g @plugin 'tmux-plugins/tmux-continuum'" >> ~/.tmux.conf  # Allows tmuxes to autosave every 15 min and resurrect on a system restart, persisting them
tmux source-file ~/.tmux.conf # If in tmux
echo $'filetype plugin indent on\nfiletype plugin on\nsyntax on\n:inoremap jj <Esc>\n' > ~/.vimrc
echo $'"\\e[A": history-search-backward\n"\\e[B": history-search-forward' > ~/.inputrc
bind -f ~/.inputrc
```
# Deprecated
https://bahoom.com/hyperswitch
- Enable cross-window and cross-screen on first settings pane
- Alt+tab by window instead of application in Mac
- Not cross-window, orders of windows messed up
