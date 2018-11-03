# Firefox

Clone the project in `/Applications/Firefox`

The original app is located at `/Applications/Firefox/Firefox.app`

- Download Firefox English
- Open `dmg` file
- Backup: drag and drop the old one in `Backup` directoy and copy the content of `Profiles` as well for a backup
- Update: download the new version and simply replace it by a drag & drop from the `dmg` file
- Launch `FireUpdate.app`to update all the launchers with the new version of the app


# Default locations

FYI

- `~/Library/Application Support/Firefox/Profiles`
- `~/Library/Caches/Firefox/Profiles`

Aliases: `Profiles/Default`

Change an icon of an app:

- Get Info
- Drag and Drop the icns file to the first icon (the upper left one, not the big one)


# Launchers

Launchers in the current directory are Automator scripts

1 - `Application receives files and folders as input`

2 - Run AppleScript

```
	-- Add Application path as first argument
	on run {input, parameters}

		set arg0 to path to me
		set output to {arg0} & input

	end run
```

3 - Run Shell Script

```
	apppath="$1"
	appname=$(basename -- "$1")
	profile="${appname%.*}"

	cd $apppath/Contents/$appname
	./Contents/MacOS/firefox-bin -profile "$apppath/../Profiles/$profile/" > /dev/null 2>&1 &
```


# FireManager

`FireManager.app` is also an Automator script with the same steps as `Launchers` except for the step 3

It is use for creating and managing profiles

3 - Run Shell Script

```
	cd $1/../Firefox.app
	./Contents/MacOS/firefox-bin -p &
```


# FireUpdate

`FireUpdate.app` is again an Automator script with the same steps as `Launchers` except for the step 3

It is use to update all the Firefox app included inside each launcher

3 - Run Shell Script

```
	apppath="$1"
	cd $apppath/..

	update_profile_app(){
		local profile=$1
		rm -rf ${profile}.app/Contents/${profile}.app/Contents
		cp -R Firefox.app/Contents ${profile}.app/Contents/${profile}.app/Contents/
	}

	update_profile_app Empty
```


# Create a new profile

- Copy `Empty.app`
- Paste `New.app`
- `Show Package Contents`
- Rename `Contents/Empty.app` to `Contents/New.app`
- Change the icon of both `New.app` and `Contents/New.app`
- Copy `Profiles/Empty`
- New `Profiles/New`
- Check that `prefs.js` and `user.js` are here before first startup.

Note:
- `New.app` is the Automator script launcher
- `Contents/New.app` is the copied Firefox app


# Preferences

Configuration As Doc
- `user.js` to set some default parameters at startup
- `prefs.js` to set some default parameters for first startup

`prefs.js` changed when Firefox closes


# AddOns

## Security

- https://addons.mozilla.org/en-US/firefox/addon/ublock-origin
- https://addons.mozilla.org/en-US/firefox/addon/https-everywhere
- https://addons.mozilla.org/en-US/firefox/addon/decentraleyes
- https://addons.mozilla.org/en-US/firefox/addon/cookie-autodelete

## Search Tool

- https://addons.mozilla.org/en-US/firefox/addon/startpage-https-privacy-search
- https://addons.mozilla.org/en-US/firefox/addon/wikipedia-fr
- https://addons.mozilla.org/en-US/firefox/addon/amazon-fr-1
- https://addons.mozilla.org/en-US/firefox/addon/github
- https://addons.mozilla.org/en-US/firefox/addon/docker-hub
