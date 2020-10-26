#!/usr/bin/env bash

# Generates your own Certificate Authority for development.
# This script should be executed just once.

set -e

KEY_LENGHT_BITS=2048

if [ -f "ca.crt" ] || [ -f "ca.key" ]; then
    echo -e "\e[41mCertificate Authority files already exist!\e[49m"
    echo
    echo -e "You only need a single CA even if you need to create multiple certificates."
    echo -e "This way, you only ever have to import the certificate in your browser once."
    echo
    echo -e "If you want to restart from scratch, delete the \e[93mca.crt\e[39m and \e[93mca.key\e[39m files."
    exit
fi

# Generate private key
openssl genrsa -out ca.key ${KEY_LENGHT_BITS}

# Generate root certificate
openssl req -x509 -new -nodes -subj "/C=${1}/ST=${2}/L=${3}/O=${4} CA/CN=${5}" -key ca.key -sha256 -days 3650 -out ca.crt

echo -e "\e[42mSuccess!\e[49m"
echo
echo "The following files have been written:"
echo -e "  - \e[93mca.crt\e[39m is the public certificate that should be imported in your browser"
echo -e "  - \e[93mca.key\e[39m is the private key that will be used by \e[93mcreate-certificate.sh\e[39m"
echo
echo "Next steps:"
echo -e "  - Import \e[93mca.crt\e[39m in your browser"
echo -e "  - run \e[93mcreate-certificate.sh example.com\e[39m"
