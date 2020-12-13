#!/usr/bin/env bash

echo ""
echo "Starting transmission container ..."
 docker run --cap-add=NET_ADMIN -d \
	--name=transmission \
	-v /your/storage/path/:/data \
	-v /etc/localtime:/etc/localtime:ro \
	-e CREATE_TUN_DEVICE=true \
	-e OPENVPN_PROVIDER=PIA \
	-e OPENVPN_CONFIG=CA\ Toronto \
	-e OPENVPN_USERNAME=user \
	-e OPENVPN_PASSWORD=pass \
	-e WEBPROXY_ENABLED=false \
	-e LOCAL_NETWORK=192.168.1.0/24 \
	-e TRANSMISSION_UMASK=0 \
	-e TRANSMISSION_WEB_UI=combustion \
	--log-driver json-file \
	--log-opt max-size=10m \
	--dns 8.8.8.8 \
	--dns 8.8.4.4 \
	-p 9091:9091 \
	haugene/transmission-openvpn
echo "Done."
echo ""
