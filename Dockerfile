FROM alpine:latest
MAINTAINER Matt Bentley <mbentley@mbentley.net>

RUN apk add --no-cache curl jq

COPY get_ucp_logs.sh /get_ucp_logs.sh

CMD ["/get_ucp_logs.sh"]
