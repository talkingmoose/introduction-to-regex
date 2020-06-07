#!/bin/sh

# wait until the Dock process has started
while [[ "$setupProcess" = "" ]]
do
	echo "Waiting for Dock"
	setupProcess=$( /usr/bin/pgrep "Dock" )
    sleep 3
done

sleep 3

# get currently logged in user
currentUser=$( /usr/bin/stat -f "%Su" /dev/console )

echo "Current user is $currentUser"

# prompt current user to choose a site
theCommand='choose from list {"Ashville (AVL)", "Belfast (BFS)", "Bangalore (BLR)", "Chicago (CHI)", "Guangzhou (GZH)", "Melbourne (MLB)", "Santa Barbara (SBA)", "Sydney (SYD)"} with title "Rename Computer" with prompt "Choose a site..." multiple selections allowed false empty selection allowed false'
chosenSite=$( /bin/launchctl asuser "$currentUser" sudo -iu "$currentUser" /usr/bin/osascript -e "$theCommand" )

# if the current user cancels the dialog, stop
if [ "$chosenSite" = "false" ]; then
	echo "Choose site prompt canceled. Stopping script."
	exit 1
fi

siteCode=$( /usr/bin/awk -F "[()]" '{ print $2 } ' <<< "$chosenSite" )

echo "Choosing site \"$chosenSite\""

# prompt for asset tag
while [[ "$assetTag" = "" ]];
do
	theCommand="display dialog \"Asset tag...\" default answer \"\" with title \"Rename Computer\" buttons {\"Stop\", \"OK\"} default button {\"OK\"} with icon file posix file \"/System/Library/CoreServices/Finder.app/Contents/Resources/Finder.icns\""
	results=$( /bin/launchctl asuser "$currentUser" sudo -iu "$currentUser" /usr/bin/osascript -e "$theCommand" )
	
	theButton=$( echo "$results" | /usr/bin/awk -F "button returned:|," '{print $2}' )
	assetTag=$( echo "$results" | /usr/bin/awk -F "text returned:" '{print $2}' )
    
    if [ "$theButton" = "Stop" ]; then
    	echo "Asset tag prompt canceled. Stopping script."
        exit 1
    fi
done

echo "Asset tag is \"$assetTag\""

# set computer name
/usr/local/jamf/bin/jamf setComputerName -name "${siteCode}-MAC-${assetTag}" -target /
echo "Setting ComputerName to ${siteCode}-MAC-${assetTag}"

# update Jamf Pro inventory with new name - do not use current policy's update inventory method
echo "Updating Jamf Pro inventory"
/usr/local/jamf/bin/jamf recon

exit 0