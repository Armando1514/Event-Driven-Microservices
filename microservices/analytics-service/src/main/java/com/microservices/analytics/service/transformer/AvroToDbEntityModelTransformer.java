package com.microservices.analytics.service.transformer;

import com.microservices.analytics.service.dataaccess.entity.AnalyticsEntity;
import com.microservices.kafka.avro.model.TwitterAnalyticsAvroModel;
import org.springframework.stereotype.Component;

import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.util.List;
import java.util.UUID;

import static java.util.stream.Collectors.toList;

@Component
public class AvroToDbEntityModelTransformer {



    public List<AnalyticsEntity> getEntityModel(List<TwitterAnalyticsAvroModel> avroModels) {
        return avroModels.stream()
                .map(avroModel -> new AnalyticsEntity(
                        UUID.randomUUID()
                        , avroModel.getWord()
                        , avroModel.getWordCount()
                        , LocalDateTime.ofInstant(Instant.ofEpochSecond(avroModel.getCreatedAt()), ZoneOffset.UTC)))
                .collect(toList());
    }


}
