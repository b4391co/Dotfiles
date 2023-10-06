
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git colorize)
ZSH_COLORIZE_STYLE="colorful"
source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

pkill kwalletd5

#source ~/powerlevel10k/powerlevel10k.zsh-theme
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
source ~/.zsh/sudo.plugin.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export TERM=xterm-256color
export LIBVIRT_DEFAULT_URI=qemu:///system
export PATH="$PATH:/home/username/.local/bin"
nitrogen --restore
sleep 0,1
clear

startvar=`cat ~/.startcounter`
# 
if [ $startvar -eq 0 ]
then
#   logger "[ psync ] Comienza la sincronizacion"
#   if [ `xrandr | grep DP-4 | awk '{print $2}'` = "connected" ]
#   then
#     if [ `xrandr | grep HDMI | awk '{print $2}'` = "connected" ]
#     then
#       xrandr --output DP-4 --primary --mode 1920x1080 --rate 244.00 --output HDMI-0 --mode 1920x1080 --left-of DP-4  
#       ~/.config/polybar/launch.sh &
#     else
#       xrandr --output DP-4 --primary --mode 1920x1080 --rate 244.00
#       ~/.config/polybar/launch.sh &
#     fi
#   fi
  echo "1" > ~/.startcounter
  ~/.config/polybar/launch.sh &
#   HOST1=8.8.8.8
#   ping -c1 $HOST1 1>/dev/null 2>/dev/null #Chech ip
#   SUCCESS1=$?
#   if [ $SUCCESS1 -eq 0 ]
#   then
#     logger "[ psync ] Ping con google OK"
#     HOST2=10.144.199.1
#     ping -c1 $HOST2 1>/dev/null 2>/dev/null #Chech ip
#     SUCCESS2=$?
#     if [ $SUCCESS2 -eq 0 ]
#     then
#       logger "[ psync ] Ping con rpi OK"
#       sshfs -o IdentityFile=~/.ssh/id_rsa 10.144.199.1:/var/www/html/hugo/content ~/rpi &
#       rclone mount drive: ~/drive &
#     else
#       logger "[ psync ] Ping con rpi FAIL"
#       wg-quick down rpi0
#       rclone mount drive: ~/drive &
#     fi
#   else
#     logger "[ psync ] Ping con google FAIL"
#   fi
fi

function target(){
    ip_address=$1
    machine_name=$2
    echo "$ip_address $machine_name" > ~/.config/polybar/scripts/target
    export T=$ip_address
}
source '/usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme'

fastfetch

# ALIAS
alias ll='lsd -lh --group-dirs=first'
alias la='lsd -a --group-dirs=first'
alias l='lsd --group-dirs=first'
alias lla='lsd -lha --group-dirs=first'
alias ls='lsd --group-dirs=first'
alias lr='ll -R'
alias rmf='rm -rfv' 
alias whatip='curl https://ipinfo.io/ip' 
alias casa='xfreerdp /v:192.168.1.5 /u:USER@MAIL /cert-ignore /dynamic-resolution +auto-reconnect +clipboard +home-drive'
alias gitb='git config --global user.name "username" ; git config --global user.email username@proton.me ; git config --list'
alias gitc='git config --global user.name "!!!OTHERUSER!!!" ; git config --global user.email !!!OTHERUSER@MAIL!!! ; git config --list'
alias copy='xclip -sel clip'
alias wifiscan='nmcli dev wifi'
alias battery="acpi | awk '{print $4}' | awk -F ',' '{print $1 }'"
alias img="wezterm imgcat"
alias sgns="sudo brctl addbr virbr0; sudo ip link set virbr0 up"
alias p="python"
alias p2="python2"
alias msf="msfconsole"
alias windows="vboxmanage startvm WinDev2303Eval"
alias kali="docker start -i `docker ps -a | grep kali-linux | awk '{print $1}'`"
alias zsh0="echo '0' > ~/.startcounter ; zsh;"
alias nmapt="sudo nmap -n -PN -sS -sC -sV -p- "
