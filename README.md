# My dotfiles

This directory contains my dotfiles, which are used to configure my system. 
These are for arch linux but pretty much all of them can be used for any linux or macos system. 

## Requirements

Ensure you have the following installed on your system: 

### Git 

```
pacman -S git
```

### Stow

```
pacman -S stow
```

### installation 

First check out the dotfiles repo in your @HOME directory using git. 

```
$ git clone https://github.com/devChrisStudios/dotfiles.git
$ cd dotfiles
```

Then use GNU stow to create the symlinks

```
$ stow .
```

# If you have any trouble the video I used to get started is [this one](https://www.youtube.com/watch?v=y6XCebnB9gs)

