package com.microservices.kafka.streams.service.api;

import com.microservices.kafka.streams.service.model.KafkaStreamsResponseModel;
import com.microservices.kafka.streams.service.runner.StreamsRunner;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.validation.constraints.NotEmpty;

@PreAuthorize("isAuthenticated()")
@RestController
@RequestMapping(value = "/", produces = "application/vnd.api.v1+json")
public class KafkaStreamsController {

    private static final Logger LOG = LoggerFactory.getLogger(KafkaStreamsController.class);

    private final StreamsRunner<String, Long> kafkaStreamsRunner;

    public KafkaStreamsController(StreamsRunner<String, Long> streamsRunner) {
        this.kafkaStreamsRunner = streamsRunner;
    }

    @GetMapping("get-word-count-by-word/{word}")
    @Operation(summary = "Get word count by word.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Success.", content = {
                    @Content(mediaType = "application/vnd.api.v1+json",
                            schema = @Schema(implementation = KafkaStreamsResponseModel.class))
            }),
            @ApiResponse(responseCode = "400", description = "Not found."),
            @ApiResponse(responseCode = "500", description = "Unexpected error.")})
    public @ResponseBody
    ResponseEntity<KafkaStreamsResponseModel> getWordCountByWord(
            @PathVariable @NotEmpty String word) {
        Long wordCount = kafkaStreamsRunner.getValueByKey(word);
        LOG.info("Word count {} returned for word {}", wordCount, word);
        return ResponseEntity.ok(KafkaStreamsResponseModel.builder()
                .word(word)
                .wordCount(wordCount)
                .build());
    }
}
