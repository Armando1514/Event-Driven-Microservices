package com.microservices.elastic.index.client.service.impl;

import com.microservices.config.ElasticConfigData;
import com.microservices.elastic.index.client.service.ElasticIndexClient;
import com.microservices.elastic.index.client.util.ElasticIndexUtil;
import com.microservices.elastic.model.index.impl.TwitterIndexModel;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.data.elasticsearch.core.ElasticsearchOperations;
import org.springframework.data.elasticsearch.core.IndexedObjectInformation;
import org.springframework.data.elasticsearch.core.mapping.IndexCoordinates;
import org.springframework.data.elasticsearch.core.query.IndexQuery;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

//  DOES THE SAME OF TWITTERELASTICREPOSITORYINDEXCLIENT CLASS BUT WITH MORE CONTROL ON THE QUERY BUILD BECAUSE WE SAY AT LOW LEVEL HOW TO MAP THE IDs WITH THE UTIL CLASS ELASTICINDEXUTIL.
/*
a.) ElasticsearchRepository provides convenient methods like save, find etc.

b.) ElasticsearchOperations gives chance of running low level queries like elasticsearch bool, must etc.

c.) ElasticsearchOperations requires to convert the input object to query objects
*/
@Service
@ConditionalOnProperty(name = "elastic-config.is-repository", havingValue = "false")
public class TwitterElasticIndexClient implements ElasticIndexClient<TwitterIndexModel> {

    private static final Logger LOG = LoggerFactory.getLogger(TwitterElasticIndexClient.class);

    private final ElasticConfigData elasticConfigData;

    private final ElasticsearchOperations elasticsearchOperations;

    private final ElasticIndexUtil<TwitterIndexModel> elasticIndexUtil;

    public TwitterElasticIndexClient(ElasticConfigData configData,
                                     ElasticsearchOperations elasticOperations,
                                     ElasticIndexUtil<TwitterIndexModel> indexUtil) {
        this.elasticConfigData = configData;
        this.elasticsearchOperations = elasticOperations;
        this.elasticIndexUtil = indexUtil;
    }

    @Override
    public List<String> save(List<TwitterIndexModel> documents) {
        List<IndexQuery> indexQueries = elasticIndexUtil.getIndexQueries(documents);
        List<String> documentIds = elasticsearchOperations.bulkIndex(
                indexQueries,
                IndexCoordinates.of(elasticConfigData.getIndexName())
        ).stream().map(IndexedObjectInformation::getId).collect(Collectors.toList());
        LOG.info("Documents indexed successfully with type: {} and ids: {}", TwitterIndexModel.class.getName(),
                documentIds);
        return documentIds;
    }
}
