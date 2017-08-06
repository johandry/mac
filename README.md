# OSX Setup
Script to automate the setup of my Mac's

- [Installation](#installation)
- [Execution](#execution)
- [Manual Settings](#manual-settings)
	- [System Preferences](#system-preferences)
	- [Editors Preferences](#editors-preferences)
- [Maintenance](#maintenance)
- [TODO](#todo)

## Installation
To install just clone the project to any location

```
git clone https://github.com/johandry/OSX_Setup.git
```

Or, if ``git`` is not installed, [download](https://github.com/johandry/OSX_Setup/archive/master.zip) and unzip the project to any location.

## Execution
Move to the directory of the cloned project and execute ``setup.sh``.

```
cd OSX_Setup
./setup.sh
```

This will open the App Store application to install the required applications, this may be a semi-automated process. It will install automatically another list of applications using ``brew`` mainly. Then finalize with a list of applications that need to be installed manually (so far, just one: Google Chrome).

The script will also execute other tasks such as create a Workspace directory, customize the shell theme, etc...

## Manual Settings
Other manual settings may be needed after the execution of the script.
### System Preferences
  1. Trackpad settings: Go to ``System Preferences -> Trackpad``, then ``Point & Click`` and ``Scroll & Zoom`` to modify the Trackpad settings.
  1. Modify the Dock size: Go to ``System Preferences -> Dock`` and adjust the Size.
  1. Finder Settings: Open ``Finder``, then:
    * Go to preferences (&#8984; + ,) and select/deselect the items as desired.
    * Go to ``General`` tab and select your home in ``New Finder windows show``.
    * In the sidebar order the items and add ``Workspace``.
  1. In the menu bar, right click on the battery and select ``Show Percentage``.

### Editors Preferences
  1. Open ``Atom``, go to preferences (&#8984; + ,) and install the require packages such as:
    * aligner
    * aligner-puppet
    * atom-beautify
    * compare-files
    * git-{plus, status}
    * language-{docker, puppet}
    * markdown-{folder, preview-plus, toc}
  1. Open ``Sublime Text`` to:
    * Install ``Package Control``. Instructions [here](https://packagecontrol.io/installation)
    * Modify some settings like:
      * tab space
    * Install the required packages such as:


## Maintenance
To modify the list of applications to install or modify the script, first clone (see above) or pull the project.

```
cd OSX_Setup
git pull https://github.com/johandry/OSX_Setup.git
```

There is a file per Mac named with the hostname of the computer and ``.cnf`` as extension. i.e. ``Johandrys-MacBook-Pro.local.cnf``. This file will list, in a bash array variable ``applications``, all the applications that are required to be installed. Comments starting with ``#`` are allow.

Example:
```
declare -a applications=(
# Development
  XCode
# Office
  Keynote Numbers Pages
)
```

When there is a new application to add, first it need to be included in the ``config.sh`` bash script. Every application have a line with a list/array variable. The content will be:

```
Name=( type 'App Name' 'validation file' 'command or url' [ending command])
```
Where:
  * Name: Is the variable name, usualy is the same of 'App Name'
  * type: There are 2 types of applications:
    * app_store: This is an application that will be installed using the App Store. The process is semi-automated as the user need to click on 'Get' and 'Install'
    * cmd: This application will be installed as a command. Most of the time using brew but not always.
  * App Name: This is the name of the applications to use in the _HOSTNAME_.cnf file
  * validation file: This is a file or directory that will exists once the application is installed. If this file/directory is found the applications won't be instaled.
  * command or url:
    * If the application is of type 'app_store' then a URL is required with the link of the application in the App Store. Example: ``itunes.apple.com/us/app/xcode/id497799835?mt=12``.
    * If the application is of type 'cmd' then this have to be the command to install the application. Usualy it is a brew command but could be a complex one. Example: ``brew cask install dropbox``
  * ending command: It is optional and it is a command to execute once the application is installed. It could be to print a message of something that have to be done (i.e. configuration).

Sometimes an specific action is required, for this situations a function can be created in ``functions.sh`` and called from ``setup.sh``. In this case there is ``customize_oh_my_zsh`` and ``install_google_chrome``.

In the ``files`` directory are files that will be copied to the computer.

## TODO
- [ ] Make the 'App Name' disapear and use the variable Name.
- [ ] Automate as much as possible the manual settings.
- [ ] Evaluate the use of Puppet, Chef or Ansible instead of a Bash script.
