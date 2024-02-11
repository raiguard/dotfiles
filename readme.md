# dotfiles installation

```
git clone --bare https://github.com/raiguard/dotfiles ~/.dotfiles
git --git-dir=$HOME/.dotfiles --work-tree=$HOME checkout
git --git-dir=$HOME/.dotfiles --work-tree=$HOME config status.showUntrackedFiles no
```

Install [yash](https://magicant.github.io/yash/) shell and `chsh` to
`/bin/yash`. Dotfiles can then be managed with the `dgit` command.
