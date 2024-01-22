pwd=`pwd`
username=`whoami`
selec=0
app=0
t=0
i=0

function logo {
clear
echo "██████╗░░█████╗░███████╗░██████╗░██╗"
echo "██╔══██╗██╔══██╗██╔════╝██╔════╝░██║"
echo "██████╦╝███████║█████╗░░██║░░██╗░██║"
echo "██╔══██╗██╔══██║██╔══╝░░██║░░╚██╗██║"
echo "██████╦╝██║░░██║███████╗╚██████╔╝██║"
echo "╚═════╝░╚═╝░░╚═╝╚══════╝░╚═════╝░╚═╝"
echo ""
echo ""
}
while [ $selec = 0 ]
do
logo
printf "[ + ] ( 1"; if [ $selec = '1' ] ; then printf '*'; fi; printf " ) - Apps\n"
printf "[ + ] ( 2"; if [ $selec = '2' ] ; then printf '*'; fi; printf " ) - Entornos\n"
printf "[ + ] ( X"; if [ $selec = 'X' ] ; then printf '*'; fi; printf " ) - Close\n"
echo ""
printf "―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――"
echo ""
read selec

    while [ $selec = "1" ]
    do
        if [ $T = "T" ]
        then
            i=$((i+1)) 
            app="$i"
            if [ $i = "7" ]
            then
                T=0
                i=0
            fi
        else
            logo
            printf "[ + ] ( 1"; if [ $app = '1' ] ; then printf '*'; fi; printf " ) - Yay , Paru & blackharch \n"
            printf "[ + ] ( 2"; if [ $app = '2' ] ; then printf '*'; fi; printf " ) - apps basicas [yay]\n"
            printf "[ + ] ( 3"; if [ $app = '3' ] ; then printf '*'; fi; printf " ) - Install zsh, omzsh\n"
            printf "[ + ] ( 4"; if [ $app = '4' ] ; then printf '*'; fi; printf " ) - vscode\n"
            printf "[ + ] ( 5"; if [ $app = '5' ] ; then printf '*'; fi; printf " ) - Hacking/Networks [blackarch]\n"
            printf "[ + ] ( 6"; if [ $app = '6' ] ; then printf '*'; fi; printf " ) - Docker\n"
            printf "[ + ] ( 7"; if [ $app = '7' ] ; then printf '*'; fi; printf " ) - Programacion\n"
            printf "[ + ] ( T"; if [ $app = 'T' ] ; then printf '*'; fi; printf " ) - All\n"
            printf "[ + ] ( X"; if [ $app = 'X' ] ; then printf '*'; fi; printf " ) - close\n"
            echo ""
            printf "―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――"
            echo ""
            read app
            T=$app
        fi
        if [ $app = "1" ]
        then
            cd $pwd
            cd /opt
            sudo git clone https://aur.archlinux.org/yay-git.git
            sudo chown -R $username:$username ./yay-git
            cd yay-git
            makepkg --noconfirm --needed -si
            sudo yay -Syu --noconfirm --needed
            mkdir ~/Descargas
            cd ~/Descargas
            sudo pacman -S --needed base-devel --noconfirm --needed
            git clone https://aur.archlinux.org/paru.git
            cd paru
            makepkg --noconfirm --needed -si
            cd $pwd
            # blackarch
            chmod a+x .blackarch/blackarch.sh
            sudo sh .blackarch/blackarch.sh
            cd $pwd
        fi        
        if [ $app = "2" ]
        then
            cd $pwd
            echo ""
            echo ""
            printf "[ + ] ( 1 ) - Instalacion en REAL\n"
            printf "[ + ] ( 2 ) - Instalacion en VM\n"
            echo ""
            read realVM
            sudo pacman -S neovim wezterm net-tools vi lsd vivaldi man xorg-xbacklight --noconfirm --needed
            sudo pacman -S rclone openresolv systemd-resolvconf cron ranger fuse --noconfirm --needed
            sudo pacman -S neofetch sshfs vifm curl htop wget neofetch tree fzf python-pip npm ranger ueberzug ripgrep fd universal-ctags --noconfirm --needed
            yay -S flameshot fastfetch python2 mlocate aur/bat-cat-git --noconfirm --needed
            yay -S wireguard-tools --noconfirm --needed
            sudo systemctl enable --now systemd-resolved.service
            mkdir ~/.config/wezterm
            cp config/wezterm/wezterm.lua ~/.config/wezterm
            mkdir ~/.vifm
            echo "set vicmd=nvim
:view
fileviewer {*.bmp,*.jpg,*.jpeg,*.png,*.gif,*.xpm},<image/*>
  \ wezterm imgcat --width %pw --height %ph %c:p %pd" > ~/.vifm/vifmrc
            git clone https://github.com/XDeadHackerX/NetSoc_OSINT
            cd NetSoc_OSINT
            chmod 777 netsoc_osint.sh
            git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1 && nvim
            git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
            ~/.fzf/install
            if [ $realVM = "2" ]
            then
                sudo pacman -S open-vm-tools --noconfirm --needed
                sudo pacman -S xf86-video-vmware xf86-input-vmmouse --noconfirm --needed
                sudo systemctl enable --now vmtoolsd
                sudo pacman -S virtualbox-guest-iso --noconfirm --needed
                sudo mount /usr/lib/virtualbox/additions/VboxGuestAdditions.iso /mnt
                sudo sh /mnt/VBoxLinuxAdditions.run
                sudo umount /mnt
            fi
        fi  
        if [ $app = "3" ]
        then    
            cd $pwd
            sudo pacman -S zsh --noconfirm --needed
            sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
            cp p10k.zsh ~/.p10k.zsh
            cp zshrc ~/.zshrc
            echo '# Auto-completion
[[ $- == *i* ]] && source "/usr/share/fzf/completion.zsh" 2> /dev/null

# Key bindings
source "/usr/share/fzf/key-bindings.zsh"' >> ~/.fzf.zsh
            
            echo "@reboot echo "0" > ~/.startcounter
0 */6 * * * /usr/bin/yay -Syu --noconfirm" > /var/spool/cron/$username

            yay -S --noconfirm --needed zsh-theme-powerlevel10k-git
            sudo pacman -S powerline-common awesome-terminal-fonts --noconfirm --needed
            yay -S --noconfirm --needed ttf-meslo-nerd-font-powerlevel10k
            sed -i "s/username/$username/g" ~/.zshrc
            git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
            git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git ~/.zsh/zsh-autocomplete
            git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
            wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/sudo/sudo.plugin.zsh -P ~/.zsh
            cd $pwd
        fi
        if [ $app = "4" ]
        then
            yay -S --noconfirm aur/visual-studio-code-bin           
        fi
        if [ $app = "X" ]
        then
            selec=0 
        fi
        if [ $app = "5" ]
        then
            mkdir ~/apps
            cd ~/apps

            # Utilidades de kali Completa
            sudo pacman -S --noconfirm --needed aircrack-ng wpscan nmap ace ipv6toolkit exploitdb arp-scan dmitry ike-scan legion maltego netdiscover p0f recon-ng d spiderfoot \
            dnsenum dnsmap dnsrecon dnstracer dnswalk fierce maltego spiderfoot twofi 0trace irpas netmask nbtscan smbmap smtp-user-enum swaks braa ssldump sslh sslscan tlssled \
            arping fping hping3 masscan unicornscan xprobe2 lbd wafw00f lynis nikto dhcpig iaxflood siege t50 cisco-auditing-tool cisco-global-exploiter cisco-ocs cisco-torch \
            copy-router-config yersinia bed siparmyknife spike enumiax iaxflood rtpflood rtpinsertsound rtpmixsound sctpscan sipp burpsuite commix httrack. paros skipfish sqlmap \
            webscarab apache-users cutycapt dirb dirbuster uniscan wfuzz jboss-autopwn joomscan plecost davtest jsql padbuster skipfish whatweb xsser mdb-sql oscanner sidguesser \
            sqldic sqlmap sqlninja tnscmd10g cewl crunch hashcat john medusa ophcrack rainbowcrack rcracki-mt wordlists hydra patator thc-pptp-bruter chntpw cmospwd fcrackzip \
            hashid hash-identifier ophcrack samdump2 sipcrack sucrack smbmap rsmangler statsgen chirp cowpatty fern-wifi-cracker kismet mdk3 mfoc mfterm pixiewps wifite hackrf \
            bluelog blueranger bluesnarfer btscanner redfang spooftooph mfcuk asleap cowpatty eapmd5pass wifi-honey bytecode-viewer clang dex2jar edb-debugger jadx javasnoop \
            radare2 beef sqlmap termineter driftnet ettercap-graphical macchanger mitmproxy netsniff-ng responder wireshark darkstat dnschef dsniff hexinject sslsniff tcpflow \
            rebind sniffjoke sslsplit tcpreplay yersinia backdoor-factory nishang proxychains4 weevely cymothoa sbd laudanum iodine miredo proxytunnel pwnat sslh stunnel4 udptunnel \
            autopsy binwalk chkrootkit foremost galleta hashdeep dc3dd dcfldd extundelete missidentify pst-utils reglookup ddrescue guymager pdfid pdf-parser foremost magicrescue \
            pasco pev recoverjpeg rifiuti rifiuti2 safecopy calpel scrounge-ntfs cutycapt pipal recordmydeskto

            # Red
            yay -S --noconfirm --needed nmap wireshark metasploit burpsuite python-dnsrecon aircrack nfs-utils blackarch/ffuf blackarch/dirb blackarch/autorecon 
            
            # bf hash
            yay -S --noconfirm --needed wordlists hashid rockyou john webshells seclists hashcat hydra medusa hash-identifier 
            sudo wget -O /ush/share/wordlists/rockyou.txt https://github.com/brannondorsey/naive-hashcat/releases/download/data/rockyou.txt
            sudo curl -o /usr/share/webshells/php/p0wny.php https://raw.githubusercontent.com/flozz/p0wny-shell/master/shell.php

            # osint
            yay -S --noconfirm --needed blackarch/sherlock gobuster bind blackarch/osint-spy blackarch/maltego blackarch/h8mail extra/sn0int extra/perl-image-exiftool aur/jexiftoolgui
            pip install pandas requests_futures torrequest netifaces
            git clone https://github.com/i3visio/osrframework.git
            cd osrframework
            python -m venv myenv
            source myenv/bin/activate
            pip install .
            deactivate
            cd ..
            
            #db
            yay -S --noconfirm --needed community/sqlitebrowser blackarch/sqlmap 

            #web
            yay -S --noconfirm --needed brave-bin responder sublist3r dirbuster blackarch/nikto blackarch/whatweb
            pip install -r /usr/share/responder/requirements.txt

            # Forense
            yay -S --noconfirm --needed volatility3

            # Pentesting
            yay -S --noconfirm --needed blackarch/evil-winrm blackarch/windows-binaries aur/peass blackarch/enum4linux blackarch/sqlmap 

            # Privacity
            sudo pacman -S --noconfirm --needed tor torsocks

            # Peas
            peas () {
                mkdir peas 
                cd peas
                wget https://github.com/carlospolop/PEASS-ng/releases/latest/download/linpeas.sh
                wget https://raw.githubusercontent.com/carlospolop/PEASS-ng/master/winPEAS/winPEASps1/winPEAS.ps1
                wget https://raw.githubusercontent.com/carlospolop/PEASS-ng/master/winPEAS/winPEASbat/winPEAS.bat
            }
            if [ -d "$HOME/Documents/" ]
            then
                cd $HOME/Documents/
                peas
            elif [ -d "$HOME/Documentos/" ]
            then   
                cd $HOME/Documentos/
                peas
            fi
            # autorecon
            sudo rm /usr/share/autorecon/autorecon/config.toml
            echo "# Configure regular AutoRecon options at the top of this file.

nmap-append = '-T5'
# verbose = 1
# max-scans = 30

# Configure global options here.
# [global]
# username-wordlist = '/usr/share/seclists/Usernames/cirt-default-usernames.txt'

# Configure plugin options here.
[gobuster]
threads = 50
wordlist = [
        '/usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt'
]" | sudo tee -a /usr/share/autorecon/autorecon/config.toml
            mkdir ~/.config/AutoRecon
            sudo mkdir /root/.config/AutoRecon
            cp /usr/share/autorecon/autorecon/config.toml ~/.config/AutoRecon
            sudo cp /usr/share/autorecon/autorecon/config.toml /root/.config/AutoRecon

            cd ~/apps
            # HackGPT
            #pip install --upgrade pip
            #git clone https://github.com/NoDataFound/hackGPT
            #cd hackGPT
            #yay -S --noconfirm --needed community/python-dotenv
            #pip install -r requirements.txt
            #pip install fade openai gradio inquirer prettytable
            #cd ..

            git clone https://github.com/rthalley/dnspython
            cd dnspython/
            python setup.py install
            cd ..
            rmf dnspython
            pip install dnspython
            sudo pacman -S --noconfirm --needed inetutils

            #TraxOsint
            git clone https://github.com/N0rz3/TraxOsint.git
            cd ./TraxOsint
            pip3 install -r requirements.txt
            cd ..
            #Osintui
            
            if [ ! -f ~/.osintui/config/config.toml ]; then
                cargo install osintui
                mkdir -p ~/.osintui/config/
                touch ~/.osintui/config/config.toml
                echo '[keys]
virustotal = "api_key"
shodan = "api_key"
censys_id = "api_id"
censys_secret = "api_key"' | tee -a ~/.osintui/config/config.toml
            fi
            
            # Greal
            git clone https://github.com/AdonsIzaguirre/GReal
            cd GReal
            pip install -r requirements.txt
            cd ..
        fi
        if [ $app = "6" ]
        then
            cd $pwd 
            yay -S docker  --noconfirm --needed
            yay -S docker-compose  --noconfirm --needed
            sudo usermod -aG docker $USER
            sudo systemctl enable --now docker
        fi
        if [ $app = "7" ]
        then
            cd $pwd 
            # PHP - Composer
            yay -S --noconfirm --needed aur/mongodb-compass extra/composer php-mongodb
        fi
    done
    while [ $selec = "2" ]
    do
        if [ $T = "T" ]
        then
            i=$((i+1)) 
            app="$i"
            if [ $i = "2" ]
            then
                T=0
                i=0
            fi
        else
            logo
            printf "[ + ] ( 1"; if [ $app = '1' ] ; then printf '*'; fi; printf " ) - Awesome [Paru]\n"
            printf "[ + ] ( 2"; if [ $app = '2' ] ; then printf '*'; fi; printf " ) - HyperLand [ no virtual machine ]\n"
            printf "[ + ] ( 3"; if [ $app = '3' ] ; then printf '*'; fi; printf " ) - fonts [yay]\n"
            printf "[ + ] ( T"; if [ $app = 'T' ] ; then printf '*'; fi; printf " ) - All\n"
            printf "[ + ] ( X"; if [ $app = 'X' ] ; then printf '*'; fi; printf " ) - close\n"
            echo ""
            printf "―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――"
            echo ""
            read app
            T=$app
        fi
        if [ $app = "1" ]
        then
            cd $pwd
            echo ""
            echo ""
            printf "[ + ] ( 1 ) - Instalacion en REAL\n"
            printf "[ + ] ( 2 ) - Instalacion en VM\n"
            echo ""
            read realVM
            sudo pacman -S gnome --noconfirm --needed
            paru -S --noconfirm awesome-git
            paru -Sy --noconfirm aur/picom-allusive wezterm rofi acpi acpid acpi_call upower lxappearance-gtk3 \
            jq inotify-tools polkit-gnome xdotool xclip gpick ffmpeg blueman redshift \
            alsa-utils brightnessctl feh maim \
            mpv mpd mpc mpdris2 python-mutagen ncmpcpp playerctl --needed
            
            yay -S --noconfirm --needed aur/picom-animations-git 
            # Instalador
            sudo systemctl enable --now mpd.service
            sudo pacman -S polybar=3.6.3  net-tools nitrogen --noconfirm --needed
            
            # Copias
            cp -r config/* ~/.config
            sudo cp -r .config/awesome/icons/* /usr/share/awesome/themes/default/titlebar
            
            monitorPrincipal=`xrandr | grep connected | awk '{print $1}'`
            sed -i "s/DP-4/$monitorPrincipal/g" ~/.config/polybar/current.ini 
            sed -i "s/DP-4/$monitorPrincipal/g" ~/.config/polybar/workspace.ini 
            if [ $realVM = "2" ]
            then
                mv ~/.config/picomVM ~/.config/picom.conf
                mv ~/.config/polybar/currentVM ~/.config/polybar/current.ini 
                mv ~/.config/polybar/workspaceVM ~/.config/polybar/workspace.ini 
            fi

            
            # Lock
            yay -S i3lock-color  --noconfirm --needed
            git clone https://github.com/Raymo111/i3lock-color.git
            cd i3lock-color
            ./build.sh
            ./install-i3lock-color.sh
            cd ..
            rm -rfv i3lock-color
            git clone https://github.com/meskarune/i3lock-fancy.git
            cd i3lock-fancy
            sudo make install
            cd ..
            rm -rfv i3lock-fancy

            #Rofi
            yay -S --noconfirm --needed rofi-bluetooth
            mkdir -p ~/.config/rofi/themes/
            git clone https://github.com/lr-tech/rofi-themes-collection.git
            cd rofi-themes-collection
            mkdir ~/.config/rofi
            mkdir ~/.config/rofi/themes/
            cp themes/* ~/.config/rofi/themes/
            cd ..
            rm -rfv rofi-themes-collection
        fi
        if [ $app = "2" ] 
        then
            yay -S --noconfirm --needed hyprland dolphin wofi hyprpaper rofi-lbonn-wayland-git waybar swww swaylock-effects-git wlogout nwg-look kvantum qt5ct
            cp config/* ~/.config/ -r
        fi
        if [ $app = "3" ]
        then
            cd $pwd
            yay -S font-manager ttf-iosevka-nerd extra/ttf-jetbrains-mono ttf-victor-mono  ttf-hack-nerd fonts-powerline ttf-iosevka-nerd --noconfirm --needed
            cd /usr/share/fonts
            sudo wget https://download.jetbrains.com/fonts/JetBrainsMono-2.225.zip
            sudo unzip JetBrainsMono-*
            sudo rm JetBrainsMono-*
            sudo wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip
            sudo unzip Hack.zip
            sudo wget https://rubjo.github.io/victor-mono/VictorMonoAll.zip
            sudo unzip VictorMonoAll.zip
            sudo mv VictorMonoAll/TTF/* .
            
            sudo curl -o iosevka.zip https://fontlot.com/downfile?post_id=105610&post_slug=iosevka-font-family&pf_nonce=8b11cb3408
            unzip iosevka.zip
            cd $pwd
            sudo rm -rfv *.ttf EOT OTF TTF WOFF WOFF2 *.zip
        fi
        if [ $app = "X" ]
        then
            selec=0
        fi
    done
    if [ $selec = "x" ]
    then
        selec=-1
    fi
done


