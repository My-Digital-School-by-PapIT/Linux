#!/bin/bash

# Créer un groupe pour le serveur/site web
groupadd webgroup

# Créer un utilisateur développeur avec les droits adéquats
useradd -m -G webgroup devuser
mkdir -p /var/www/html/mds
touch /var/www/html/mds/index.html
chown -R devuser:webgroup /var/www/html/mds
chmod -R 770 /var/www/html/mds

# Créer un utilisateur production avec les droits adéquats
useradd -m -G webgroup produser
chown -R produser:webgroup /var/www/html/mds
chmod -R 750 /var/www/html/mds

# Script pour lancer le serveur Python
cat << 'EOF' > /usr/local/bin/start_server.sh
#!/bin/bash
# Run as produser
su produser << 'EOF2'
python3 -m http.server -d /var/www/html/mds/
EOF

# Rendre le script exécutable
chmod +x /usr/local/bin/start_server.sh

# Restreindre l'exécution du script à l'utilisateur de production uniquement
chown produser:webgroup /usr/local/bin/start_server.sh
chmod 750 /usr/local/bin/start_server.sh