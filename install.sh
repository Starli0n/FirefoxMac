#!/bin/sh
# https://stackoverflow.com/a/62079236
ls -d *.app | xargs xattr -r -d com.apple.quarantine
