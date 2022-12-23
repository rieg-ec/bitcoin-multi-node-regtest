FROM debian:bullseye-slim

ARG ARCH=aarch64-linux-gnu
ARG VERSION=24.0.1

RUN apt-get update

RUN apt-get -y install curl

RUN curl -SL -o bitcoin.tar.gz https://bitcoincore.org/bin/bitcoin-core-$VERSION/bitcoin-$VERSION-$ARCH.tar.gz
RUN tar -xvf ./bitcoin.tar.gz

RUN rm /bitcoin-$VERSION/bin/bitcoin-qt

RUN ln -s /bitcoin-$VERSION/bin/bitcoin-cli /bin/bitcoin-cli
RUN ln -s /bitcoin-$VERSION/bin/bitcoind /bin/bitcoind
RUN chmod +x /bitcoin-$VERSION/bin/bitcoin-cli
RUN chmod +x /bitcoin-$VERSION/bin/bitcoind

ENV PATH="/bin:${PATH}"

RUN mkdir /root/.bitcoin
COPY bitcoin.conf /root/.bitcoin/bitcoin.conf

# rpc
EXPOSE 18444/tcp
# p2p
EXPOSE 18443/tcp

RUN bitcoind -version | grep "Bitcoin Core version v${BITCOIN_VERSION}"

# ENTRYPOINT ["bitcoind", "-regtest",  "-printtoconsole"]
CMD ["/bin/bash"]
