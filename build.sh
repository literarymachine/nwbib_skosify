#!/bin/bash
curl "193.30.112.134/F?func=file&file_name=systematik_js&local_base=NWBIB" \
| sed 's/&....;//g' ../../data/nwbib.html \
| tidy -i -asxml -raw - \
| xsltproc html_to_skos.xslt - \
| rapper - '#' \
| tee /tmp/nwbib.nt \
| roqet -i sparql -e "CONSTRUCT { ?narrower <http://www.w3.org/2004/02/skos/core#broader> ?broader} WHERE { ?broader <http://www.w3.org/2004/02/skos/core#narrower> ?narrower}" -D - >> /tmp/nwbib.nt

rapper -i ntriples -o turtle /tmp/nwbib.nt

rm /tmp/nwbib.nt
