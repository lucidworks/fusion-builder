#!/bin/bash
set -e

if [[ "$VERBOSE" = "yes" ]]; then
    set -x
fi

if [ "${1:0:1}" = '-' ]; then
    set -- /usr/sbin/sshd -D
fi

if [[ ! -z "$INITDB" && "$INITDB" != 'no' ]]; then
    # execute files in /docker-entrypoint-initdb.d
    shopt -s nullglob
    for f in /docker-entrypoint-initdb.d/*; do
        case "$f" in
            *.sh)     echo "$0: running $f"; . "$f" ;;
            *)        echo "$0: ignoring $f" ;;
        esac
        echo
    done
fi

exec "$@"
