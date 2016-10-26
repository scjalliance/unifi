# scjalliance/unifi

Ubiquiti UniFi controller software for Docker

This is how we run this image, via a file called something like `/some/location/blah/run.sh`:

	#!/bin/bash -xe
	
	DIR="$(readlink -f "$(dirname $0)")"
	docker pull scjalliance/unifi
	docker stop unifi || echo NOT STOPPED
	docker rm unifi || echo NOT REMOVED
	docker run -d -p 0.0.0.0:8080:8080 -p 0.0.0.0:8443:8443 -v $DIR/var-lib-unifi:/var/lib/unifi:rw -v $DIR/var-log-unifi:/var/log/unifi:rw -v $DIR/var-run-unifi:/var/run/unifi:rw -v $DIR/usr-lib-unifi-work:/usr/lib/unifi/work:rw -v $DIR/usr-lib-unifi-data:/usr/lib/unifi/data:rw --name=unifi --restart=always scjalliance/unifi

But we imagine that if you would use `--volumes-from`, it would work well and exactly as expected.
