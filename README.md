# Andrius Lima Dotfiles

## 1st Steps
1. Clone repository
2. Configure terminal. Refer to resources folder
3. Install HomeBrew: `zsh scripts/.bin/scripts/install_homebrew`
4. Run `eval "$(/opt/homebrew/bin/brew shellenv)"` to have `brew` on your path momentarily
5. Install GNU Stow: `brew install stow`
6. Install MAS: `brew install mas`
7. Run `.dotfiles/link`
8. Run `.bin/install_apps`
9. Run `.bin/setup_tools`
10. Run `.bin/update_apps`


## How to add a module
1. Create a unique folder name at the root
2. Update `.dotfiles/link
3. Update `.dotfiles/adopt

## How to remove a module
1. Unstow module with `stow -D $MODULE`
1. Remove folder
2. Update `.dotfiles/link
3. Update `.dotfiles/adopt
