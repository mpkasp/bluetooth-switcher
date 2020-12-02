property displayCount : missing value
property tempDisplayCount : missing value
property bluetoothDeviceName : "Apple Keyboard"

countDisplays()

repeat
	repeat until displayCount is greater than 1
		countDisplays()
	end repeat
	displayConnected()
	countDisplays()
	copy displayCount to tempDisplayCount
	repeat until tempDisplayCount is not equal to displayCount
		countDisplays()
	end repeat
	copy displayCount to tempDisplayCount
	if tempDisplayCount is greater than displayCount then
		displayConnected()
	else if tempDisplayCount is equal to displayCount then
		displayDisconnected()
	end if
end repeat

on displayConnected()
	-- The Following Lines Will Execute When An Additional Display Is Connected
	-- Replace The Following Code With Whatever Actions You Choose
	-- OR use the "run script" command as in the sample below
	-- set theScript to (path to desktop as text) & "whatever.scpt"
	-- set runScript to run script alias theScript
	connectBluetoothDevice(bluetoothDeviceName)
end displayConnected

on displayDisconnected()
	-- The Following Lines Will Execute When A Display Is Disconnected
	-- Replace The Following Code With Whatever Actions You Choose
	-- OR use the "run script" command as in the sample below
	-- set theScript to (path to desktop as text) & "whatever.scpt"
	-- set runScript to run script alias theScript
	disconnectBluetoothDevice(bluetoothDeviceName)
end displayDisconnected

on countDisplays()
	tell application "Image Events"
		set theDisplays to count of displays
	end tell
	set displayCount to theDisplays
	delay 2 -- How Often To Check How Many Connected Monitors.. In Seconds
end countDisplays

on connectBluetoothDevice(bluetoothDeviceName)
	activate application "SystemUIServer"
	tell application "System Events"
		tell process "SystemUIServer"
			-- Working CONNECT Script.  Goes through the following:
			-- Clicks on Bluetooth Menu (OSX Top Menu Bar)
			--    => Clicks on SX-991 Item
			--      => Clicks on Connect Item
			set btMenu to (menu bar item 1 of menu bar 1 whose description contains "bluetooth")
			tell btMenu
				click
				tell (menu item bluetoothDeviceName of menu 1)
					click
					if exists menu item "Connect" of menu 1 then
						click menu item "Connect" of menu 1
						return "Connecting..."
					else
						click btMenu -- Close main BT drop down if Connect wasn't present
						return "Connect menu was not found, are you already connected?"
					end if
				end tell
			end tell
		end tell
	end tell
end connectBluetoothDevice

on disconnectBluetoothDevice(bluetoothDeviceName)
	activate application "SystemUIServer"
	tell application "System Events"
		tell process "SystemUIServer"
			-- Working CONNECT Script.  Goes through the following:
			-- Clicks on Bluetooth Menu (OSX Top Menu Bar)
			--    => Clicks on SX-991 Item
			--      => Clicks on Connect Item
			set btMenu to (menu bar item 1 of menu bar 1 whose description contains "bluetooth")
			tell btMenu
				click
				tell (menu item bluetoothDeviceName of menu 1)
					click
					if exists menu item "Disconnect" of menu 1 then
						click menu item "Disconnect" of menu 1
						return "Disconnecting..."
					else
						click btMenu -- Close main BT drop down if Connect wasn't present
						return "Disconnect menu was not found, are you already connected?"
					end if
				end tell
			end tell
		end tell
	end tell
end disconnectBluetoothDevice