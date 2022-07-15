#!/bin/bash
#
# This script will automatically install and set up matchbox keyboard.
# Please make sure you have internet connection before running this.
# Update: 19/05/2021  - IA
# 

echo "Preparing system"
echo "Checking for updates"
sudo apt-get update

echo "The script will now install matchbox keyboard"
sudo apt-get install matchbox-keyboard -y

echo "Install shared libraries for matchbox-keyboard (optional)"
sudo apt-get install libmatchbox1 -y

echo "Creating toggle file..."
sleep 1
echo "#!/bin/bash" >> /usr/bin/toggle-matchbox-keyboard.sh
echo "	#This script toggle the virtual keyboard" >> /usr/bin/toggle-matchbox-keyboard.sh
echo " " >> /usr/bin/toggle-matchbox-keyboard.sh
echo "	PID=`pidof matchbox-keyboard`" >> /usr/bin/toggle-matchbox-keyboard.sh
echo "	if [ ! -e $PID ]; then" >> /usr/bin/toggle-matchbox-keyboard.sh
echo " 	   killall matchbox-keyboard" >> /usr/bin/toggle-matchbox-keyboard.sh
echo "	else" >> /usr/bin/toggle-matchbox-keyboard.sh
echo "	   matchbox-keyboard&" >> /usr/bin/toggle-matchbox-keyboard.sh
echo "	fi" >> /usr/bin/toggle-matchbox-keyboard.sh
echo "complete!"
sleep 2

sudo chmod +x /usr/bin/toggle-matchbox-keyboard.sh

echo "Creating desktop file..."
cat > /usr/share/applications/toggle-matchbox-keyboard.desktop <<EOF

[Desktop Entry]
Name=Toggle Matchbox Keyboard
Comment=Toggle Matchbox Keyboard
Exec=toggle-matchbox-keyboard.sh
Type=Application
Icon=matchbox-keyboard.png
Categories=Panel;Utility;MB
X-MB-INPUT-MECHANISM=True

EOF
echo "complete!"
sleep 2

#echo "Now you need to add the following in the launchbar:"
#echo "   id=toggle-matchbox-keyboard.desktop "
#while true; do
#   echo "OK, ready? (Y/n)"
#   read answer
#
#   if (($answer == "Y") || ($answer == "y")); then
#      nano ~/.config/lxpanel/LXDE-pi/panels/panel
#   else if (($answer == "N") || ($answer == "n")); then
#      break
#   else
#      echo "Your answer needs to be 'Y' or 'N'./n"
#done

echo "Setting up icon in the launcher"
cat > home/pi/.config/lxpanel/LXDE-pi/panels/panel <<EOF
id=toggle-matchbox-keyboard.desktop
EOF
echo "SETUP COMPLETE!"

exit