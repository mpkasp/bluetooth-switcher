-- Set the property below to the name of your bluetooth device
property bluetoothDeviceName : "\"Apple Keyboard\""

property displayCount : 1
property tempDisplayCount : 1

repeat
	countDisplays()
	-- log "Display count: " & displayCount & " last: " & tempDisplayCount
	if displayCount is greater than tempDisplayCount then
		displayConnected()
	else if displayCount is less than tempDisplayCount then
		displayDisconnected()
	end if
	copy displayCount to tempDisplayCount
	delay 2
end repeat

on displayConnected()
	do shell script "/usr/local/bin/blueutil --connect " & bluetoothDeviceName
end displayConnected

on displayDisconnected()
	do shell script "/usr/local/bin/blueutil --disconnect " & bluetoothDeviceName
end displayDisconnected

on countDisplays()
	tell application "Image Events"
		set theDisplays to count of displays
	end tell
	set displayCount to theDisplays
end countDisplays