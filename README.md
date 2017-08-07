# Mac OS X Setup
Script to automate the setup of my Mac's

- [Quick Start](#quick-start)
- [Manual System Preferences](#manual-system-preferences)
- [Development & Maintenance](#development-and-maintenance)

## Quick Start

The only requirement to setup your Mac is to login to the Apple Store with your Apple ID.

Clone the project to any location, i.e. `/tmp`

	cd /tmp
	git clone https://github.com/johandry/OSX_Setup.git

Or, if `git` is not installed, [download](https://github.com/johandry/OSX_Setup/archive/v2.0.zip) and unzip the project.
Go to the directory of the cloned project and execute `setup.sh`.


	cd OSX_Setup
	./setup.sh

The `setup.sh` script install automatically a list of applications using [Homebrew](https://brew.sh/) and [mas-cli](https://github.com/mas-cli/mas). It will also execute other tasks such as create a Workspace directory, customize the Zsh theme and more.

### Manual System Preferences

  1. *Trackpad settings*: Go to `System Preferences` -> `Trackpad` to modify the Trackpad settings.
  1. *Finder Settings*: Open `Finder`, then:
    * Go to preferences (&#8984; + ,) and select/deselect the items as desired.
    * Go to `General` tab and select your home in `New Finder windows show`.
    * In the sidebar order the items and add `Workspace`.
  1. *Battery Percentage*: In the menu bar, right click on the battery and select `Show Percentage`.

## Development and Maintenance
To modify the list of applications to install or modify the script, first clone (see above) or pull the project.

	cd OSX_Setup
	git pull https://github.com/johandry/OSX_Setup.git

There is a file per Mac named with the hostname, i.e. `Brewfile.Johandrys-MacBook-Pro.local`, and the file `Brewfile.Common` with all the applications every mac should have. Those Brewfiles are required by [Brew Bundle](https://github.com/Homebrew/homebrew-bundle) and they list all the applications to install. Comments starting with `#` are allowed.

You can create a list of installed applications with the command `brew bundle dump`, then move the applications in `Brewfile` to the right `Brewfile.*`

The `setup.sh` script will create a Brewfile that will be saved to `~/.Brewfile` so you can upgrade all the applications at any time with:

	brew bundle -f ~/.Brewfile

It's possible to test the script using Vagrant. Follow these steps to use OSX Setup with Vagrant:

	vagrant up
	vagrant ssh

As mentioned above, you need to login to Apple Store with your Apple ID. Follow these steps at the Vagrant box:

1. Open VirtualBox to show the machine screen.
2. Login with user `vagrant` password `vagrant`
3. Open Apple Store and login with your Apple ID
4. Follow the authentication process, then you can close the screen.

To start over from scratch, execute `vagrant destroy` and start over by running `vagrant up`.
