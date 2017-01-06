#!/bin/bash

# url configuration
URL="https://mcmilk.de/"

# begin new sitemap
exec 1> sitemap.xml

# print head
echo '<?xml version="1.0" encoding="UTF-8"?>'
echo '<!-- generator="Milkys Sitemap Generator, https://github.com/mcmilk/sitemap-generator" -->'
echo '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">'

# print urls
IFS=$'\r\n' GLOBIGNORE='*' command eval "OPTIONS=($(cat $0.options))"
find . -type f "${OPTIONS[@]}" -printf "%TY-%Tm-%Td %TH:%TM %p\n" | \
while read -r line; do
  # TIME is ignored...
  DATE=${line:0:10}
  TIME=${line:11:5}
  FILE=${line:19}
  echo "<url>"
  echo " <loc>${URL}${FILE}</loc>"
  echo " <lastmod>${DATE}</lastmod>"
  echo " <changefreq>weekly</changefreq>"
  echo "</url>"
done

# print foot
echo "</urlset>"
