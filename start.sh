#!/usr/bin/env bash

source src/conf/styles.sh

show_menu() {
    echo -e "${STYLE_GREEN}Welcome to weeb downloader${STYLE_RESET}"
    echo "1. Manga Plus"
    echo "2. Tu Manga Online (TMO)"
    echo "3. Exit"
}

while true; do
    show_menu
    read -p "Choose an option: " choice

    # Evaluar la opción del usuario
    case $choice in
    1)
        echo -e "${STYLE_YELLOW}Manga Plus selected.${STYLE_RESET}"
            source src/bin/manga_plus.sh
        ;;
    2)
        echo -e "${STYLE_YELLOW}Tu Manga Online (TMO) selected.${STYLE_RESET}"
            source src/bin/tmo.sh
        ;;
    3)
        echo -e "${STYLE_GREEN}¡Hasta luego!${STYLE_RESET}"
        break
        ;;
    *)
        echo -e "${STYLE_RED}${STYLE_UNDERLINED}Invalid option. Please select a valid option.${STYLE_RESET}"
        ;;
    esac
done
