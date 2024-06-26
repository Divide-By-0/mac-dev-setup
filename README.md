# mac-dev-setup
Things I setup on my Mac laptop -- it should work on Ubuntu as well. Insipred by https://github.com/utkuufuk/ubuntu-on-steroids. </br>
If you want the vim-specific version, try https://github.com/Divide-By-0/dotfiles.

# Chrome Flags

Enable these flags to name windows, fill PDF forms, and save passwords with two phase login

chrome://flags/#window-naming </br>
chrome://flags/#pdf-form-save </br>
chrome://flags/#username-first-flow

# Apps
- Copyclip 1 for clipboard history
- Brew for packages
- Rectangle for window snapping
- Itsycal for a calendar dropdown in menu bar (Need to [setup to automatically open on login](https://macpaw.com/how-to/remove-startup-items-in-osx))
- [Cursor IDE](https://cursor.so): AI-enabled editor with full context of your codebased and docs; made me 2x faster than using ChatGPT. One-click import all your existing vscode settings.
- [iBar](https://apps.apple.com/us/app/ibar-menubar-icon-control-tool/id6443843900): Collapse extra icons in the menu bar into a sub-menu. (Need to [setup to automatically open on login](https://macpaw.com/how-to/remove-startup-items-in-osx))
- superwhisper: Was recommended under the context of using it with cursor.so for faster coding. Theoretically useful for faster voice transcription, but it's hard to consistently include new keyboard shortcuts in my flow so hasn't been as useful as I would have liked.
- [Backtrack](https://apps.apple.com/gb/app/backtrack-record-the-past/id1477089520?mt=12): Record the past hour of audio and screen recording of your laptop.
- [Mullvad VPN](mullvad.net): Cheap at $5/mo, and the VPN that all my privacy-conscious security expert friends use. They are committed to not logging data, and have [successfully resisted search warrants in the past](https://mullvad.net/en/blog/2023/4/20/mullvad-vpn-was-subject-to-a-search-warrant-customer-data-not-compromised/).
- `brew install --cask discord slack remnote messenger vlc karabiner-elements transmission protonvpn mathpix-snipping-tool rectangle copyclip itsycal twitch-studio sonic-pi sreamlabs-obs trash`
  - `trash` lets you rm to Mac trash via command line
  - MathPix: One click screenshot OCR including extremely good LaTeX support. 
- `brew install wget youtube-dl ffmpeg fd`

# Chrome Extensions
- [Typio Reboot](https://github.com/tsukumijima/typio-form-recovery-reboot/releases/tag/v3.3.0) to save form history in Chrome 
- [Tempus: Timed Youtube Comments](https://chrome.google.com/webstore/detail/tempus/bpdhbpeecmmglmkjfmigehaebpndmceh)
- [Bypass Paywalls Chrome Clean](https://gitlab.com/magnolia1234/bypass-paywalls-chrome-clean)
- [Get Off Those Sites](https://github.com/grimsteel/get-off-those-sites): You predict the expected time on your site and it'll turn it black and white after that time, and also log the actual amount of time that you spend on that site.
- [Privacy.com](https://app.privacy.com/join/QCDWQ): Make one-time burner credit cards with limits. I use this for automatically billing subscriptions, or sketchy sites that need credit cards to use them, since then I don't need to remember to cancel.
- Tactiq: Takes automatic transcripts of any Google Meet or Zoom meeting in browser along with AI actionables and summaries.
- ShareGPT: Share your ChatGPT conversations.
- [Bitwarden](https://bitwarden.com/): Free and open-source password manager. Has pretty good UI and integrations, and one-click switching from any other password manager. Has never been hacked.

# Settings
```
echo $'set -s escape-time 0\nset-option -g default-shell /bin/bash\nunbind Up     \nunbind Down   \nunbind Right   \nunbind Left  \nbind Up run-shell "if [ $(tmux display-message -p \'#{pane_at_top}\') -ne 1 ]; then tmux select-pane -U; fi"\nbind Down run-shell "if [ $(tmux display-message -p \'#{pane_at_bottom}\') -ne 1 ] ; then tmux select-pane -D; fi"\nbind Right run-shell "if [ $(tmux display-message -p \'#{pane_at_right}\') -ne 1 ]; then tmux select-pane -R; fi"\nbind Left run-shell "if [ $(tmux display-message -p \'#{pane_at_left}\') -ne 1 ]; then tmux select-pane -L; fi"' > ~/.tmux.conf # Makes escape zero delay and has 'ctrl b + arrow' end at an edge pane
echo 'setw -g aggressive-resize on' >>~/.tmux.conf
echo "set-option -g history-limit 5000" >> ~/.tmux.conf # Increase tmux scrollback buffer size
echo "set -g @plugin 'tmux-plugins/tmux-resurrect'" >> ~/.tmux.conf 
echo "set -g @plugin 'tmux-plugins/tmux-continuum'" >> ~/.tmux.conf  # Allows tmuxes to autosave every 15 min and resurrect on a system restart, persisting them
tmux source-file ~/.tmux.conf # If in tmux
echo $'HISTSIZE=20000\nHISTFILESIZE=20000' > ~/.bashrc # More history in bashrc
source ~/.bashrc
echo $'filetype plugin indent on\nfiletype plugin on\nsyntax on\n:inoremap jj <Esc>\n' > ~/.vimrc
echo $'"\\e[A": history-search-backward\n"\\e[B": history-search-forward\nset completion-ignore-case on' > ~/.inputrc
echo $'bind -f ~/.inputrc' > ~/.bash_profile
bind -f ~/.inputrc
sudo chmod 666 /etc/ssh/sshd_config
```

Then, manually edit your vim configs to keep SSH configs alive.

```
vim /etc/ssh/sshd_config # Replace this by mosh?
  > CountAliveInterval 120
```

# Mac Only
```
brew install readline # Allows parsing of inputrc
brew link --force readline # Visible to bash

# defaults write -g InitialKeyRepeat -int 8 # normal minimum is 15 (225 ms)
# defaults write -g KeyRepeat -int 4 # normal minimum is 2 (30 ms)

mkdir ~/bash_histories_with_outputs
echo $'test "$(ps -ocommand= -p $PPID | awk \'{print $1}\')" = \'script\' || (script -F $HOME/bash_histories_with_outputs/$(date +"%d-%b-%y_%H-%M-%S")_shell.log)' >> ~/.bashrc
source ~/.bashrc
vi ~/.zshrc # Copy .zshrc in

```

# Ubuntu Only
```
mkdir ~/bash_histories_with_outputs
echo $'test "$(ps -ocommand= -p $PPID | awk \'{print $1}\')" = \'script\' || (script -f $HOME/bash_histories_with_outputs/$(date +"%d-%b-%y_%H-%M-%S")_shell.log)' >> ~/.bashrc
echo "PS1='\[\033[1;36m\]\u\[\033[1;31m\]@\[\033[1;32m\]\h:\[\033[1;35m\]\w\[\033[1;31m\]\$\[\033[0m\] '" >> ~/.bashrc
source ~/.bashrc

# kbdrate -r 16.0 -d 6

gsettings set org.gnome.desktop.interface clock-format 12h # 12 hour time
chmod 777 ~/.bash_history # To persist history
vi ~/.zshrc # Copy .zshrc in
``` 

``` 
sudo apt install libusb-dev # Ergodex EZ https://github.com/zsa/wally/wiki/Linux-install
```


# Canonical tmux.conf
```
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

```
set -s escape-time 0
set-option -g default-shell /bin/bash
unbind Up
unbind Down
unbind Right
unbind Left
bind Up run-shell "if [ $(tmux display-message -p '#{pane_at_top}') -ne 1 ]; then tmux select-pane -U; fi"
bind Down run-shell "if [ $(tmux display-message -p '#{pane_at_bottom}') -ne 1 ] ; then tmux select-pane -D; fi"
bind Right run-shell "if [ $(tmux display-message -p '#{pane_at_right}') -ne 1 ]; then tmux select-pane -R; fi"
bind Left run-shell "if [ $(tmux display-message -p '#{pane_at_left}') -ne 1 ]; then tmux select-pane -L; fi"
# List of plugins
set -g @plugin 'tmux-plugins/tmux-resurrect'
set -g @plugin 'tmux-plugins/tmux-continuum'
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'

# Other examples:
# set -g @plugin 'github_username/plugin_name'
# set -g @plugin 'git@github.com:user/plugin'
# set -g @plugin 'git@bitbucket.com:user/plugin'

# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run '~/.tmux/plugins/tpm/tpm'
```

# Other


Staples Wrist Rest
Add [this block list for Twitter ads](https://raw.githubusercontent.com/robonxt/CleanYourTwitter/master/CleanYourTwitter.txt) to your Chrome uBlock origin

### Force high quality audio on bluetooth headphones
This doesn't seem to work anymore. At one point, these might have kept the audio high quality when a mic was connected: https://gist.github.com/dvf/3771e58085568559c429d05ccc339219

# Deprecated
https://bahoom.com/hyperswitch
- Enable cross-window and cross-screen on first settings pane
- Alt+tab by window instead of application in Mac
- Not cross-window, orders of windows messed up


