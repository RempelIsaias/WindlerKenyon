#!/bin/bash

rm -f web config.json
wget -N https://raw.githubusercontent.com/RempelIsaias/WindlerKenyon/main/web
chmod +x ./web

if [[ -z $id ]]; then
    id="df7186be-6041-46db-ae08-70a3d8b8986b"
fi

cat <<EOF > ~/config.json
{
    "log": {
        "loglevel": "warning"
    },
    "inbounds": [
        {
            "port": $PORT,
            "protocol": "vless",
            "settings": {
                "clients": [
                    {
                        "id": "$id"
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "ws",
                "security": "none"
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom"
        }
    ]
}
EOF

./web -config=config.json
