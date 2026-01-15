#! /usr/bin/env bash

## swap the 2 external monitors on VMWare Fusion

CONF=$1
TMP="$(mktemp)"

sed \
  -e 's/Virtual-2/__TMP__/g' \
  -e 's/Virtual-3/Virtual-2/g' \
  -e 's/__TMP__/Virtual-3/g' \
  "$CONF" > "$TMP" && mv "$TMP" "$CONF"

