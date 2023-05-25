# dotfiles installation

```
git clone --bare https://github.com/raiguard/dotfiles ~/.dotfiles
git --git-dir=$HOME/.dotfiles --work-tree/$HOME checkout
dgit config status.showUntrackedFiles no
```

Then dotfiles can be managed with the `dgit` command.
