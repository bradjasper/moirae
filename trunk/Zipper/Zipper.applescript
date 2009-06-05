-- Zipper.applescript
-- Zipper

--  Created by Joseph Subida on 6/4/09.
--  Copyright 2009 University of Illinois Champaign-Urbana. All rights reserved.

property username : missing value

-- Clicked on one of the three buttons
on clicked theObject
	set objectsName to name of theObject as string
	
	if objectsName is "zipButton" then
		-- Zip Button: zip up log folder and place it on the desktop
		set visible of progress indicator "spinner" of window "window" to true
		start progress indicator "spinner" of window "window"
		set zipCommand to "zip -r ~/Desktop/" & username & "_ClothoZipped ~/Library/Logs/Discipline"
		do shell script zipCommand
		display alert "Folder successfully zipped!"
		set visible of progress indicator "spinner" of window "window" to false
		set enabled of button "zipButton" of window "window" to false
		
	else if objectsName is "uploadButton" then
		-- Upload Button: open up Safari with the provided link
		tell application "Safari"
			make new document at end of documents
			set URL of document 1 to "http://tapestry.cs.illinois.edu/submit.php"
		end tell
		set enabled of button "uploadButton" of window "window" to false
		
	else if objectsName is "deleteButton" then
		-- Delete Button: delete entire log folder
		do shell script "rm -r ~/Library/Logs/Discipline"
	end if
	
	-- Once the Zip and Upload buttons have been pressed, assuming
	-- everything was done, then enable the delete button
	if enabled of button "zipButton" of window "window" is false then
		if enabled of button "uploadButton" of window "window" is false then
			set enabled of button "deleteButton" of window "window" to true
		end if
	end if
	
end clicked

-- Window opened
on opened theObject
	set theReply to display dialog "Enter username:" attached to window "window" default answer "" buttons {"OK"} default button "OK"
end opened

-- Username dialog finished
on dialog ended theObject with reply withReply
	set username to text returned of withReply
	if username is "" then
		display alert "Please enter a valid username"
		displayAgain()
	end if
end dialog ended

-- On load MainMenu nib
on awake from nib theObject
	set visible of progress indicator "spinner" of window "window" to false
end awake from nib

-- If username field is blank, display the username dialog again
on displayAgain()
	set theReply to display dialog "Enter username:" attached to window "window" default answer "" buttons {"OK"}
end displayAgain