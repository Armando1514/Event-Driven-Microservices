package com.microservices.elastic.query.web.client.service;


import com.microservices.elastic.query.client.model.ElasticQueryWebClientRequestModel;
import com.microservices.elastic.query.client.model.ElasticQueryWebClientResponseModel;

import java.util.List;


public interface ElasticQueryWebClient {
    List<ElasticQueryWebClientResponseModel> getDataByText(ElasticQueryWebClientRequestModel requestModel);
}
