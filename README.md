# Onboarding script

This script will set up a local development environment on a mac, primarily using Homebrew.

## Running the script

- `bash install.sh -d <working-directory-for-some-installs>`

### Manual Followup

- To add `mysql` to your path (binary for mariadb):
  - For bash: `echo 'export PATH="/usr/local/opt/mariadb@10.3/bin:$PATH"' >> ~/.bash_profile`
  - For fish: `echo 'fish_add_path /usr/local/opt/mariadb@10.3/bin' >> ~/.config/fish/config.fish`

NOTES:

- The provided working directory determines where elasticsearch will be installed.
- IntelliJ IDEA Ultimate will be installed in the `~/Applications` directory.

## What is installed

- XCode tools
- Homebrew
- redis
- mariadb v10.3
- maven
- imagemagick
- elasticsearch v7.8.0
- Java 8
- NodeJS v8
- IntelliJ IDEA Ultimate

## Validating installs

- `java -version` should output a version that begins with "1.8".
