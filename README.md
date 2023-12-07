# Firefox-profile-restore
Restores passwords and bookmarks from an older Firefox profile after an update

On a terminal server, Firefox can allow normal users to install updates. If another user has Firefox open while the update is installed, it creates a profile version mismatch and forces the other user to create a new, empty Firefox profile when they relaunch Firefox. This script checks for the existance of an old profile, backs up the old and new profiles with a .old extension on the folder, and then copies the user's bookmarks, history, and saved passwords to the new profile.
Firefox must have the new profile created already. The target profile with the bookmarks must be the next oldest profile.

Run from WIN+R with the following command:
powershell.exe -noexit C:\_software\firefoxprofilerestore.ps1
