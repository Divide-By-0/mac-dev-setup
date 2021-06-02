# mac-dev-setup
Things I setup on my laptop

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
echo "set -s escape-time 0" > ~/.tmux.conf # Makes escape zero delay
tmux source-file ~/.tmux.conf # If in tmux
echo $'filetype plugin on\nsyntax on' > ~/.vimrc
echo $'"\\e[A": history-search-backward\n"\\e[B": history-search-forward' > ~/.inputrc
bind -f ~/.inputrc
```
# Deprecated
https://bahoom.com/hyperswitch
- Enable cross-window and cross-screen on first settings pane
- Alt+tab by window instead of application in Mac
- Not cross-window, orders of windows messed up
