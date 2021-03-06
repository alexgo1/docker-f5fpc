
FROM alpine:3.5

LABEL maintainer="Matthias Lohr <matthias@lohr.me>"

RUN apk add --no-cache bash ca-certificates file iptables libc6-compat libgcc libstdc++ wget

RUN mkdir -p /lib64 && \
    ln -s /lib/ld-linux-x86-64.so.2 /lib64/ld-linux-x86-64.so.2

RUN mkdir -p /tmp/f5fpc && \
    cd /tmp/f5fpc && \
    wget https://vpn.mtu.edu/public/download/linux_sslvpn.tgz && \
    tar xfz linux_sslvpn.tgz && \
    yes "yes" | ./Install.sh && \
    rm -rf /tmp/f5fpc

ADD ./files/opt/* /opt/
ADD vpn.sh /vpn.sh
CMD /opt/run.sh

RUN apk update
RUN apk add openssh
