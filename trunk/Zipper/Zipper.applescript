-- Zipper.applescript
-- Zipper

--  Created by Joseph Subida on 6/4/09.
--  Copyright 2009 University of Illinois Champaign-Urbana. All rights reserved.

on clicked theObject
	
	set objectsName to name of theObject as string
	
	if objectsName is "zipButton" then
		set visible of progress indicator "spinner" of window 1 to true
		start progress indicator "spinner" of window 1
		set desktopPath to "~/Desktop"
		do shell script "zip -r ~/Desktop/DisciplineZipped ~/Library/Logs/Discipline"
		display alert "Folder successfully zipped!"
		set visible of progress indicator "spinner" of window 1 to false
		set enabled of button "zipButton" of window 1 to false
	else if objectsName is "uploadButton" then
		tell application "Safari"
			make new document at end of documents
			set URL of document 1 to "http://tapestry.cs.illinois.edu/submit.php"
		end tell
		set enabled of button "uploadButton" of window 1 to false
	else if objectsName is "deleteButton" then
		do shell script "rm -r ~/Library/Logs/Discipline"
	end if
	
	if enabled of button "zipButton" of window 1 is false then
		if enabled of button "uploadButton" of window 1 is false then
			set enabled of button "deleteButton" of window 1 to true
		end if
	end if
	
end clicked

on awake from nib theObject
	set visible of progress indicator "spinner" of window 1 to false
end awake from nib
