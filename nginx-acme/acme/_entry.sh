#!/usr/bin/env sh

echo "ISSUE $LETSENCRYPT_HOST WITH DNS $LETSENCRYPT_DNS"

acme.sh --issue --dns $LETSENCRYPT_DNS -d $LETSENCRYPT_HOST -d *.$LETSENCRYPT_HOST

echo "RUN ORIGINAL entry.sh AS DAEMON"

/entry.sh daemon