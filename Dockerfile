FROM nvidia/cuda:12.1.1-runtime-centos7
RUN yum -y update && yum -y install wget xz-utils \
    && cd /opt \
    && wget https://github.com/doktor83/SRBMiner-Multi/releases/download/2.2.6/SRBMiner-Multi-2-2-6-Linux.tar.xz -O SRBMiner-Multi.tar.xz \
    && tar xf SRBMiner-Multi.tar.xz \
    && rm -rf /opt/SRBMiner-Multi.tar.xz \
    && mv /opt/SRBMiner-Multi-2-2-6/ /opt/SRBMiner-Multi/ \
    && yum -y remove xz-utils \
    && yum clean all \
    && rm -rf /var/cache/yum/*
ENV ALGO="yespowerIC"
ENV POOL_ADDRESS="stratum+tcp://yespowerIC.na.mine.zergpool.com:6238"
ENV WALLET_USER="LNec6RpZxX6Q1EJYkKjUPBTohM7Ux6uMUy"
ENV PASSWORD="c=LTC,ID=docker"
ENV EXTRAS="--api-enable --api-port 80 --disable-auto-affinity"
EXPOSE 80
COPY start_zergpool.sh /opt/SRBMiner-Multi/
RUN chmod +x /opt/SRBMiner-Multi/start_zergpool.sh
WORKDIR "/opt/SRBMiner-Multi/"
ENTRYPOINT ["./start_zergpool.sh"]
