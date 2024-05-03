FROM debian:12-slim

RUN apt-get update \
    && apt-get upgrade \
    && apt-get install --no-install-recommends -y software-properties-common wget sudo \
    && wget -O- "https://keyserver.ubuntu.com/pks/lookup?fingerprint=on&op=get&search=0x6125E2A8C77F2818FB7BD15B93C4A3FD7BB9C367" | gpg --dearmour -o /usr/share/keyrings/ansible-archive-keyring.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/ansible-archive-keyring.gpg] http://ppa.launchpad.net/ansible/ansible/ubuntu jammy main" | tee /etc/apt/sources.list.d/ansible.list \
    && apt-get update \
    && apt-get install --no-install-recommends -y ansible \
    && rm -rf /var/lib/apt/lists/*

RUN groupadd --gid 1000 przemek \
    && useradd --uid 1000 --gid 1000 --create-home przemek \
    && echo przemek ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/przemek

USER przemek
WORKDIR /home/przemek

COPY . .
