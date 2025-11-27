# Andrius Lima Dotfiles

## How to install
1. Adopt settings: `sh adopt.sh`
    - When running fir the first time, the target directories will contain files that are not yet linked. It is necessary to first adopt the files into Stow
2. Discard adopted changes: `git restore`
    - Now that the files are linked, we can dicard any changes that were adopted. Therefore, modiying the target file with the content of this repository.
3. Install settings: `sh install.sh`
    - This will install all the packages and settings.

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
- `--adopt`: When stowing, if a target is encountered which already exists but is a plain file (and hence not owned by any existing stow package), then normally Stow will register this as a **conflict** and refuse to proceed. This option changes that behaviour so that the file is moved to the same relative place within the package’s installation image within the stow directory, and then stowing proceeds as before. So effectively, the file becomes adopted by the stow package, without its contents changing. This is particularly useful when the stow package is under the control of a version control system, because it allows files in the target tree, with potentially different contents to the equivalent versions in the stow package’s installation image, to be adopted into the package, then compared by running something like `git diff ...` inside the stow package, and finally either kept (e.g. via `git commit ...`) or discarded (`git checkout HEAD ...`).