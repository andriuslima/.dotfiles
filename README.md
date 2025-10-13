# Andrius Lima Dotfiles

## How to add a module

1. Create a unique folder name at the root
2. Move the files to track into this new folder. Pay attention to sub-folder structure
3. Run `stow $MODULE` to link those files back to their origin
4. Update `.dotfiles/link
5. Update `.dotfiles/adopt

## How to remove a module

1. Unstow module with `stow -D $MODULE`
1. Remove folder
2. Update `.dotfiles/link
3. Update `.dotfiles/adopt

## Documentation
[GNU Stow](https://www.gnu.org/software/stow/manual/stow.html)
- `--no-folding`: Prevents the program from creating fewer symbolic links by "folding" entire subdirectories into a single symlink. Instead, `--no-folding` ensures that every file and directory from the package is symlinked individually, even if it means creating a lot more symlinks and directories in the target location.