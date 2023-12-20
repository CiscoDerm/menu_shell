#!/bin/bash

while true; do
    clear
    #!/bin/bash
    echo "          _____                    _____                    _____                    _____          "
    echo "         /\\    \\                  /\\    \\                  /\\    \\                  /\\    \\         "
    echo "        /::\\    \\                /::\\    \\                /::\\    \\                /::\\____\\        "
    echo "        \\:::\\    \\              /::::\\    \\              /::::\\    \\              /::::|   |        "
    echo "         \\:::\\    \\            /::::::\\    \\            /::::::\\    \\            /:::::|   |        "
    echo "          \\:::\\    \\          /:::/\\:::\\    \\          /:::/\\:::\\    \\          /::::::|   |        "
    echo "           \\:::\\    \\        /:::/__\\:::\\    \\        /:::/__\\:::\\    \\        /:::/|::|   |        "
    echo "           /::::\\    \\       \\:::\\   \\:::\\    \\      /::::\\   \\:::\\    \\      /:::/ |::|   |        "
    echo "  ____    /::::::\\    \\    ___\\:::\\   \\:::\\    \\    /::::::\\   \\:::\\    \\    /:::/  |::|   | _____  "
    echo " /\\   \\  /:::/\\:::\\    \\  /\\   \\:::\\   \\:::\\    \\  /:::/\\:::\\   \\:::\\    \\  /:::/   |::|   |/\\    \\ "
    echo "/::\\   \\/:::/  \\:::\\____\\/::\\   \\:::\\   \\:::\\____\\/:::/__\\:::\\   \\:::\\____\\/:: /    |::|   /::\\____\\"
    echo "\\:::\\  /:::/    \\::/    /\\:::\\   \\:::\\   \\::/    /\\:::\\   \\:::\\   \\::/    /\\::/    /|::|  /:::/    /"
    echo " \\:::\\/:::/    / \\/____/  \\:::\\   \\:::\\   \\/____/  \\:::\\   \\:::\\   \\/____/  \\/____/ |::| /:::/    / "
    echo "  \\::::::/    /            \\:::\\   \\:::\\    \\       \\:::\\   \\:::\\    \\              |::|/:::/    /  "
    echo "   \\::::/____/              \\:::\\   \\:::\\____\\       \\:::\\   \\:::\\____\\             |::::::/    /   "
    echo "    \\:::\\    \\               \\:::\\  /:::/    /        \\:::\\   \\::/    /             |:::::/    /    "
    echo "     \\:::\\    \\               \\:::\\/:::/    /          \\:::\\   \\/____/              |::::/    /     "
    echo "      \\:::\\    \\               \\::::::/    /            \\:::\\    \\                  /:::/    /      "
    echo "       \\:::\\____\\               \\::::/    /              \\:::\\____\\                /:::/    /       "
    echo "        \\::/    /                \\::/    /                \\::/    /                \\::/    /        "
    echo "         \\/____/                  \\/____/                  \\/____/                  \\/____/         "
    echo "                                                                                                     "
    echo "Menu :"
    echo "1. Lister les cartes réseau"
    echo "2. Trouver un fichier"
    echo "3. Afficher l'IP d'une interface réseau"
    echo "4. Trouver le PID d'un processus par son nom"
    echo "5. IP site web"
    echo "6. Découvrir les ports ouverts sur une adresse IP"
    echo "7. Quitter"
    echo " "
    read -p "Choisissez une option (1/2/3/4/5/6/7): " choix
    echo " "

    case $choix in
        1)
            echo "Liste des cartes réseau disponibles :"
            ip link show
            read -p "Appuyez sur une touche pour continuer..." key
            ;;
        2)
            read -p "Entrez le nom du fichier à rechercher : " nom_fichier
            echo "Recherche du fichier : $nom_fichier"
            find / -name "$nom_fichier" 2>/dev/null
            read -p "Appuyez sur une touche pour continuer..." key
            ;;
        3)
            read -p "Entrez le nom de l'interface réseau : " nom_interface
            echo "Adresse IP de l'interface $nom_interface : $(ip -4 addr show $nom_interface | grep inet | awk '{print $2}' | cut -d/ -f1)"
            read -p "Appuyez sur une touche pour continuer..." key
            ;;
        4)
            read -p "Entrez le nom du processus : " nom_processus
            pids=$(pgrep -f "$nom_processus")
            if [ -z "$pids" ]; then
                echo "Aucun processus trouvé pour $nom_processus."
            else
                max_pid=$(echo "$pids" | sort -nr | head -n 1)
                echo "Le plus grand PID de $nom_processus : $max_pid"
                read -p "Voulez-vous terminer ce processus avec 'kill -9'? (o/n) " reponse
                if [ "$reponse" = "o" ]; then
                    kill -9 $max_pid
                    echo "Signal 'kill -9' envoyé au processus $max_pid."
                else
                    echo "Action annulée."
                fi
            fi
            read -p "Appuyez sur une touche pour continuer..." key
            ;;
        5)
            read -p "Entrez l'URL du site web : " url
            ip=$(dig +short $url | grep -m 1 '^[.0-9]*$')
            if [ -z "$ip" ]; then
                echo "Aucune adresse IP trouvée pour $url."
            else
                echo "L'adresse IP de $url est : $ip"
            fi
            read -p "Appuyez sur une touche pour continuer..." key
            ;;
        6)
            read -p "Entrez l'adresse IP pour le scan des ports : " ip_scan
            echo "Scan des ports de l'adresse IP $ip_scan en cours..."
            nmap $ip_scan
            read -p "Appuyez sur une touche pour continuer..." key
            ;;
        7)
            echo "Au revoir !"
            exit 0
            ;;
        *)
            echo "Option invalide, veuillez réessayer."
            read -p "Appuyez sur une touche pour continuer..." key
            ;;
    esac
done
