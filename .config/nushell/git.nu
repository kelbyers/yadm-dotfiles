# let git_version

# find root directory of repo and cd to it
export alias grt = cd (
    try { git rev-parse --show-toplevel err> /dev/null } catch { echo . })

export alias g = git

export alias ga = git add
export alias gaa = git add --all

export alias gb = git branch

export alias gc = git commit --verbose
export alias gca = git commit --verbose --all
export alias gcam = git commit -am

export alias gcl = git clone

export alias gclean = git clean --interactive -d

export alias gco = git checkout

export alias gd = git diff

export alias gf = git fetch
export alias gfa = git fetch --all

export alias gl = git pull

export alias glgg = git log --graph
export alias glo = git log --oneline --decorate

export alias gm = git merge

export alias gmtl = git mergetool --no-prompt

export alias gp = git push
export alias gpd = git push --dry-run
export alias gpv = git push --verbose

export alias gr = git remote
export alias grv = git remote --verbose
export alias grso = git remote show origin

export alias grh = git reset
export alias grhh = git reset --hard

export alias grm = git rm

export alias grs = git restore
export alias grss = git restore --source
export alias grst = git restore --staged

export alias gst = git status

export alias gsw = git switch

export alias gw = git bulk
