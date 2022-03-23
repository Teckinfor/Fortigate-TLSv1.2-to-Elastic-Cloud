openssl req -x509 -newkey rsa:2048 -sha256 -days 1096 -nodes -keyout syslog.key -out syslog.crt -subj "/CN=syslog.elastic.be/C=BE/O=Elastic.net";
echo Certificate created;
mkdir /etc/syslog-ng/cert.d/;
mv syslog.* /etc/syslog-ng/cert.d/;
echo Certificate moved;