#!/bin/sh

set -u

/bin/sh -c 'PYTHONIOENCODING=UTF-8 /usr/local/bin/spotify-ripper "$@"' -- "$@"
