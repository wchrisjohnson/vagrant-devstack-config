!/bin/bash
set -e

cd /home/vagrant/devstack/

echo "===== Boot an Ubuntu instance, install wordpress..."

source openrc

nova boot \
  --flavor "2" \
  --image "5e17acac-d441-4599-b0bf-b2c7cb5a691c" \
  --key_name "devstack" \
  --user_data /home/vagrant/wordpress_user_data.txt \
  --security_groups "default" \
  --nic "net-id=7bd2af80-baa9-4486-86f4-c09020bb0cff" \
  wordpress

echo "----- Setup complete."
