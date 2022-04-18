FROM rust:latest as build
ARG BRANCH=develop
WORKDIR /build
RUN cargo version

RUN git clone https://github.com/cjdelisle/packetcrypt_rs --branch ${BRANCH} \
    && cd packetcrypt_rs \
    && cargo build --release


FROM gcr.io/distroless/cc
COPY --from=build /build/packetcrypt_rs/target/release/packetcrypt /
ENTRYPOINT ["/packetcrypt"]
CMD [ "ann", "-p", "pkt1qzegnutrt6x4yr6xf9salt9rrzr9ywk8nhtrwat", "http://pool.pkt.world/master/2048 http://pool.pktpool.io" ]
