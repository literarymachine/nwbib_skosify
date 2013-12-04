#!/bin/bash

if [ "$1" == "sachsystematik" ]
then
  curl "193.30.112.134/F?func=file&file_name=systematik_js&local_base=NWBIB" \
  | sed -e 's/&....;//g' \
  | tidy -i -asxml -raw - \
  | xsltproc html_to_skos_sachsystematik.xslt - \
  | rapper - '#' \
  | tee /tmp/nwbib.nt \
  | roqet -i sparql -e "CONSTRUCT { ?narrower <http://www.w3.org/2004/02/skos/core#broader> ?broader} WHERE { ?broader <http://www.w3.org/2004/02/skos/core#narrower> ?narrower}" -D - >> /tmp/nwbib.nt

  rapper -i ntriples -o turtle /tmp/nwbib.nt
  rm /tmp/nwbib.nt
elif [ "$1" == "raumsystematik" ]
then
  curl "193.30.112.134/F?func=file&file_name=systematik_js&local_base=NWBIB" \
  | sed -e 's/&....;//g' \
  | tidy -i -asxml -raw - \
  | xsltproc html_to_skos_raumsystematik.xslt - \
  | rapper -o turtle - '#'
fi
