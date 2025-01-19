export def main [] {}

export def set-clipboard [] {
    to text | run-external pbcopy
}

export def get-clipboard [...rest] {
    run-external pbpaste ...$rest
}
