FROM java:8-jre
MAINTAINER Dusty Wilson <dusty@linux.com>

ENV DEBIAN_FRONTEND noninteractive
VOLUME ["/var/lib/unifi", "/var/log/unifi", "/var/run/unifi", "/usr/lib/unifi/data", "/usr/lib/unifi/work"]

# 3478/udp STUN
# 8080/tcp inform from APs (HTTP)
# 8443/tcp GUI for admin user (HTTPS)
# 8880/tcp portal redirect (HTTP)
# 8843/tcp portal redirect (HTTPS)
# 27117/tcp MongoDB
EXPOSE 3478/udp 8080/tcp 8443/tcp 8880/tcp 8843/tcp 27117/tcp

# Setup MongoDB
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5
RUN echo "deb http://repo.mongodb.org/apt/debian jessie/mongodb-org/3.6 main" > /etc/apt/sources.list.d/mongodb-org-3.6.list

# Setup UniFi
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 06E85760C0A52C50
RUN echo "deb http://www.ubnt.com/downloads/unifi/debian stable ubiquiti" > /etc/apt/sources.list.d/100-ubnt-unifi.list

# Install
RUN apt-get update \
    && apt-get install -y \
        ssmtp \
        unifi \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /var/lib/unifi

ENTRYPOINT ["/usr/bin/java", "-Xmx1024M", "-jar", "/usr/lib/unifi/lib/ace.jar"]
CMD ["start"]
