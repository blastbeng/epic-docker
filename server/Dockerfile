FROM debian:bullseye

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        wget \
        curl \
        libncurses5 \
        libncursesw5 \
        libncursesw6 \
        zlib1g \
        openssl

RUN wget https://d1ftoepmu0es39.cloudfront.net/librandomx_1.0.0-3_amd64.deb
RUN dpkg -i librandomx*.deb

RUN useradd -u 1000 -G sudo -U -m -s /bin/bash epicuser \
  && echo "epicuser ALL=(ALL) NOPASSWD: /bin/chown" >> /etc/sudoers

COPY get_latest.sh .

ARG EPIC_SERVER_LATEST=

RUN wget "$(bash get_latest.sh)" && dpkg -i epic*amd64.deb

WORKDIR /home/epicuser

USER epicuser

RUN mkdir -p /home/epicuser/.epic/main && cd /home/epicuser/.epic/main && /usr/bin/epic server config

COPY --chown=epicuser:epicuser entrypoint.sh .

RUN sed -i 's/127.0.0.1/0.0.0.0/' /home/epicuser/.epic/main/epic-server.toml

RUN sed -i 's/run_tui = true/run_tui = false/' /home/epicuser/.epic/main/epic-server.toml

RUN sed -i 's/log_to_file = true/log_to_file = false/' /home/epicuser/.epic/main/epic-server.toml

RUN chmod +x entrypoint.sh

CMD ["./entrypoint.sh"]