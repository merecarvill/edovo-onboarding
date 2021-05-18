# Onboarding script

This script will set up a local development environment on a mac, primarily using Homebrew.

## Running the script

- There's no need to clone this repo, just execute this from the command line:

```bash
curl https://raw.githubusercontent.com/scarvill91/edovo-onboarding/main/install.sh | bash
```

NOTE:

- Run this command in a working directory where you'd like elasticsearch to be installed.

### Manual Followup

- To add `mysql` to your path (binary for mariadb):
  - For bash: `echo 'export PATH="/usr/local/opt/mariadb@10.3/bin:$PATH"' >> ~/.bash_profile`
  - For fish: `echo 'fish_add_path /usr/local/opt/mariadb@10.3/bin' >> ~/.config/fish/config.fish`

NOTES:

- IntelliJ IDEA Ultimate will be installed in the `~/Applications` directory.

## What is installed

- elasticsearch v7.8.0
- Homebrew
- imagemagick
- IntelliJ IDEA Ultimate
- Java 8
- mariadb v10.3
- maven
- NodeJS v8
- redis
- XCode tools
