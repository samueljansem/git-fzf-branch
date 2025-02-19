# git-fzf-branch

An interactive Git branch switcher using `fzf`. Easily browse, preview, and switch between local and remote branches with fuzzy search.

## 📌 Requirements

Make sure you have the following installed:

- [git](https://git-scm.com/)
- [fzf](https://github.com/cisco-qa/fzf)

## 🚀 Installation

1. Download the script:
  ```bash
    curl -o ~/bin/git-fzf-branch https://raw.githubusercontent.com/samueljansem/git-fzf-branch/main/git-fzf-branch.sh
  ```
2. Grant execution permissions:
  ```bash
    chmod +x ~/bin/git-fzf-branch
  ```
Note: Make sure to add the `~/bin` folder to your `PATH`

## 🔥 Features
- 🔍 Type to fuzzy find branches
- 🔄 `ctrl+r` → fetches new branches from remote
- 📋 `ctrl+y` → copy branch name
- ⏩ `ENTER` → `git switch` to selected branch (or `git checkout` for older `git` versions)
