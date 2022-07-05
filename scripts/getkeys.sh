#!/bin/sh

# Usage:
# ./getkeys.sh >> ~/.ssh/authorized_keys

getkey() {
while read url;
do
echo '#' $url
curl "$url.keys"
echo
done
}

echo https://github.com/aeifn | getkey
echo https://github.com/viviag | getkey
curl https://api.github.com/repos/nikita-volkov/hasql/contributors | grep html_url | awk '{print $2}' | tr -d '",' | getkey
