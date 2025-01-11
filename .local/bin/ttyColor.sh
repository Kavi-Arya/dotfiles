#!/bin/sh
sleep 0.2s;
darkTheme() {
    if [ "$TERM" = "linux" ]; then
        printf '\033]P01a1813'; # black
        printf '\033]P1991f1f'; # red
        printf '\033]P25c991f'; # green
        printf '\033]P3997b1f'; # yellow
        printf '\033]P41f3e99'; # blue
        printf '\033]P5991f70'; # magenta
        printf '\033]P61f9999'; # cyan
        printf '\033]P7ccbc95'; # white
        printf '\033]P8333026'; # brighter black
        printf '\033]P9E62E2E'; # brighter red
        printf '\033]PA8AE62E'; # brighter green
        printf '\033]PBE6B82E'; # brighter yellow
        printf '\033]PC2E5CE6'; # brighter blue
        printf '\033]PDE62EA9'; # brighter magenta
        printf '\033]PE2EE6E6'; # brighter cyan
        printf '\033]PFE6D7AB'; # brighter white
        clear;
    fi;
}
gruvboxTheme() {
    if [ "$TERM" = "linux" ]; then
        printf '\033]P01d2021'; # black
        printf '\033]P1ea6962'; # red
        printf '\033]P2a9b665'; # green
        printf '\033]P3d8a657'; # yellow
        printf '\033]P4e78a4e'; # blue
        printf '\033]P5d3869b'; # magenta
        printf '\033]P6689d6a'; # cyan
        printf '\033]P7d4be98'; # white
        printf '\033]P8282828'; # black
        printf '\033]P9ea6962'; # red
        printf '\033]PAa9b665'; # green
        printf '\033]PBd8a657'; # yellow
        printf '\033]PCe78a4e'; # blue
        printf '\033]PDd3869b'; # magenta
        printf '\033]PE689d6a'; # cyan
        printf '\033]PFa89984'; # white
        clear;
    fi;
}
vsCodeTheme() {
    if [ "$TERM" = "linux" ]; then
        printf '\033]P0000000'; # black
        printf '\033]P1d16969'; # red
        printf '\033]P2608b4e'; # green
        printf '\033]P3d7ba7d'; # yellow
        printf '\033]P4569cd6'; # blue
        printf '\033]P5c586c0'; # magenta
        printf '\033]P64ec9b0'; # cyan
        printf '\033]P7d4d4d4'; # white
        printf '\033]P8808080'; # black
        printf '\033]P9ce9178'; # red
        printf '\033]PAb5cea8'; # green
        printf '\033]PBdcdcaa'; # yellow
        printf '\033]PC9cdcfe'; # blue
        printf '\033]PDc586c0'; # magenta
        printf '\033]PE4ec9b0'; # cyan
        printf '\033]PFffffff'; # white
        clear;
    fi;
}

# darkTheme
# gruvboxTheme
vsCodeTheme
