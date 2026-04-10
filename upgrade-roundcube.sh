#!/bin/bash
# Script to install Roundcube 1.6.15 using PHP 7.1 on CWP

set -e  # Exit immediately if a command fails

# Go to source directory
cd /usr/local/src

# Remove any previous Roundcube files
rm -rf roundcube*

# Download Roundcube 1.6.15
wget https://github.com/roundcube/roundcubemail/releases/download/1.6.15/roundcubemail-1.6.15-complete.tar.gz

# Extract the package
tar xf roundcubemail-1.6.15-complete.tar.gz
cd roundcubemail-1.6.15

# Show PHP version (optional)
php -v

# Patch the installer to use CWP PHP 7.1
sed -i "s@/usr/bin/env php@/usr/bin/env /usr/local/cwp/php71/bin/php@g" bin/installto.sh
sed -i "s@\\php bin@/usr/local/cwp/php71/bin/php bin@g" bin/installto.sh

# Run the Roundcube installer
bin/installto.sh /usr/local/cwpsrv/var/services/roundcube

# Verify installation directory (optional)
ls -l /usr/local/cwp/

ls -la /usr/local/cwpsrv/var/services/roundcube

chown -R cwpsvc:cwpsvc /usr/local/cwpsrv/var/services/roundcube

echo "Roundcube installation completed successfully!"
