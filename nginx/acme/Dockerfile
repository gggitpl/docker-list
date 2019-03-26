FROM neilpang/acme.sh

COPY ./_entry.sh /_entry.sh
RUN chmod +x /_entry.sh

ENTRYPOINT ["/_entry.sh"]