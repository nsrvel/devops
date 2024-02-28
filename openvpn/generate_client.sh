#!/bin/bash

# Get client name from user input
read -p "Enter the client name: " CLIENTNAME

# Ask user for passphrase preference
read -p "Do you want to set a passphrase for the client certificate? (y/n): " PASSPHRASE_OPTION

if [[ $PASSPHRASE_OPTION == "y" ]]; then
    PASSPHRASE=""
else
    PASSPHRASE="nopass"
fi

# Build client certificate
docker-compose run --rm openvpn easyrsa build-client-full $CLIENTNAME $PASSPHRASE

# Generate the client configuration
docker-compose run --rm openvpn ovpn_getclient $CLIENTNAME > $CLIENTNAME.ovpn

echo "Client configuration for $CLIENTNAME saved as $CLIENTNAME.ovpn"
