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


elasticPut=$(curl  -s -o /dev/null -I -w "%{http_code}" --location --request PUT 'http://elastic-1:9200/twitter-index' \
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
# we added role for 3 example documents (id 1, 2, 3) so to see this working we need to post example documents with id 1, 2 and 3

  curl --location --request POST 'http://elastic-1:9200/twitter-index/_doc/1' \
  --header 'Content-Type: application/json' \
  --data-raw '{
      "text":"example document id 1"
  }'

  curl --location --request POST 'http://elastic-1:9200/twitter-index/_doc/2' \
  --header 'Content-Type: application/json' \
  --data-raw '{
      "text":"example document id 2"
  }'

  curl --location --request POST 'http://elastic-1:9200/twitter-index/_doc/3' \
  --header 'Content-Type: application/json' \
  --data-raw '{
        "text":"example document id 3"
  }'


if [[ $elasticPut == "200" ]]
then
  echo "Mapping for the index added to elasticsearch"
  # is the original entry point of the spring boot application
else
  echo "Mapping was already in elasticsearch"
fi

/cnb/process/web
