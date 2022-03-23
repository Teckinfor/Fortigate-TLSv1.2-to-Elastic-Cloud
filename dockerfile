# syntax=docker/dockerfile:1
FROM ubuntu:latest
WORKDIR /home
RUN apt update && apt install -y syslog-ng openssl wget
RUN wget https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-8.0.0-amd64.deb
RUN dpkg -i filebeat-8.0.0-amd64.deb
RUN rm -f /etc/filebeat/filebeat.yml
WORKDIR /etc/filebeat/
COPY filebeat.yml filebeat.save
COPY filebeat.yml filebeat.yml
RUN chmod go-w filebeat.yml
WORKDIR /etc/syslog-ng/conf.d/
COPY generic.conf generic.conf
WORKDIR /etc/filebeat/modules.d/
COPY fortinet.yml fortinet.yml
RUN chmod go-w fortinet.yml
WORKDIR /home
COPY autorun.sh autorun.sh
COPY generate_cert.sh generate_cert.sh
RUN chmod +x autorun.sh
RUN chmod +x generate_cert.sh
EXPOSE 5695
CMD ["/home/autorun.sh"]
