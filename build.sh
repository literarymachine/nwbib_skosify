#!/bin/bash
curl "193.30.112.134/F?func=file&file_name=systematik_js&local_base=NWBIB" \
| sed 's/&....;//g' ../../data/nwbib.html \
| tidy -i -asxml -raw - \
| xsltproc html_to_skos.xslt - \
| rapper -o turtle - '#'
