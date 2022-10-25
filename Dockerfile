FROM sebp/elk
RUN apt-get update
RUN apt-get install -y net-tools
RUN apt-get install -y systemd
RUN apt-get install -y nano
RUN apt-get install -y sudo
RUN apt-get install -y wget

# For metricbeat stack monitoring 
RUN echo "monitoring.ui.enabled: true" >> /opt/kibana/config/kibana.yml
RUN service kibana restart
RUN echo "xpack.monitoring.collection.enabled: true" >> /etc/elasticsearch/elasticsearch.yml
RUN echo "xpack.monitoring.elasticsearch.collection.enabled: false" >> /etc/elasticsearch/elasticsearch.yml
RUN service elasticsearch restart

# Install Metricbeat
RUN curl -L -O https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-8.3.3-amd64.deb
RUN sudo dpkg -i metricbeat-8.3.3-amd64.deb
RUN wget https://raw.githubusercontent.com/S692/ICT3204C1G5/main/metricbeat/metricbeat.yml -O /etc/metricbeat/metricbeat.yml
RUN metricbeat modules enable elasticsearch-xpack

EXPOSE 22 
