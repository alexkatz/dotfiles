# Dotfiles

1. Install [Homebrew](https://brew.sh/) and run `brew bundle install` to install all dependencies contained in `./Brewfile`
2. Do [GitHub SSH stuff](https://docs.github.com/en/authentication/connecting-to-github-with-ssh)
3. `chezmoi init git@github.com:alexkatz/dotfiles.git`
4. Install [Bob](https://github.com/MordechaiHadad/bob), a Neovim version manager
   1. Install [rustup](https://www.rust-lang.org/tools/install)
   2. Run `cargo install bob-nvim`
5. Using Bob, install desired Neovim versions
6. Using the newly installed instance of [fnm](https://github.com/Schniz/fnm), install desired Node versions
7. Install [pnpm](https://pnpm.io/installation) via `corepack`
8. I guess do [Bitbucket SSH stuff](https://support.atlassian.com/bitbucket-cloud/docs/configure-ssh-and-two-step-verification/) as well
