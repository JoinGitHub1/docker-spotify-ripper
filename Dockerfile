FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

# codecs: lame, flac, vorbis, fdkaac to support mp3, flac, ogg, aac
RUN apt-get -qq update && \
    apt-get -qq install -y curl wget apt-transport-https gnupg && \
    curl -sL http://apt.mopidy.com/mopidy.gpg | apt-key add - && \
    wget -q -O /etc/apt/sources.list.d/mopidy.list https://apt.mopidy.com/stretch.list && \
    apt-get -qq update && \
    apt-get -qq install -y libspotify12 libspotify-dev python python-idna python-pkg-resources libffi-dev python-pip python-dev lame flac vorbis-tools fdkaac && \
    mkdir /usr/src/spotify-ripper && \
    curl -sL https://api.github.com/repos/sebastian-albers/spotify-ripper/tarball | tar xz -C /usr/src/spotify-ripper --strip-components=1 && \
    pip install --upgrade pip && \
    cd /usr/src/spotify-ripper && pip install --upgrade . && \
    apt-get -qq --purge autoremove -y libffi-dev python-pip python-dev libspotify-dev curl wget apt-transport-https gnupg && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /etc/apt/sources.list.d/mopidy.list && \
    rm -rf /tmp/* /usr/src/spotify-ripper

RUN mkdir /config /music
VOLUME ["/config", "/music"]

WORKDIR /music

COPY start.sh /usr/bin/start-spotify-ripper
COPY debug.sh /usr/bin/debug-spotify-ripper
ENTRYPOINT ["/usr/bin/start-spotify-ripper"]

