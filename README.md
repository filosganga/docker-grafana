Grafana Docker Image
====================
This image provids a grafana installation depending on Grafite and Elasticsearch. Grafana i spowered by nginx.

## Environment Variables
This image expects environment variables for elasticsearch (Used to store dashboards) and graphite (Used as datasource).

Elasticsearch:
 - ELASTICSEARCH_HOST: The elasticsearch host.
 - ELASTICSEARCH_PORT: The elasticsearch port.
 - ELASTICSEARCH_INDEX: The elasticsearch index where the dashboards will be stored.

Graphite:
 - GRAPHITE_HOST: The graphite host.
 - GRAPHITE_PORT: The graphite port.

 ## Volumes
 this image expose these volumes:

  - "/srv/grafana": The grafana root directory.
  - "/etc/nginx": The nginx conf directory.
  - "/etc/logrotate.d": The logrotate additional settings directory.
  - "/var/log": The system log directory.

