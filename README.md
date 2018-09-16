# Mac OS X Setup

Script to automate the setup of my Mac's

- [Quick Start](#quick-start)
- [Manual Setup](#manual-setup)
- [Development & Maintenance](#development-and-maintenance)

## Quick Start

1. Login to the Apple Store with your Apple ID

2. Execute:

   ```bash
   curl -fsL http://www.johandry.com/mac/setup.sh | bash
   ```

3. Install manually the applications that failed to install or follow the instructions that an installed program require.

4. Complete the setup following the instructions from the **Manual Setup** section

It may be required to execute again the setup script, update the Mac with Apple Store or maybe restart it.
Pay attention to the output of the script, there may be manual actions required.

## Manual Setup

### Basic Setup

1. Go to **System Preferences**, then **Trackpad** to modify the Trackpad settings.
2. Open **Finder**, go to **Preferences** (&#8984; + ,), then **General** tab. Select your home directory in **New Finder windows show**.
3. Still on Finder Preferences, go to **Sidebar** tab, select/deselect the items as desired
4. Open Fider and in the sidebar, order the items and add **Workspace** and **Sandbox** directories, also the **Cloud Storages** directories.
5. In the menu bar, right click on the battery and select **Show Percentage**.

### Docker

Yes, Docker can be installed with `brew` but, as it's an critial application I prefer to install it manually, so:

1. Download it from [here](https://download.docker.com/mac/stable/Docker.dmg)
   *(It may be required to login first with the DockerHub user)*
2. Install it or [follow the instructions](https://docs.docker.com/docker-for-mac/install/)

### Microsoft Office 365 Home

1. Go to [office service](https://account.microsoft.com/services/office/install)
2. Click on **Install Office** to download the installer

### Google Chrome

Open Google Chrome and login with your user.

In the past the brew install of Chrome caused some problems every time there is a Chrome update. If it happens again, uninstall the brew cask for Chrome and install it manually

```bash
brew cask uninstall
```

Download it from [here](https://www.google.com/chrome/) and install it.

### Terminal and iTerm

1. Open **Terminal**, go to **Preferences** (&#8984; + ,), select **General** tab.
2. Select **Pro** in **New window with profile**
3. Go to **Profiles** tab, select **Pro** as the default one.
4. In the Pro profile, go to the **Window** tab, set **160** in **Columns**, and **48** in **Rows**.

### Manual Download and Install

- NETGEAR Genie: Download it from [here](http://updates1.netgear.com/netgeargenie/mac/update/NETGEARGenieInstaller.dmg)
- Printer drivers and utilities: Download them from [here](https://epson.com/Support/Printers/All-In-Ones/WorkForce-Series/Epson-WorkForce-WF-3620/s/SPT_C11CD19201)

### Manual and Specific Setups

Open all the installed applications and make sure they are working, most of them require to accept something or require an user input. These are some of these applications:

- XCode
- Server
- 1Password
- Google Chrome
- Firefox
- Skype
- WhatsApp
- Spotify
- Visual Studio Code Extensions
- Microsoft Office Apps (Word, Excel, PowerPoint, OneNote, Outlook)

## Development and Maintenance

To modify the list of applications to install or modify the script, first clone or pull the project.

The `setup.sh` script install automatically a list of applications using [Homebrew](https://brew.sh/) and [mas-cli](https://github.com/mas-cli/mas). It will also execute other tasks such as create a Workspace directory, customize the Zsh theme and more.

There is a file per Mac named with the hostname, i.e. `Brewfile.Johandrys-MacBook-Pro.local`, and the file `Brewfile.Common` with all the applications every mac should have. These Brewfiles are required by [Brew Bundle](https://github.com/Homebrew/homebrew-bundle) and they list all the applications to install. Comments starting with `#` are allow.

You can create a list of installed applications with the folowing command:

```bash
brew bundle dump --describe
```

Then move the applications in `Brewfile` to the right `Brewfile.*`.

The `setup.sh` script will create a Brewfile that will be saved to `~/.Brewfile` so you can upgrade all the applications at any time with:

```bash
brew bundle install --verbose --global
```

Or remove the none required programs with:

```bash
brew bundle cleanup --global
```

### Visual Studio Code Extensions

To list the existing Visual Studio Code extensions execute the command:

```bash
code --list-extensions
```

Then update the file `VSCode_Extensions.lst`.

To remove no needed extensions, use the command:

```bash
code --uninstall-extension <extension_name>
```

### Atom Packages

To list the installed Atom packages, use the command:

```bash
apm list --bare --packages --installed --enabled
```

Then update the file `Atom_Packages.lst` but do not include the version number (including the `@` character) unless an specific version is required.

To remove the no needed packages, use the command:

```bash
apm uninstall <package_name>
```

### Testing

To test locally (not always recommended), execute:

```bash
LOCAL_SETUP=1 ./setup.sh Test
```

The environment variable `LOCAL_SETUP=1` use the files locally instead of getting them from GitHub. The `Test` parameter is to use the `Brewfile.Test` instead the one with the hostname. You may replace the word `Test` to other Brewfile you would like to test.

It's possible to test the script using Vagrant. Follow these steps to use OSX Setup with Vagrant:

```bash
vagrant up
vagrant ssh
$ cd OS_Setup
$ LOCAL_SETUP=1 ./setup.sh Test
```

As mentioned above, you need to login to Apple Store with your Apple ID. Follow these steps at the Vagrant box:

1. Open VirtualBox to show the machine screen.
2. Login with user `vagrant` password `vagrant`
3. Open Apple Store and login with your Apple ID
4. Follow the authentication process, then you can close the screen.

To start over from scratch, execute `vagrant destroy` and start over by running `vagrant up`.
