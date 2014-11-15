#!/bin/bash

set -e

GRAFANA_JS="/srv/grafana/config.js"

sed -i 's/{{ELASTICSEARCH_HOST}}/'"${ELASTICSEARCH_HOST}"'/' ${GRAFANA_JS}
sed -i 's/{{ELASTICSEARCH_PORT}}/'"${ELASTICSEARCH_PORT}"'/' ${GRAFANA_JS}
sed -i 's/{{ELASTICSEARCH_INDEX}}/'"${ELASTICSEARCH_INDEX}"'/' ${GRAFANA_JS}

sed -i 's/{{GRAPHITE_HOST}}/'"${GRAPHITE_HOST}"'/' ${GRAFANA_JS}
sed -i 's/{{GRAPHITE_PORT}}/'"${GRAPHITE_PORT}"'/' ${GRAFANA_JS}

/usr/sbin/nginx -c /etc/nginx/nginx.conf