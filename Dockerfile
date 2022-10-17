FROM sebp/elk
RUN apt-get update
RUN apt-get install -y net-tools
RUN apt-get install -y systemd
RUN apt-get install -y nano
RUN apt-get install -y sudo
EXPOSE 22 
