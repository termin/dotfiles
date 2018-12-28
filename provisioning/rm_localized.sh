#!/bin/bash
# Finderでディレクトリ名を日本語にローカライズさせない
# .localizedを削除する

PATHS=$(cat <<EOL
$HOME/Library
$HOME/Pictures
$HOME/Music
$HOME/Downloads
$HOME/Desktop
$HOME/Movies
$HOME/Documents
$HOME/Sites
/Users/Shared
/Applications
/System
/Users
/Library
EOL
)

for p in ${PATHS[@]}; do
	echo "rm $p/.localized"
	sudo rm $p/.localized
done

