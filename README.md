# scjalliance/unifi

Ubiquiti UniFi controller software for Docker

This is how we run this image:

	docker run -d -p 8080:8080 -p 8443:8443 -v /media/somewhere/unifi:/var/lib/unifi:rw --name=unifi --restart=always scjalliance/unifi
