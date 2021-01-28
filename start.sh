#!/bin/sh

set -u

ln -s /config /root/.spotify-ripper
/bin/sh -c 'PYTHONIOENCODING=UTF-8 /usr/local/bin/spotify-ripper "${0}" "$@"' -- "$@"
