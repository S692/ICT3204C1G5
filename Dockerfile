FROM sebp/elk
RUN apt-get update
RUN apt-get install -y net-tools
RUN apt-get install -y systemd
RUN apt-get install -y nano
RUN apt-get install -y sudo

# For metricbeat stack monitoring 
RUN echo "monitoring.ui.enabled: true" >> /opt/kibana/config/kibana.yml
RUN service kibana restart
RUN echo "xpack.monitoring.collection.enabled" >> /etc/elasticsearch/elasticsearch.yml
RUN echo "xpack.monitoring.elasticsearch.collection.enabled: false"

# Install Metricbeat
RUN curl -L -O https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-8.3.3-amd64.deb
RUN sudo dpkg -i metricbeat-8.3.3-amd64.deb
RUN wget https://raw.githubusercontent.com/S692/ossas/shah/metricbeat/metricbeat.yml -O /etc/metricbeat/metricbeat.yml
RUN metricbeat modules enable elasticsearch-xpack

# Run Metricbeat
RUN service metricbeat start
RUN metricbeat setup

EXPOSE 22 
