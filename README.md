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

   Optionally, you may set the variable `SETUP_BREWFILES` with a list of brewfiles ID's (the text after the file named `Brewfile.`), like this:

   ```bash
   export SETUP_BREWFILES="HomeServer.local"
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
4. Open Finder and in the sidebar, order the items and add **Workspace** and **Sandbox** directories, also the **Cloud Storages** directories.
5. In the menu bar, right click on the battery and select **Show Percentage**.

### Docker

Yes, Docker can be installed with `brew` but, as it's an critical application I prefer to install it manually, so:

1. Download it from [here](https://download.docker.com/mac/stable/Docker.dmg)
   *(It may be required to login first with the DockerHub user)*
2. Install it or [follow the instructions](https://docs.docker.com/docker-for-mac/install/)

### AWS CLI

Configure your access to AWS through the CLI. Find the AWS access keys, it should be a CSV document. Open Terminal and execute the following command to enter the `AWS Access Key ID` and `AWS Secret Access Key`:

```bash
aws configure
```

The region could be `us-west-2` and the output format `json`. Verify the access with the command:

```bash
aws ec2 describe-key-pairs
```

### Microsoft Office 365 Home

1. Go to [office service](https://account.microsoft.com/services/office/install)
2. Click on **Install Office** to download the installer

### Google Chrome

Open Google Chrome and login with your user.

In the past the brew install of Chrome caused some problems every time there is a Chrome update. If it happens again, uninstall the brew cask for Chrome, download it from [here](https://www.google.com/chrome/) and install it.

```bash
brew cask uninstall google-chrome
```

### Terminal

1. Open **Terminal**, go to **Preferences** (&#8984; + ,), select **General** tab.
2. Select **Pro** in **New window with profile**
3. Go to **Profiles** tab, select **Pro** as the default one.
4. In the Pro profile, go to the **Window** tab, set **160** in **Columns**, and **48** in **Rows**.

### Visual Studio Code

The **Go extension** require a bunch of tools installed, to install them, create a new file with a simple Go code:

```go
package main

import "fmt"

func main() {
  fmt.Println("hello")
}
```

Save it and an alert at the bottom will ask to install all the dependencies required by the VSCode Go package. Select `All` and wait until all are installed.

The default **Python interpreter** is Python 2, to select Python 3 open the **Command Palette** (⇧⌘P) and -partially - type **Python: Select Interpreter**, then select the correct Python 3 interpreter.

If you don't see it in the list try to reinstall Python 3 and/or restart Visual Studio Code:

```bash
brew reinstall python3
brew link python3
python3 -V
where python3
```

### Slack

Login to the following workspaces using the email address `johandry@yahoo.com`:

- gophers.slack.com
- kubernetes.slack.com
- sddevops.slack.com
- devsecops.slack.com

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
- Slack
- Spotify
- Github Desktop
- Microsoft Office Apps (Word, Excel, PowerPoint, OneNote, Outlook)

## Development and Maintenance

To modify the list of applications to install or modify the script, first clone or pull the project.

The `setup.sh` script install automatically a list of applications using [Homebrew](https://brew.sh/) and [mas-cli](https://github.com/mas-cli/mas). It will also execute other tasks such as create a Workspace directory, customize the Zsh theme and more.

There is a file per Mac named with the hostname, i.e. `Brewfile.Johandrys-MacBook-Pro.local`, and the file `Brewfile.Common` with all the applications every mac should have. These Brewfiles are required by [Brew Bundle](https://github.com/Homebrew/homebrew-bundle) and they list all the applications to install. Comments starting with `#` are allow.

You can create a list of installed applications with the following command:

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
LOCAL_SETUP=1 ./setup.sh
```

The environment variable `LOCAL_SETUP=1` use the files locally instead of getting them from GitHub.

If no parameter is pass the script will use the `Brewfile.Test` brewfile instead the one with the hostname. Or, you may pass a list of brewfiles extensions (the name after `Brewfile.`) to use them, instead of `Brewfile.Test` or the one with the hostname.

Notice that `Brewfile.Common` will always be used.

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
