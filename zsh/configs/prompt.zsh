# show character if changes are pending
git_dirty() {
  if command git diff-index --quiet HEAD 2> /dev/null; then
    echo ""
  else
    echo "[%{$fg[red]%}+%{$reset_color%}]"
  fi
}

# adds the current branch name in green
git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null)
  branch="[%{$fg_bold[green]%}${ref#refs/heads/}%{$reset_color%}]"
  if [[ -n $ref ]]; then
    echo "$branch$(git_dirty)"
  fi
}

setopt promptsubst

# Allow exported PS1 variable to override default prompt.
if ! env | grep -q '^PS1='; then
  PS1='${SSH_CONNECTION+"%{$fg_bold[green]%}%n@%m:"}%{$fg_bold[blue]%}%c%{$reset_color%}$(git_prompt_info) %# '
fi
