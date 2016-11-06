#!/bin/sh

# aws route53 list-hosted-zones | jq '.HostedZones[] | {Name , Id }'

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <hosted_zone_id> <record_name>" >&2
  exit 1
fi
hosted_zone_id=$1
record_name=$2

public_ip=`dig TXT +short o-o.myaddr.l.google.com @ns1.google.com | awk -F'"' '{ print $2}'`
if [ -z $public_ip ] ;then
  echo "failed to get public ip"
  exit 1
fi

current_ip=`dig $record_name +short`
if [ "$current_ip" = "$public_ip" ]; then
  exit 0
fi;

cat <<EOF > /tmp/recordset.json
{
  "Comment": "create A record",
  "Changes": [ {
    "Action": "UPSERT",
    "ResourceRecordSet": {
      "Name": "${record_name}",
      "Type": "A",
      "TTL": 3600 ,
      "ResourceRecords": [ { "Value": "${public_ip}" } ]
    }
  }]
}
EOF

aws route53 change-resource-record-sets --hosted-zone-id $hosted_zone_id --change-batch file:///tmp/recordset.json
rm -rf /tmp/recordset.json

exit 0
