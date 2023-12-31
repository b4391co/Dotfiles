#!/usr/bin/env sh

# Check if wlogout is already running
if pgrep -x "wlogout" > /dev/null
then
    # Kill wlogout
    pkill -x "wlogout"
    exit 0
fi

# set file variables
wLayout="$HOME/.config/wlogout/layout_2"
wlTmplt="$HOME/.config/wlogout/style_2.css"

if [ ! -f $wLayout ] || [ ! -f $wlTmplt ] ; then
    echo "ERROR: Style $1 not found..."
    exit 1;
fi

# detect monitor y res
x_mon=$( cat /sys/class/drm/*/modes | head -1  ) 
y_mon=$( echo $x_mon | cut -d 'x' -f 2 )
x_mon=$( echo $x_mon | cut -d 'x' -f 1 )

# scale config layout and style
case $1 in
    1)  wlColms=6
        export mgn=$(( y_mon * 28 / 100 ))
        export hvr=$(( y_mon * 23 / 100 )) ;;
    2)  wlColms=2
        export x_mgn=$(( x_mon * 35 / 100 ))
        export y_mgn=$(( y_mon * 25 / 100 ))
        export x_hvr=$(( x_mon * 32 / 100 ))
        export y_hvr=$(( y_mon * 20 / 100 )) ;;
esac

# scale font size
export fntSize=$(( y_mon * 2 / 100 ))

# detect gtk system theme
export gtkThm=`gsettings get org.gnome.desktop.interface gtk-theme | sed "s/'//g"`
export csMode=`gsettings get org.gnome.desktop.interface color-scheme | sed "s/'//g" | awk -F '-' '{print $2}'`
export BtnCol=`[ "$csMode" == "dark" ] && ( echo "black" ) || ( echo "white" )`
export BtnBkg=`[ "$csMode" == "dark" ] && ( echo "color" ) || ( echo "bg" )`
export WindBg=`[ "$csMode" == "dark" ] && ( echo "rgba(0,0,0,0.5)" ) || ( echo "rgba(255,255,255,0.6)" )`
export wbarTheme="$HOME/.config/waybar/themes/${gtkThm}.css"

# eval hypr border radius
hyprTheme="$HOME/.config/hypr/themes/${gtkThm}.conf"
hypr_border=`awk -F '=' '{if($1~" rounding ") print $2}' $hyprTheme | sed 's/ //g'`
export active_rad=$(( hypr_border * 5 ))
export button_rad=$(( hypr_border * 8 ))

# eval config files
wlStyle=`envsubst < $wlTmplt`

# launch wlogout
wlogout -b $wlColms -c 0 -r 0 -m 0 --layout $wLayout --css <(echo "$wlStyle") --protocol layer-shell

