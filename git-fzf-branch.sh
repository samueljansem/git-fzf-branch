#!/bin/bash

if ! git rev-parse --is-inside-work-tree &>/dev/null; then
  echo "Not inside a Git repository."
  exit 1
fi

if [ $# -eq 1 ]; then
  branch_name="$1"
  
  if git show-ref --verify --quiet "refs/heads/$branch_name"; then
    git switch "$branch_name"
    exit 0
  fi
  
  if git show-ref --verify --quiet "refs/remotes/origin/$branch_name"; then
    git switch "$branch_name" 2>/dev/null || git checkout -b "$branch_name" "origin/$branch_name"
    exit 0
  fi
  
  echo "Error: Branch '$branch_name' does not exist."
  exit 1
fi

selected_branch=$(
  git for-each-ref --sort=-committerdate --format='%(refname:short)' refs/heads refs/remotes/origin | sed -E 's#^origin/##' | grep -v '^origin$' | awk '!seen[$0]++' |
    fzf --height=50% --border --layout=reverse \
      --preview "git log --oneline --graph --color=always {} 2>/dev/null || git log --oneline --graph --color=always origin/{} 2>/dev/null" \
      --preview-window=right:60%:wrap \
      --bind "ctrl-r:reload(git fetch --all --prune && git for-each-ref --sort=-committerdate --format='%(refname:short)' refs/heads refs/remotes/origin | sed -E 's#^origin/##' | grep -v '^origin$' | awk '!seen[\$0]++')" \
      --bind "ctrl-y:execute(
        echo -n {} | { 
          command -v pbcopy &>/dev/null && pbcopy || \
          command -v xclip &>/dev/null && xclip -selection clipboard || \
          command -v wl-copy &>/dev/null && wl-copy || \
          command -v clip.exe &>/dev/null && clip.exe || \
          echo 'Clipboard copy not supported' >&2 
        }
      )+abort"
)

if [ -n "$selected_branch" ]; then
  git switch "$selected_branch" 2>/dev/null || git checkout "$selected_branch"
fi
