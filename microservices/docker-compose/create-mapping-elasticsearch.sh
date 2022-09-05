#!/bin/bash

apt-get update -y

yes | apt-get install curl

curlResult=$(curl -s -o /dev/null -I -w "%{http_code}" http://elastic-1:9200)

echo "result status code:" "$curlResult"

while [[ ! $curlResult == "200" ]]; do
  >&2 echo "Elasticsearch is not up yet!"
  sleep 2
  curlResult=$(curl -s -o /dev/null -I -w "%{http_code}" http://elastic-1:9200)
done


elasticPut=$(curl -s -o /dev/null -I -w "%{http_code}" --location --request PUT 'http://elastic-1:9200/twitter-index' \
                                                       --header 'Content-Type: application/json' \
                                                       --data-raw '{
                                                           "mappings": {
                                                               "properties": {
                                                                   "userId": {
                                                                       "type": "long"
                                                                   },
                                                                   "id": {
                                                                       "type": "text",
                                                                       "fields": {
                                                                           "keyword": {
                                                                               "type": "keyword",
                                                                               "ignore_above": 256
                                                                           }
                                                                       }
                                                                   },
                                                                   "createdAt": {
                                                                       "type": "date",
                                                       		"format": "yyyy-MM-dd'\''T'\''HH:mm:ssZZ"
                                                                   },
                                                                   "text": {
                                                                       "type": "text",
                                                                       "fields": {
                                                                           "keyword": {
                                                                               "type": "keyword",
                                                                               "ignore_above": 256
                                                                           }
                                                                       }
                                                                   }
                                                               }
                                                           }
                                                       }')



if [[ $elasticPut == "200" ]]
then
  echo "Mapping for the index added to elasticsearch"
  # is the original entry point of the spring boot application
  /cnb/process/web
else
  echo "Mapping Failed for elasticsearch"
  exit 1
fi

