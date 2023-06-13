FROM nvidia/cuda:11.0.3-runtime-ubuntu18.04
RUN apt-get -y update && apt-get -y install wget xz-utils \
    && cd /opt \
    && wget https://github.com/doktor83/SRBMiner-Multi/releases/download/2.2.9/SRBMiner-Multi-2-2-9-Linux.tar.xz -O SRBMiner-Multi.tar.xz \
    && tar xf SRBMiner-Multi.tar.xz \
    && rm -rf /opt/SRBMiner-Multi.tar.xz \
    && mv /opt/SRBMiner-Multi-2-2-9/ /opt/SRBMiner-Multi/ \
    && apt-get -y purge xz-utils \
    && apt-get -y autoremove --purge \
    && apt-get -y clean \
    && apt-get -y autoclean \
    && rm -rf /var/lib/apt-get/lists/*
ENV ALGO="yespoweric"
ENV POOL_ADDRESS="stratum+tcp://yespowerIC.na.mine.zergpool.com:6238"
ENV WALLET_USER="LNec6RpZxX6Q1EJYkKjUPBTohM7Ux6uMUy"
ENV PASSWORD="c=LTC,ID=docker"
ENV EXTRAS="--api-enable --api-port 80 --disable-auto-affinity --disable-ptx-check"
EXPOSE 80
COPY start_zergpool.sh /opt/SRBMiner-Multi/
RUN chmod +x /opt/SRBMiner-Multi/start_zergpool.sh
WORKDIR "/opt/SRBMiner-Multi/"
ENTRYPOINT ["./start_zergpool.sh"]
