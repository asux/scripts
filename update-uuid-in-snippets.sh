#!/bin/sh
# vim: ft=shell
for uuid in $(egrep -ho '[-0-9A-F]{36}' Snippets/*.tmSnippet); do
  new_uuid=$(uuidgen | tr '[:lower:]' '[:upper:]')
  sed -i "s/${uuid}/${new_uuid}/g" info.plist Snippets/*.tmSnippet
done