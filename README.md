# streakerbar &hearts;

A Mac OS X menubar app to track your open source contribution streak on GitHub.


### Dark theme

![](streakerbar_dark_theme.png)

### Light theme

![](streakerbar_light_theme.png)

## Installation via Homebrew Cask

1. `brew update`
1. `brew install caskroom/cask/brew-cask` (if you haven't done so already)
1. `brew cask install streakerbar`

## Setup

Streakerbar app can read your `.gitconfig` assuming that it's in your home directory, `~/.gitconfig`, and configured thusly:

```
[github]
    user = chaserx
```

If you don't have this saved in your `.gitconfig`, it will ask you for your GitHub username.

## Contributors

- Michael Bates (@mklbtz)
- Chase Southard (@chaserx)
- Nick Warner (@nikolaiwarner)

## Development

Targeting Swift 1.2 via Xcode 6.3

## Contributing

Pull requests welcome! Please see our [contribution guide](CONTRIBUTING.md).


### NOTES

Updating release and Homebrew Cask:

1. create a new github release
1. in xcode, change the corresponding release value and export app for release
1. zip streakerbar.app
1. upload streakerbar.zip to github release
1. get the 256 SHA for the zipfile with `shasum -a 256 streakerbar.zip`
1. copy the version number and sha into homebrew-cask/Casks/streakerbar.rb
1. checkout a new branch in homebrew-cask per their contribution guidlines. commit changes
1. submit new PR to homebrew-cask
1. enjoy
