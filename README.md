# Fortigate-TLSv1.2-to-Elastic-Cloud
Dockerfile allowing to easily set up the monitoring of a FortiGate in a secure way.

The creation of the image works like this:

1. Creating a syslog-ng server
2. Configure the server to establish a TLSv1.2 connection
3. Opening the required ports
4. Redirect the logs to filebeat, then to Elastic Cloud

## How to use ?

### Installation
1. ```docker pull teckinfor/fortigatetlstoelk```
2. ```docker create -e CLOUD_ID=*cloud_ID* -e CLOUD_PASSWORD=*elastic password* --name=FortigateLogs -p 5695:5695 teckinfor/fortigatetlstoelk```
3. ```docker start FortigateLogs```

### Generate certificates
1. ```docker exec -it FortigateLogs bash```
2. ```./generate_cert.sh```
3. ```service syslog-ng start``` (This is the only time you will need to activate the service manually)
4. ```exit``` to leave the container
5. ```docker cp FortigateLogs:/etc/syslog-ng/cert.d/syslog.crt .``` to download the CA
6. Upload the CA in the Fortigate : **System > Certificates > Create/Import > CA Certificate**
7. Open a FortiOS CLI
8. ```config log syslogd setting```
    1. ```set status enable```
    2. ```set server *IP*```
    3. ```set port 5695```
    4. ```set mode reliable```
    5. ```set enc-algorithm high```
    6. ```end```
9. Wait a few minutes and you should have the logs on elasticsearch. If not, be sure that Kibana has been set up for filebeat (filebeat setup).
