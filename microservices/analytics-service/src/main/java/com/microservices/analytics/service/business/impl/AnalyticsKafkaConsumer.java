package com.microservices.analytics.service.business.impl;

import com.microservices.analytics.service.dataaccess.entity.AnalyticsEntity;
import com.microservices.analytics.service.dataaccess.repository.AnalyticsRepository;
import com.microservices.analytics.service.transformer.AvroToDbEntityModelTransformer;
import com.microservices.config.KafkaConfigData;
import com.microservices.kafka.admin.client.KafkaAdminClient;
import com.microservices.kafka.avro.model.TwitterAnalyticsAvroModel;
import com.microservices.kafka.service.consumer.KafkaConsumer;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.context.event.ApplicationStartedEvent;
import org.springframework.context.event.EventListener;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.kafka.config.KafkaListenerEndpointRegistry;
import org.springframework.kafka.support.KafkaHeaders;
import org.springframework.messaging.handler.annotation.Header;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AnalyticsKafkaConsumer implements KafkaConsumer<TwitterAnalyticsAvroModel> {

    private static final Logger LOG = LoggerFactory.getLogger(AnalyticsKafkaConsumer.class);

    private final KafkaListenerEndpointRegistry kafkaListenerEndpointRegistry;

    private final KafkaAdminClient kafkaAdminClient;

    private final KafkaConfigData kafkaConfig;

    private final AvroToDbEntityModelTransformer avroToDbEntityModelTransformer;

    private final AnalyticsRepository analyticsRepository;

    public AnalyticsKafkaConsumer(KafkaListenerEndpointRegistry registry,
                                  KafkaAdminClient adminClient,
                                  KafkaConfigData config,
                                  AvroToDbEntityModelTransformer transformer,
                                  AnalyticsRepository repository
                                  ) {
        this.kafkaListenerEndpointRegistry = registry;
        this.kafkaAdminClient = adminClient;
        this.kafkaConfig = config;
        this.avroToDbEntityModelTransformer = transformer;
        this.analyticsRepository = repository;
    }

    @EventListener
    public void onAppStarted(ApplicationStartedEvent event) {
        kafkaAdminClient.checkTopicsCreated();
        LOG.info("Topics with name {} is ready for operations!", kafkaConfig.getTopicNamesToCreate().toArray());
        kafkaListenerEndpointRegistry.getListenerContainer("twitterAnalyticsTopicListener").start();
    }

    @Override
    @KafkaListener(id = "twitterAnalyticsTopicListener", topics = "${kafka-config.topic-name}", autoStartup = "false")
    public void receive(@Payload  List<TwitterAnalyticsAvroModel> messages,
                        @Header(KafkaHeaders.RECEIVED_KEY) List<Long> keys,
                        @Header(KafkaHeaders.RECEIVED_PARTITION) List<Integer> partitions,
                        @Header(KafkaHeaders.OFFSET) List<Long> offsets) {
        LOG.info("{} number of message received with keys {}, partitions {} and offsets {}, " +
                        "sending it to database: Thread id {}",
                messages.size(),
                keys.toString(),
                partitions.toString(),
                offsets.toString(),
                Thread.currentThread().getId());
        List<AnalyticsEntity> twitterAnalyticsEntities = avroToDbEntityModelTransformer.getEntityModel(messages);
        analyticsRepository.batchPersist(twitterAnalyticsEntities);
        LOG.info("{} number of messaged send to database", twitterAnalyticsEntities.size());

    }

}
