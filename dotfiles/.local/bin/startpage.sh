
main() {
  cd ~/.config/myStartpage/ || exit
  python3 -m http.server 8080
}

main
