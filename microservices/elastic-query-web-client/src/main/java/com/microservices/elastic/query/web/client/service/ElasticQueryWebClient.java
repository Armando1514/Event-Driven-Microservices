package com.microservices.elastic.query.web.client.service;



import com.microservices.elastic.query.client.model.ElasticQueryWebClientAnalyticsResponseModel;
import com.microservices.elastic.query.client.model.ElasticQueryWebClientRequestModel;


public interface ElasticQueryWebClient {
    ElasticQueryWebClientAnalyticsResponseModel getDataByText(ElasticQueryWebClientRequestModel requestModel);
}
