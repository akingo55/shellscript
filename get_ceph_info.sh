#!/bin/bash
#get ceph info
ceph_node_info=$(ceph node ls all -f json)
#timestamp for elasticsearch
date=`echo $(date "+%Y-%m-%dT%H:%M:%S.%3NZ")`
#date for index
date2=`echo $(date "+%Y-%m-%d-%H:%M")`

#setting of import data
index= '{"index":{"_index":"osd_'${date2}'","_type":"host_mapping"}}'
echo $index > result.json
echo '{"@timestamp":"'${date}'","ceph":['${ceph_node_info}']}' >> result.json

#send ceph info to elasticsearch
curl -s -H "Content_Type:application/json" -XPOST 'http://xxx.xx.xx.xx:9200/_bulk' --data-binary@result.json

