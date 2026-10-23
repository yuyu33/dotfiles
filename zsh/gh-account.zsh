# GitHub multi-account switcher
#   ghsw                 show accounts
#   ghsw <user>          switch gh active account (git push follows via gh credential helper)
#   ghsw <user> -l       also set user.name/email in current repo
#   ghas <user> <cmd..>  run one command as <user>  e.g. ghas yuyu33 git push
#   ghp / ghw            shortcuts (personal / work)
typeset -gA GH_ACCOUNT_EMAIL
: ${GH_ACCOUNT_EMAIL[yuyu33]:=32379611+yuyu33@users.noreply.github.com}

ghsw() {
  if [[ -z $1 ]]; then
    gh auth status 2>&1 | grep -E 'account|Active account'
    return
  fi
  local user=$1
  gh auth switch -h github.com -u "$user" || return
  if [[ $2 == -l ]] && git rev-parse --git-dir &>/dev/null; then
    git config user.name "$user"
    [[ -n ${GH_ACCOUNT_EMAIL[$user]} ]] && git config user.email "${GH_ACCOUNT_EMAIL[$user]}"
    echo "repo author -> $(git config user.name) <$(git config user.email)>"
  fi
}

ghas() {
  local user=$1; shift
  local token; token=$(gh auth token -h github.com -u "$user") || return
  GH_TOKEN=$token GITHUB_TOKEN=$token "$@"
}

# account names: override in ~/.config/zsh/.zshrc.local
#   GH_PERSONAL_USER=yuyu33
#   GH_WORK_USER=<work account>
ghp() { ghsw "${GH_PERSONAL_USER:-yuyu33}" "$@"; }
ghw() { ghsw "${GH_WORK_USER:?set GH_WORK_USER in ~/.config/zsh/.zshrc.local}" "$@"; }
