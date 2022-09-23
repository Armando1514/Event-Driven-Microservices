package com.microservices.elastic.query.web.client.service;



import com.microservices.elastic.query.web.client.model.ElasticQueryWebClientAnalyticsResponseModel;
import com.microservices.elastic.query.web.client.model.ElasticQueryWebClientRequestModel;


public interface ElasticQueryWebClient {
    ElasticQueryWebClientAnalyticsResponseModel getDataByText(ElasticQueryWebClientRequestModel requestModel);
}
