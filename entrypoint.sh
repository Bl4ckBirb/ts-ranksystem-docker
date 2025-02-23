#!/bin/bash
set -e

# Check if the host-mounted directory (mounted at /host/apache2) is empty
if [ -z "$(ls -A /host/apache2 2>/dev/null)" ]; then
  echo "Initializing Apache config..."
  cp -R /etc/apache2/* /host/apache2/
fi

# Replace /etc/apache2 with a symlink to the host directory
rm -rf /etc/apache2
ln -s /host/apache2 /etc/apache2

# Execute the original command (e.g., starting Apache)
exec apache2-foreground