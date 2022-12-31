echo "Enter Username without Domain"
read userID
echo "Enter Domain"
read userDomain
echo "Enter the Export Password"
read cerPass

mkdir %changeme%/$userID
cd %changeme%/$userID

cat <<EOT > ./csrconfig.txt
[ req ]
default_md = sha256
prompt = no
req_extensions = v3_req
distinguished_name = req_distinguished_name
[ req_distinguished_name ]
commonName = $userID@$userDomain
countryName = %changeme%
stateOrProvinceName = %changeme%
localityName = %changeme%
organizationName = %changeme%
organizationalUnitName = User Certificates
[ v3_req ]
keyUsage=critical,digitalSignature,keyEncipherment
extendedKeyUsage=critical,serverAuth,clientAuth,codeSigning,emailProtection
subjectAltName = @alt_names
[ alt_names ]
otherName.0 = 1.3.6.1.4.1.311.20.2.3;UTF8:$userID@$userDomain
otherName.1 = msUPN;UTF8:$userID@$userDomain
email.0 = $userID@$userDomain
EOT

openssl genpkey -outform PEM -algorithm RSA -pkeyopt rsa_keygen_bits:2048 -out $userID.key
openssl req -new -nodes -key $userID.key -config csrconfig.txt -nameopt utf8 -utf8 -out $userID.csr
openssl ca -days 3650 -in $userID.csr -out $userID.crt -extfile csrconfig.txt -extensions v3_req -config %changeme_path_to_openssl_ca_conf% --passin pass:%changeme_your_ca_password% -batch
openssl pkcs12 -inkey $userID.key -in $userID.crt -export -out $userID.pfx -passout pass:$certPass
