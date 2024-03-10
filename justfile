config_home := "~/.config"

default:
    @just --list

setup-alacritty:
    curl -o {{config_home}}/alacritty/dracula_just.toml https://raw.githubusercontent.com/dracula/alacritty/master/dracula.toml
