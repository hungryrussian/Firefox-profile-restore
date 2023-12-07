# https://github.com/hungryrussian
# 9/2022
# Firefox Profile Restore script
# Checks if there's an old Firefox profile and restores the old bookmarks and
# saved passwords to the current profile. Makes a backup of each profile before
# making changes.

cd $env:APPDATA
cd Mozilla\Firefox\Profiles
$profilePath = Get-Location

Try {
    $profiles = Get-ChildItem -Path $profilePath | Where-Object {$_.PSIsContainer} | Sort-Object LastWriteTime -Descending | Select-Object -First 2
}
Catch {
    Write-Host "Only one Firefox profile exists!"
    Pause
    Exit
}

$newProfileFolder = $profiles[0].Name
$oldProfileFolder = $profiles[1].Name

Copy-Item -Path $profilePath\$oldProfileFolder -Destination $profilePath\$oldProfileFolder.old -Recurse
Copy-Item -Path $profilePath\$newProfileFolder -Destination $profilePath\$newProfileFolder.old -Recurse

Try {
    Copy-Item -Path $profilePath\$oldProfileFolder\places.sqlite -Destination $profilePath\$newProfileFolder\places.sqlite
    Copy-Item -Path $profilePath\$oldProfileFolder\favicons.sqlite -Destination $profilePath\$newProfileFolder\favicons.sqlite
    Copy-Item -Path $profilePath\$oldProfileFolder\key4.db -Destination $profilePath\$newProfileFolder\key4.db
    Copy-Item -Path $profilePath\$oldProfileFolder\logins.json -Destination $profilePath\$newProfileFolder\logins.json
    Copy-Item -Path $profilePath\$oldProfileFolder\permissions.sqlite -Destination $profilePath\$newProfileFolder\permissions.sqlite
    Copy-Item -Path $profilePath\$oldProfileFolder\formhistory.sqlite -Destination $profilePath\$newProfileFolder\formhistory.sqlite
    Copy-Item -Path $profilePath\$oldProfileFolder\cookies.sqlite -Destination $profilePath\$newProfileFolder\cookies.sqlite
    Copy-Item -Path $profilePath\$oldProfileFolder\handlers.json -Destination $profilePath\$newProfileFolder\handlers.json

    Remove-Item -Path $profilePath\$newProfileFolder\compatibility.ini

    Write-Host "All files copied successfully!"
}

Catch {
    Write-Host "An error occurred during file copy"
}

Pause
Exit