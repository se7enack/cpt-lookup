FROM alpine
RUN mkdir -p /cpt
COPY cpt-lookup.sh /cpt
COPY latest.json /cpt
WORKDIR /cpt
RUN chmod +x cpt-lookup.sh
RUN apk add wget jq


ENTRYPOINT /bin/sh "./cpt-lookup.sh"


